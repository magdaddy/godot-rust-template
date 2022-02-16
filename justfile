set dotenv-load

_default:
  @just --list --unsorted

godot_exec := "/Applications/Godot.app/Contents/MacOS/Godot"
godot_proj_dir := "godot"
default_scene := "Scene.tscn"
project_name := `echo $PROJECT_NAME`
dylib := "lib" + project_name + ".dylib"
gdnlib := project_name + ".gdnlib"

build:
  cargo build
  cp target/debug/{{dylib}} {{godot_proj_dir}}

run scene=default_scene: build
  "{{godot_exec}}" --path "{{godot_proj_dir}}" "{{scene}}"

gde scene=default_scene:
  "{{godot_exec}}" --path "{{godot_proj_dir}}" --editor "{{scene}}"

# godot related

# create Rust class gdns file
gdns class_name:
  #!/usr/bin/env python3
  from string import Template
  with open("templates/rust_class.gdns") as file:
    out = Template(file.read()).substitute(class_name="{{class_name}}", gdnlib="{{gdnlib}}")
    with open("{{godot_proj_dir}}/gdns/{{class_name}}.gdns", "w") as fout:
      fout.write(out)
