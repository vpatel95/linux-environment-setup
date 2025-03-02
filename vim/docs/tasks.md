## NPL Tasks

### Default Task Config

- Config will try to find out the git root of directory. If it cannot figure out
  the git root, it will default to SDK_DIR environment variable as the root for
  tasks.

- Default task config resides in [tasks.lua](../lua/config/tasks.lua) file. You can
adjust parameters as per your environment

### Build P4 or SDK Driver

To build P4/SDK Driver code

- run `<leader>or` to bring up the Overseer Run menu.
- Choose the task you want to run.
- A console log file will be created at root of SDK directory with prefix
  `build_`

### Run Test executor

To run the python tests

- run `<leader>or` to bring up the Overseer Run menu
- Choose `Test executor` task from the list
- This will bring up a form.
- Fill in the form
    - device : Device that you want to run test for
    - tests : Location of test file from relative to `shared/test/api` folder. 
    Example to run `shared/test/api/l2_acl/test_l2_acl.py`, tests field should
      be `l2_acl/test_l2_acl`


#### Overseer

For more details on tasks plugin visit
[overseer.nvim](https://github.com/stevearc/overseer.nvim)
