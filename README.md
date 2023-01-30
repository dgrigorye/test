# I cannot open and read
https://github.com/lilab-bcb/lilab-setup/blob/master/cumulus/custom.conf
so I don't know what is on line 33 or use this file in any way.

Way to use:
gsutil -m cp -r gs://terra-featured-workspaces/Cumulus/cellranger_output .

# This creates nice H5 files with different names to conveniently see them producing outputs with different names
python rename_h5.py -i cellranger_output -o .

# observe 8 pythons running in the background
java -Dconfig.file=custom.conf -jar cromwell.jar run single_cell.wdl -i input_many.json
