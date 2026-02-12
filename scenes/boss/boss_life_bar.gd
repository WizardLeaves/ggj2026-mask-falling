extends ProgressBar

# 可在编辑器修改：true=中心对齐，false=左上角对齐
@export var is_center_align: bool = false

func _ready():
	# 首次对齐坐
	pass

# 可选：如果父节点Node2D会动态移动，调用此函数实时更新（如在_process中）
func _process(_delta):
	#align_with_parent_node2d()
	pass


# 核心：与父节点Node2D坐标对齐
func align_with_parent():
	# 获取父节点（确保父节点是Node2D）
	var parent_node2d = get_parent()
	# 1. 将Node2D的全局坐标转为UI画布坐标
	var ui_target_pos = parent_node2d.position + Vector2(0, -300)
	# 2. 给Control赋值转换后的坐标，完成对齐
	position = ui_target_pos
	# print(position)
