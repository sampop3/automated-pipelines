
# Create the pipeline
Run the playbook called apply.yaml for creating the pipeline ( -e @file ) needs to point to yaml file that describes pipeline for BaseImages

 ```
   cd singleProjectPipeline
   ansible-playbook -i inventory/ -e @inventory/group_vars/springboot.yaml apply.yaml
 ```



