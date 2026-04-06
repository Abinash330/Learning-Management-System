import os
import re

model_dir = r'd:\Seere_class\SpringBoot_class\lms\src\main\java\com\example\lms\model'

for filename in os.listdir(model_dir):
    if filename.endswith('.java'):
        filepath = os.path.join(model_dir, filename)
        with open(filepath, 'r') as f:
            content = f.read()
        
        if 'lombok' not in content: continue

        # Remove lombok imports
        content = re.sub(r'import\s+lombok\..*?;\s*', '', content)
        
        # Remove lombok annotations
        content = re.sub(r'@Data\s*', '', content)
        content = re.sub(r'@NoArgsConstructor\s*', '', content)
        content = re.sub(r'@AllArgsConstructor\s*', '', content)
        
        # Find class name
        class_match = re.search(r'public\s+class\s+(\w+)', content)
        if not class_match: continue
        class_name = class_match.group(1)
        
        # Find all fields
        fields = re.findall(r'private\s+([\w<>]+)\s+(\w+)\s*;', content)
        
        getters_setters = "\n"
        
        # Add NoArgsConstructor and AllArgsConstructor equivalent code
        getters_setters += f"    public {class_name}() {{}}\n"
        
        if fields:
            args = ", ".join([f"{t} {n}" for t, n in fields])
            assignments = "\n".join([f"        this.{n} = {n};" for t, n in fields])
            getters_setters += f"    public {class_name}({args}) {{\n{assignments}\n    }}\n"
        
        # Add getters and setters
        for t, n in fields:
            Capitalized = n[0].upper() + n[1:]
            getters_setters += f"    public {t} get{Capitalized}() {{ return {n}; }}\n"
            getters_setters += f"    public void set{Capitalized}({t} {n}) {{ this.{n} = {n}; }}\n"
        
        # Inject before last brace
        content = re.sub(r'}\s*$', getters_setters + '}\n', content)
        
        with open(filepath, 'w') as f:
            f.write(content)
        print(f"Processed {filename}")
