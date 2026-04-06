import glob

def fix_file(fpath, email):
    with open(fpath, 'r') as f:
        content = f.read()

    # Replace get/post mockMvc calls
    content = content.replace('get("/fdashboard")', f'get("/fdashboard").principal(() -> "{email}")')
    content = content.replace('get("/f-assignments")', f'get("/f-assignments").principal(() -> "{email}")')
    content = content.replace('post("/f-create-assignment")', f'post("/f-create-assignment").principal(() -> "{email}")')
    
    content = content.replace('get("/sdashboard")', f'get("/sdashboard").principal(() -> "{email}")')
    content = content.replace('get("/s-courses")', f'get("/s-courses").principal(() -> "{email}")')
    content = content.replace('post("/s-submit")', f'post("/s-submit").principal(() -> "{email}")')

    with open(fpath, 'w') as f:
        f.write(content)

fix_file('src/test/java/com/example/lms/controller/FacultyControllerTest.java', 'faculty@test.com')
fix_file('src/test/java/com/example/lms/controller/StudentControllerTest.java', 'student@test.com')

print("Fixed mockMvc perform with principal.")
