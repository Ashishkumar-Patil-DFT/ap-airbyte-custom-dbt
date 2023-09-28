{{ config(materialized='table') }}

with uob_user as (
    select * from airbytescm.BNKUser
),  uob_customer as (
    select * from airbytescm.BNKCustomer
),  uob_affiliate as (
    select * from airbytescm.BNKAffiliateFI
), uob_arcprincipal as (
    select * from airbytescm.ARCPrincipal
),
DNUserDetails as (
    select uob_affiliate.CORORGKY as A_CORORGKY,
           uob_affiliate.AFFILIATEID as A_AFFILIATEID,
           uob_arcprincipal.ARCPRINCIPALKY as P_ARCPRINCIPALKY,
           uob_arcprincipal."NAME" as P_PRINCIPALNAME,
           uob_customer.BNKCUSTOMERKY as C_BNKCUSTOMERKY,
           uob_customer.CORORGKYFI as C_CORORGKYFI,
           uob_customer.ARCPRINCIPALKY as C_ARCPRINCIPALKY,
           uob_customer.CUSTOMERID as C_CUSTOMERID,
           uob_customer.UPDATEDTTM as C_UPDATEDTTM,
           uob_customer.ISSKIPSYNCATLOGIN as C_ISSKIPSYNCATLOGIN,
           uob_user.BNKUSERKY as U_BNKUSERKY,
           uob_user.ENROLLDTTM as U_ENROLLDTTM,
           uob_user.UPDATEDTTM as U_UPDATEDTTM,
           uob_user.USERACCESSTYPECD as U_USERACCESSTYPECD,
           uob_user.ISCONFSCRNENABLED as U_ISCONFSCRNENABLED,
           uob_user.ISACTIVE as U_ISACTIVE,
           uob_user.ISDELETED as U_ISDELETED,
           uob_user.DEFAULTSCREEN as U_DEFAULTSCREEN,
           uob_user.ISCMPSYSADMIN as U_ISCMPSYSADMIN
           
        from uob_user
        Inner join uob_customer  on uob_customer.BNKCUSTOMERKY = uob_user.BNKCUSTOMERKY
        Inner join uob_affiliate on uob_affiliate.CORORGKY =  uob_customer.CORORGKYFI
        Inner join uob_arcprincipal on uob_user.ARCPRINCIPALKY = uob_arcprincipal.ARCPRINCIPALKY                         
    )

select * from DNUserDetails
