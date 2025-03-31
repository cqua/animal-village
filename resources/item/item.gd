extends Resource
class_name Item

enum ItemType {
	Artifact,
	Bug,
	Furniture,
	Gift,
	Tool,
	Trash
}

@export var name:String
@export var item_type:ItemType
@export var sprite:Texture2D
@export var stack_size:int = 64

static var NONE:Item
static var ARTIFACT_LIONSPAW:Item
static var TOOL_BUGNET:Item

static func load():
	ARTIFACT_LIONSPAW = load("res://resources/item/artifacts/artifact_lionspaw.tres")
	TOOL_BUGNET = load("res://resources/item/tool/tool_bugnet.tres")
