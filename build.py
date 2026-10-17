import os


def read_file(path):
    with open(path, "r", encoding="utf-8") as file:
        return file.read()


parts = [read_file("header.lua"), "\n\nlocal EmbeddedModules = {\n"]

for filename in sorted(os.listdir("modules")):
    module_path = os.path.join("modules", filename)
    if os.path.isfile(module_path):
        module_name = os.path.splitext(filename)[0]
        module_source = read_file(module_path)
        parts.append(f'["{module_name}"] = function()\n{module_source}\nend,\n')

parts.append("}\n")
parts.append(read_file("main.lua"))

output_dir = "result"
output_path = os.path.join(output_dir, "out.lua")

os.makedirs(output_dir, exist_ok=True)

with open(output_path, "w", encoding="utf-8") as out_file:
    out_file.write("".join(parts))