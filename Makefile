O =top_top#old_top
N =default_top_name#new_top

set_top:
	sed -i "s/$(O)/$(N)/g" ./*/*
	rename "s/$(O)/$(N)/g" ./*/*
