CLASS zbp_afe_header DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_abap_behv.
    INTERFACES if_abap_behv_auth.

    METHODS get_global_authorizations
      IMPORTING
        !io_request TYPE REF TO if_abap_behv_request
      RETURNING
        VALUE(rt_auth) TYPE if_abap_behv=>ty_t_auth.

    METHODS determine_project_data
      IMPORTING
        !is_action_code TYPE /bobf/conf_key
      CHANGING
        !cs_header TYPE ztb_afe_hd.

ENDCLASS.

CLASS zbp_afe_header IMPLEMENTATION.

  METHOD get_global_authorizations.
    DATA(lt_auth) = VALUE if_abap_behv=>ty_t_auth( ).
    LOOP AT io_request->get_operations( ) INTO DATA(ls_op).
      APPEND VALUE #(
        operation = ls_op-operation
        authorization = if_abap_behv=>auth-allowed
      ) TO lt_auth.
    ENDLOOP.
    rt_auth = lt_auth.
  ENDMETHOD.

  METHOD determine_project_data.
    " Custom determination stub for ProjectDescription and PlannedStartDate
    " from I_EnterpriseProject based on project_id field
    IF cs_header-project_id IS NOT INITIAL.
      " Implementation to read from enterprise project should be here.
      " e.g. SELECT SINGLE projectdescription plannedstartdate
      "       INTO (@DATA(ls_proj_desc), @DATA(ls_proj_date))
      "       FROM I_EnterpriseProject
      "       WHERE projectid = @cs_header-project_id.
    ENDIF.
  ENDMETHOD.

ENDCLASS.