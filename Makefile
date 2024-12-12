OUTPUT_DIR = output
INPUT_FILE := ./shared/combined.md
LANGUAGES := en nl


all: cv resume
	# TODO: make these documents based of of sepperated files to then assemble into both files to prevent document duplication 
# cv:
# 	mkdir -p $(OUTPUT_DIR)
# 	pandoc --lua-filter=filter-lang.lua cv.md -f markdown+yaml_metadata_block --template templates/jb2resume.latex -o cv.pdf
# resume:
# 	pandoc -V lang=en -V ex=resume --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua --lua-filter columns.lua resume.md -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o resume.pdf
# test: 
# 	pandoc -V lang=en --metadata-file=resume.yaml --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua --lua-filter columns.lua ./shared/combined.md -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o resume.pdf
#
cv:
	mkdir -p $(OUTPUT_DIR)
	$(foreach lang,$(LANGUAGES),$(MAKE) $(lang)-cv.pdf;)

resume:
	mkdir -p $(OUTPUT_DIR)
	$(foreach lang,$(LANGUAGES),$(MAKE) $(lang)-resume.pdf;)

%-resume.pdf:
	cat ./shared/*.md | pandoc --metadata=lang=$* --metadata-file=resume.yaml --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua --lua-filter columns.lua -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o $(OUTPUT_DIR)/$@


%-cv.pdf:
	(for file in ./shared/*.md; do cat "$$file"; echo -e "\n"; done) | pandoc --metadata=lang=$* --metadata-file=cv.yaml --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o $(OUTPUT_DIR)/$@
