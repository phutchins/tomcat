# get stack name from node
stack = node['corndog']['stack']

# kick off stack recipe
run_context.include_recipe "corndog-chef::stack-#{stack}"
