
# Create the pipeline
Run the playbook called apply.yaml for creating the pipeline ( -e @file ) needs to point to yaml file that describes pipeline for app

 ```
   cd testPipelineForApplications
   ansible-playbook -i inventory/ -e @apps/cool-store/cart-service.yaml generate.yaml
   ansible-playbook -i inventory/ -e @apps/cool-store/cart-service.yaml apply.yaml
 ```




