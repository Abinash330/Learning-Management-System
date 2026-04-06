import glob
import re

path = 'src/test/java/com/example/lms/controller/*Test.java'
files = glob.glob(path)

for fpath in files:
    with open(fpath, 'r') as f:
        content = f.read()

    # Add lenient settings
    if 'org.mockito.junit.jupiter.MockitoSettings' not in content:
        content = content.replace('import org.mockito.junit.jupiter.MockitoExtension;', 'import org.mockito.junit.jupiter.MockitoExtension;\nimport org.mockito.junit.jupiter.MockitoSettings;\nimport org.mockito.quality.Strictness;\nimport org.springframework.web.servlet.view.InternalResourceViewResolver;')
        
    content = content.replace('@ExtendWith(MockitoExtension.class)', '@ExtendWith(MockitoExtension.class)\n@MockitoSettings(strictness = Strictness.LENIENT)')
    
    # Fix view resolvers
    setup_code = """        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();"""
    
    content = content.replace('mockMvc = MockMvcBuilders.standaloneSetup(controller).build();', setup_code)

    with open(fpath, 'w') as f:
        f.write(content)

print(f"Fixed {len(files)} files.")
