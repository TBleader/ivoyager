# replace_me.gd
# This file is part of I, Voyager
# https://ivoyager.dev
# *****************************************************************************
# Copyright (c) 2017-2021 Charlie Whitfield
# I, Voyager is a registered trademark of Charlie Whitfield
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# *****************************************************************************
# This is an example "extension" file that changes some init values. See
# https://github.com/ivoyager/planetarium for a much more complex example.
#
# Requirements:
#    1. This file must have the same name as its directory + ".gd"
#    2. Must have the 3 constants below
#    3. Must have function "_extension_init"

const EXTENSION_NAME := "Replace Me!"
const EXTENSION_VERSION := "0.0.9-dev-3-31"
const EXTENSION_VERSION_YMD := 20210331 # int allows easy >= tests

const USE_THREADS := true # false can help threaded code debugging (e.g., I/O)

func _extension_init() -> void:
	prints(EXTENSION_NAME, EXTENSION_VERSION)
	print("Use threads = ", USE_THREADS)
	Global.connect("project_objects_instantiated", self, "_on_project_objects_instantiated")
	Global.connect("system_tree_ready", self, "_on_system_tree_ready")
	
	# Change global init values...
	Global.project_name = EXTENSION_NAME
	Global.project_version = EXTENSION_VERSION # helps load file debug
	Global.project_version_ymd = EXTENSION_VERSION_YMD # helps load file debug
	Global.save_file_extension = "MyProjectSave"
	Global.save_file_extension_name = "My Project Save"
	Global.start_body_name = "PLANET_MARS"
	Global.start_time = 21.12135 * UnitDefs.YEAR # from J2000 epoch
	Global.use_threads = USE_THREADS
	
	# Add or replace ProjectBuilder classes...
#	ProjectBuilder.gui_controls._ProjectGUI_ = MyTopGUIControl
	
	# You can extend and replace an existing class. For example, if ExtendedBody
	# extends Body, then this line would cause ExtendedBody to be used instead
	# of Body in the solar system build...
	# ProjectBuilder.procedural_classes._Body_ = ExtendedBody
	
	# "Program nodes" and "program reerences" are classes instantiated by
	# ProjectBuider. This line would add one of your own...
	# ProjectBuilder.program_nodes._MyProgramNode_ = MyProgramNode

func _on_project_objects_instantiated() -> void:
	# Here you can access and change init values for program nodes and
	# program references (for nodes, before they are added to the tree).
	var timekeeper: Timekeeper = Global.program.Timekeeper
	timekeeper.start_speed = 1
	var settings_manager: SettingsManager = Global.program.SettingsManager
	settings_manager.defaults.save_base_name = "Template"

func _on_system_tree_ready(_is_new_game: bool) -> void:
	# The solar system has been built or loaded, but we haven't started the
	# sim yet. See ivoyager/singletons/global.gd for more "state" signals.
	pass

