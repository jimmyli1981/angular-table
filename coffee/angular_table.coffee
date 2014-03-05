class ConfigurationVariableNames
  constructor: (@config_object_name) ->
    @items_per_page = "#{@config_object_name}.itemsPerPage"
    @sort_context = "#{@config_object_name}.sortContext"
    @fill_last_page = "#{@config_object_name}.fillLastPage"
    @max_pages = "#{@config_object_name}.maxPages"
    @current_page = "#{@config_object_name}.currentPage"

class ScopeConfigWrapper
  constructor: (@scope, @configuration_variable_names, @list_name) ->

  get_list: () ->
    @scope.$eval(@list_name)

  get_items_per_page: () ->
    @scope.$eval(@configuration_variable_names.items_per_page) || 10

  get_current_page: () ->
    @scope.$eval(@configuration_variable_names.current_page) || 0

  get_max_pages: () ->
    @scope.$eval(@configuration_variable_names.max_pages) || undefined

  get_sort_context: () ->
    @scope.$eval(@configuration_variable_names.sort_context) || 'global'

  set_current_page: (current_page) ->
    @scope.$eval("#{@configuration_variable_names.current_page}=#{current_page}")

angular.module "angular-table", []

irk_number_of_pages = "number_of_pages"

pagination_template = "
<div style='margin: 0px;'>
  <ul class='pagination'>
    <li ng-class='{disabled: get_current_page() <= 0}'>
      <a href='' ng-click='step_page(-#{irk_number_of_pages})'>First</a>
    </li>

    <li ng-show='show_sectioning()' ng-class='{disabled: get_current_page() <= 0}'>
      <a href='' ng-click='jump_back()'>&laquo;</a>
    </li>

    <li ng-class='{disabled: get_current_page() <= 0}'>
      <a href='' ng-click='step_page(-1)'>&lsaquo;</a>
    </li>

    <li ng-class='{active: get_current_page() == page}' ng-repeat='page in page_sequence.data'>
      <a href='' ng-click='go_to_page(page)'>{{page + 1}}</a>
    </li>

    <li ng-class='{disabled: get_current_page() >= #{irk_number_of_pages} - 1}'>
      <a href='' ng-click='step_page(1)'>&rsaquo;</a>
    </li>

    <li ng-show='show_sectioning()' ng-class='{disabled: get_current_page() >= #{irk_number_of_pages} - 1}'>
      <a href='' ng-click='jump_ahead()'>&raquo;</a>
    </li>

    <li ng-class='{disabled: get_current_page() >= #{irk_number_of_pages} - 1}'>
      <a href='' ng-click='step_page(#{irk_number_of_pages})'>Last</a>
    </li>
  </ul>
</div>"