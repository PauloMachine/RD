*** Variables ***
&{admin}
...         button_add=xpath://button[contains(.,"Add")]
...         select_user_role=xpath://label[text()="User Role"]//following::div[@class="oxd-select-text-input"][contains(.,"Select")]
...         input_employee_name=xpath://label[text()="Employee Name"]//following::input[@placeholder="Type for hints..."]
...         select_status=xpath://label[text()="Status"]//following::div[@class="oxd-select-text-input"][contains(.,"Select")]
...         select_option=xpath:(//*[contains(.,"option")])[1]
...         input_username=xpath:(//label[text()="Username"]//following::input)[1]
...         input_password=xpath:(//label[text()="Password"]//following::input)[1]
...         input_confirm_password=xpath:(//label[text()="Confirm Password"]//following::input)[1]
...         button_save=xpath://button[contains(.,"Save")]
...         toast_success=xpath:(//*[contains(.,"Success")])[1]
...         div_list_username=xpath://div[text()="username"]
...         input_search_username=xpath:(//h5[contains(.,"System Users")]//following::label[contains(.,"Username")]/following::input)[1]
...         button_search=xpath://button[contains(.,"Search")]
...         button_delete_admin_user=xpath://div[text()="username"]//ancestor::div//button/i[@class="oxd-icon bi-trash"]
...         button_yes_delete=xpath://button[contains(.,"Yes, Delete")]
