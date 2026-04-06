import os
import glob
import re

path = 'src/test/java/com/example/lms/controller/*Test.java'
files = glob.glob(path)

for fpath in files:
    with open(fpath, 'r') as f:
        content = f.read()

    # Remove bad imports
    content = re.sub(r'import org\.springframework\.boot\.test\..+;\n', '', content)
    content = content.replace('import org.springframework.test.context.bean.override.mockito.MockitoBean;', '')

    # Add mockito extension and mockmvc builders
    content = content.replace('import org.springframework.test.web.servlet.MockMvc;', 
        'import org.springframework.test.web.servlet.MockMvc;\nimport org.springframework.test.web.servlet.setup.MockMvcBuilders;\nimport org.mockito.InjectMocks;\nimport org.mockito.Mock;\nimport org.mockito.junit.jupiter.MockitoExtension;\nimport org.junit.jupiter.api.extension.ExtendWith;\nimport org.junit.jupiter.api.BeforeEach;')
    
    # Replace annotations
    content = re.sub(r'@SpringBootTest\n', '', content)
    content = re.sub(r'@AutoConfigureMockMvc\n', '@ExtendWith(MockitoExtension.class)\n', content)
    
    # Replace @MockitoBean with @Mock
    content = content.replace('@MockitoBean', '@Mock')
    content = content.replace('@Autowired\n    private MockMvc mockMvc;', 'private MockMvc mockMvc;')

    # Find the class declaration to insert @InjectMocks and @BeforeEach
    class_match = re.search(r'public class (\w+Controller)Test \{', content)
    if class_match:
        controller_name = class_match.group(1)
        # Inject the controller
        inject_code = f"\n    @InjectMocks\n    private {controller_name} controller;\n\n    @BeforeEach\n    void setup() {{\n        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();\n    }}\n"
        
        # Insert after class opening
        content = content.replace(f"public class {controller_name}Test {{", f"public class {controller_name}Test {{{inject_code}")

    with open(fpath, 'w') as f:
        f.write(content)

print(f"Fixed {len(files)} files.")
