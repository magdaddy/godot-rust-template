_default:
  @just --list --unsorted

godot_exec := "/Applications/Godot.app/Contents/MacOS/Godot"
godot_proj_dir := "godot"
default_scene := "Scene.tscn"

build:
  cargo build

run scene=default_scene: build
  "{{godot_exec}}" --path "{{godot_proj_dir}}" "{{scene}}"

gde scene=default_scene:
  "{{godot_exec}}" --path "{{godot_proj_dir}}" --editor "{{scene}}"
