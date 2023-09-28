{{ config(materialized='table') }}

with uob_audit as (
    select * from airbytescm.CORAUDIT
), 
 uob_audittype as (
    select * from airbytescm.CORAUDITTYPE
 ),
 uob_message as (
    select * from airbytescm.ARCMESSAGE
 ),

 DNAuditDetails as (
    select uob_audit.LOGINID,
        uob_audit.ENTERPRISECUSTID,
        uob_audit.AUDITDTTM,
        uob_audit.SESSIONID,
        uob_audit.CORORGKYFI,
        uob_audit.IPADDRESS,
        uob_audit.TRNREFNUMBER,
        uob_audittype.ARCCHANNELKY,
        uob_audittype.APPCOMPONENTENUM,
        uob_audittype.AUDITFUNCTIONENUM,
        uob_message.MSGCODE,
        uob_message."TRANSLATION"

        From uob_audit 
        Inner join uob_audittype on uob_audit.CORAUDITTYPEKY = uob_audittype.CORAUDITTYPEKY
        Inner join uob_message on uob_message.MSGCODE = uob_audittype.AUDITFUNCTIONENUM

 )

 select * from DNAuditDetails