import os
import glob

# Path to tests
path = 'src/test/java/com/example/lms/controller/*Test.java'
files = glob.glob(path)

for fpath in files:
    with open(fpath, 'r') as f:
        content = f.read()
    
    content = content.replace('import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;', 
        'import org.springframework.boot.test.context.SpringBootTest;\nimport org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;')
    
    # We replace @WebMvcTest(Class.class) with @SpringBootTest ...
    import re
    content = re.sub(r'@WebMvcTest\(.*\)', '@SpringBootTest\n@AutoConfigureMockMvc', content)
    
    with open(fpath, 'w') as f:
        f.write(content)

print(f"Fixed {len(files)} files.")
