$ ->
  $('#contacts').dataTable
    sPaginationType: 'full_numbers'
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#contacts').data('src')
    aoColumns: [
      null,
      null,
      null,
      null,
      null,
      { bSortable: false }
    ]
