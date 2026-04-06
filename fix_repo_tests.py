import os
import glob

# Path to tests
path = 'src/test/java/com/example/lms/repository/*Test.java'
files = glob.glob(path)

for fpath in files:
    with open(fpath, 'r') as f:
        content = f.read()
    
    content = content.replace('import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;', 
        'import org.springframework.boot.test.context.SpringBootTest;\nimport org.springframework.transaction.annotation.Transactional;')
    content = content.replace('@DataJpaTest', '@SpringBootTest\n@Transactional')
    
    with open(fpath, 'w') as f:
        f.write(content)

print(f"Fixed {len(files)} files.")
