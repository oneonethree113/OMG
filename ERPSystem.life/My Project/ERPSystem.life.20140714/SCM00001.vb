﻿Imports System.IO

Public Class SCM00001

    Const dgvDisPre_Dele As Integer = 0
    Const dgvDisPre_Code As Integer = 5
    Const dgvDisPre_Desc As Integer = 6
    Const dgvDisPre_PctAmt As Integer = 7
    Const dgvDisPre_Pct As Integer = 8
    Const dgvDisPre_Amt As Integer = 9

    Const tabFrame_Header As Integer = 0
    Const tabFrame_DisPrm As Integer = 1
    Const tabFrame_Detail As Integer = 2
    Const tabFrame_Shpmrk As Integer = 3
    Const tabFrame_Summary As Integer = 4
    Const tabFrame_UpdatePO As Integer = 5

    Const strModule As String = "SC"
    Const strColPck As String = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/Tran Trm) - Type : "

    'Dim SCShip_SUB As frmSCShip
    'Dim SCCarton_SUB As frmSCCarton
    Dim BOM_SUB As SCM00001_BOM
    Dim ASS_SUB As SCM00001_ASS
    Dim Org_SCCst As SCM00001_OrgSCst
    Dim ShipmrkAttchmnt As SCM00001_ShpmrkAtchmt
    Dim PO_Release As SHR00003

    Dim authUsr As Boolean
    Dim Cust_InActive As Boolean
    Dim Del_right_local As Boolean
    Dim Detail_Err As Boolean
    Dim Enq_right_local As Boolean
    Dim skipDVErrorFlag As Boolean
    Dim rplSeqFlag As Boolean

    Dim dv_dis As DataView
    Dim dv_pre As DataView
    Dim dv_sum As DataView

    Dim dgAssort_CusRtl As Integer
    Dim dgAssort_TOOrdno As Integer
    Dim dgAssort_TOOrdSeq As Integer

    Dim dgDtlShpDat_Del As Integer
    Dim dgDtlShpDat_SCFrom As Integer
    Dim dgDtlShpDat_SCTo As Integer
    Dim dgDtlShpDat_POFrom As Integer
    Dim dgDtlShpDat_POTo As Integer
    Dim dgDtlShpDat_OrdQty As Integer
    Dim dgDtlShpDat_CtnStr As Integer
    Dim dgDtlShpDat_CtnEnd As Integer
    Dim dgDtlShpDat_Dest As Integer
    Dim dgDtlShpDat_Rmk As Integer
    Dim dgDtlShpDat_CBM As Integer

    Dim dgMatBrkDwn_Del As Integer
    Dim dgMatBrkDwn_Mat As Integer
    Dim dgMatBrkDwn_Cur As Integer
    Dim dgMatBrkDwn_CstAmt As Integer
    Dim dgMatBrkDwn_CstPer As Integer
    Dim dgMatBrkDwn_Wgt As Integer

    Dim dgSummary_OrdSeq As Integer
    Dim dgSummary_UpdPO As Integer
    Dim dgSummary_ChgFty As Integer
    Dim dgSummary_CVName As Integer
    Dim dgSummary_PVName As Integer
    Dim dgSummary_TVName As Integer
    Dim dgSummary_FAName As Integer
    Dim dgSummary_PurOrd As Integer
    Dim dgSummary_JobOrd As Integer
    Dim dgSummary_RunNo As Integer
    Dim dgSummary_PJobNo As Integer
    Dim dgSummary_Itmno As Integer
    Dim dgSummary_CusStyNo As Integer
    Dim dgSummary_CusItm As Integer
    Dim dgSummary_CusSKU As Integer
    Dim dgSummary_SecCusItm As Integer
    Dim dgSummary_ColPck As Integer
    Dim dgSummary_PrcGrp As Integer
    Dim dgSummary_EffDat As Integer
    Dim dgSummary_ExpDat As Integer
    Dim dgSummary_PckItr As Integer
    Dim dgSummary_ColDsc As Integer
    Dim dgSummary_OrdQty As Integer
    Dim dgSummary_ShpQty As Integer
    Dim dgSummary_OutQty As Integer
    Dim dgSummary_OnePrc As Integer
    Dim dgSummary_CurCde As Integer
    Dim dgSummary_SelPrc As Integer
    Dim dgSummary_MinPrc As Integer
    Dim dgSummary_BasPrc As Integer
    Dim dgSummary_CtnStr As Integer
    Dim dgSummary_CtnEnd As Integer
    Dim dgSummary_TtlCtn As Integer
    Dim dgSummary_MOQ As Integer
    Dim dgSummary_MOQUntTyp As Integer
    'Dim dgSummary_MOQChg As Integer
    Dim dgSummary_SubTtl As Integer
    Dim dgSummary_MOA As Integer
    Dim dgSummary_Apprve As Integer
    Dim dgSummary_ShpStr As Integer
    Dim dgSummary_ShpEnd As Integer
    Dim dgSummary_CanDat As Integer
    Dim dgSummary_POShpStr As Integer
    Dim dgSummary_POShpEnd As Integer
    Dim dgSummary_POCanDat As Integer
    Dim dgSummary_FCurCde As Integer
    Dim dgSummary_FtyCst As Integer
    Dim dgSummary_BOMCst As Integer
    Dim dgSummary_FtyPrc As Integer
    Dim dgSummary_DVFCurCde As Integer
    Dim dgSummary_DVFtyCst As Integer
    Dim dgSummary_DVBOMCst As Integer
    Dim dgSummary_DVFtyPrc As Integer
    Dim dgSummary_HrmCde As Integer
    Dim dgSummary_DtyRat As Integer
    Dim dgSummary_TypCode As Integer
    Dim dgSummary_Code1 As Integer
    Dim dgSummary_Code2 As Integer
    Dim dgSummary_Code3 As Integer
    Dim dgSummary_CusUSDCur As Integer
    Dim dgSummary_CusUSD As Integer
    Dim dgSummary_CusCADCur As Integer
    Dim dgSummary_CusCAD As Integer
    Dim dgSummary_AlsItmno As Integer
    Dim dgSummary_AlsColCde As Integer
    Dim dgSummary_ConToPC As Integer
    Dim dgSummary_PCPrc As Integer
    Dim dgSummary_CustUM As Integer

    Dim totalR As Integer
    Dim totalCopy As Integer
    Dim totalFail As Integer
    Dim totalR_CustPO As Integer
    Dim totalCopy_CustPO As Integer
    Dim totalFail_CustPO As Integer

    Dim MOQStartDate As DateTime
    Dim MOAStartDate As DateTime
    Dim IBOMStartDate As DateTime

    Dim prev_tab As Integer

    Dim current_TimeStamp As Long

    Dim rplSeq_SCShpStr As String
    Dim rplSeq_SCShpEnd As String
    Dim rplSeq_SCCanDat As String
    Dim rplSeq_POShpStr As String
    Dim rplSeq_POShpEnd As String
    Dim rplSeq_POCanDat As String
    Dim rplSeq_SCRmk As String
    Dim rplSeq_PORmk As String

    Public CopySC_Cust_SUB As frmCopySC_Cust
    Public CopySC_SUB As frmCopySC

    Public copyFlag As Boolean

    Public strVenType As String
    Public strDV As String
    Public strDVItmCst As String
    Public strDVTtlCst As String
    Public strDVBOMCst As String
    Public strDVTtlCstCur As String
    Public strDVItmCstCur As String
    Public strDVBOMCstCur As String
    Public strDVfcurcde As String
    Public strDVftyunt As String

    Public rs_CUBASINF_P As New DataSet
    Private rs_CUBASINF_PRI As New DataSet
    'Public rs_CUBASINF_PC As New DataSet
    Public rs_CUBASINF_S As New DataSet
    Public rs_CUBASINF_SalRep As New DataSet
    Public rs_CUBASINF_Agent As New DataSet
    Public rs_CUBASINF_Person As New DataSet
    Public rs_CUSHPINF As New DataSet
    Public rs_CUSHPMRK As New DataSet
    Public rs_CUSHPMRK_S As New DataSet

    Public rs_CUCNTINF_P As New DataSet
    Public rs_CUCNTINF_S As New DataSet
    Public rs_CUCNTINF_BA As New DataSet

    Public rs_CUITMPRC As New DataSet
    Public rs_IMBOMASS As New DataSet
    Public rs_IMBOMINF As New DataSet

    Public rs_POORDHDR As New DataSet
    Public rs_POORDHDR_ori As New DataSet
    Public rs_POSHPMRK As New DataSet
    Public rs_POSHPMRK_ori As New DataSet

    Public rs_SCORDHDR As New DataSet
    Public rs_SCORDHDR_copy As New DataSet
    Public rs_SCORDDTL As New DataSet
    Public rs_SCORDDTL_copyOK As New DataSet
    Public rs_SCORDDTL_copyFail As New DataSet
    Public rs_SCORDDTL_CustPOChgOK As New DataSet
    Public rs_SCORDDTL_CustPOChgFail As New DataSet
    Public rs_SCORDDTL_ori As New DataSet
    Public rs_SCORDDTL_Summary As New DataSet
    Public rs_SCCPTBKD As New DataSet
    Public rs_SCCPTBKD_copy As New DataSet
    Public rs_SCCPTBKD_ori As New DataSet
    Public rs_SCCPTBKD_tmp As New DataSet
    Public rs_SCCNTINF As New DataSet
    Public rs_SCDISPRM_D As New DataSet
    Public rs_SCDISPRM_D_copy As New DataSet
    Public rs_SCDISPRM_D_ori As New DataSet
    Public rs_SCDISPRM_P As New DataSet
    Public rs_SCDISPRM_P_copy As New DataSet
    Public rs_SCDISPRM_P_ori As New DataSet
    Public rs_SCSHPMRK As New DataSet
    Public rs_SCSHPMRK_copy As New DataSet
    Public rs_SCVENMRK As New DataSet
    Public rs_SCVENMRK_DV As New DataSet
    Dim rs_VNBASINF As DataSet
    Public rs_VNBASINF_SC As New DataSet
    Public rs_SCASSINF As New DataSet
    Private rs_SCASSINF_copy As New DataSet
    Public rs_SCASSINF_ori As New DataSet
    Public rs_SCASSINF_tmp As New DataSet
    Public rs_SCBOMINF As New DataSet
    Public rs_SCBOMINF_copy As New DataSet
    Public rs_SCDTLSHP As New DataSet
    Public rs_SCDTLSHP_ori As New DataSet
    Public rs_SCDTLSHP_tmp As New DataSet
    'Public rs_SCDTLCTN As New DataSet
    Public rs_SCBOMINF_OLD As New DataSet

    Public rs_SYDISPRM As New DataSet
    Public rs_SYSMPTRM As New DataSet
    Public rs_SYSETINF As New DataSet

    Dim rs_TOITMDTL As DataSet

    Public rs_CUPRCINF As New DataSet
    Public rs_CVNCNTINF As New DataSet
    Public rs_SYTIESTR As New DataSet

    Public rs_IMPCKINF As New DataSet
    Public rs_FTYCST As New DataSet

    Public rs_SCORDDTL_SUB As New DataSet

    Public currentRow As Integer
    Public currentOrdSeq As Integer
    Public MaxSeq As Integer

    Public strPriCust_Copy As String
    Public strSecCust_Copy As String
    Public Custfml As String
    Public strCurExRat As String
    Public strCurExEffDat As String
    Public strCurExRat_Copy As String
    Public strCurExEffDat_Copy As String

    Dim lstSubCde As New ArrayList

    Dim defCusVen As String
    Dim sort_seq As String
    Dim strSAddSeq As String
    Dim Pricustno As String
    Dim Seccustno As String
    Dim strDueDat As String
    Dim strCusSub As String
    Dim strSubCde As String
    Dim strPckSeq As String
    Dim strOrgSelPrc As String
    Dim Temp_SCno As String

    Dim strorgpcprc As String  'For Original PC Selling Price
    Dim focusedObject As String
    Dim DVItmCst As Double
    Dim ItmCstCur As String
    Dim master As Long
    Dim inner As Long
    Dim um As String
    Dim BOMitmCount As Integer
    Dim lstDis As New ArrayList
    Dim lstPre As New ArrayList
    Dim DisPreEditCellRow As Integer
    Dim DisPreEditCellCol As Integer

    Dim addFlag As Boolean
    Dim advOrd As Boolean
    Dim bIsCopy As Boolean
    Dim CUSMOQChgFlag As Boolean
    Dim CUSMOAChgFlag As Boolean
    Dim custInactive As Boolean
    Dim detailError As Boolean
    Dim discountFocus As Boolean
    Dim dispApplyPOFlag As Boolean
    Dim dispAprvFlag As Boolean
    Dim dispClsOutFlag As Boolean
    Dim dispCopyFlag As Boolean
    Dim dispCanFlag As Boolean
    Dim dispDelFlag As Boolean
    Dim dispInsFlag As Boolean
    Dim dispPOFlag As Boolean
    Dim dispPriCusFlag As Boolean
    Dim dispRplmntFlag As Boolean
    Dim dispSaveFlag As Boolean
    Dim dispSecCusFlag As Boolean
    Dim dispSMFlag As Boolean
    Dim exitFlag As Boolean
    Dim findFlag As Boolean
    Dim formError As Boolean
    Dim historyFlag As Boolean
    Dim IM_CIH_Period As Boolean
    Dim initFlag As Boolean = True
    Dim isUpdated As Boolean
    Dim MOQChgFlag As Boolean
    Dim MOQ_MOA As Boolean
    Dim OrgMOQChg As Integer
    Dim overlimit As Boolean
    Dim poChange As Boolean
    Dim recordStatus As Boolean
    Dim recordStatus_dtl As Boolean
    Dim reUpdateFlag As Boolean
    Dim save_ok As Boolean
    Dim skipFlag As Boolean
    Dim Tier_typ As Boolean
    Dim VENMOQChgFlag As Boolean

    Dim VendorType As String
    Dim assItmCount As Integer
    Dim defVen As String
    Dim prevShpMrkTyp As String

    Dim strConName As String
    Dim strConAdd As String
    Dim strConSP As String
    Dim strConCountry As String
    Dim strConZIP As String
    Dim strForAcc As String
    Dim strForDesc As String
    Dim strForInst As String
    Dim strForTyp As String
    Dim strNotContractPerson As String
    Dim strNotTitle As String
    Dim strNotAdd As String
    Dim strNotSP As String
    Dim strNotCountry As String
    Dim strNotZIP As String
    Dim strNotPhone As String
    Dim strNotFax As String
    Dim strNotEmail As String

    ' Packing
    Dim txtInnerLin As Double
    Dim txtInnerWin As Double
    Dim txtInnerHin As Double
    Dim txtMasterLin As Double
    Dim txtMasterWin As Double
    Dim txtMasterHin As Double
    Dim txtInnerLcm As Double
    Dim txtInnerWcm As Double
    Dim txtInnerHcm As Double
    Dim txtMasterLcm As Double
    Dim txtMasterWcm As Double
    Dim txtMasterHcm As Double

    Dim Total_D_Amt As Double
    Dim Total_D_Per As Double
    Dim Total_P_Amt As Double
    Dim Total_P_Per As Double
    Dim CreditUse As Double
    Dim CreditAmt As Double
    Dim beforeNetAmt As Double
    Dim beforeStatus As String
    Dim hdr_CanDat As String
    Dim hdr_ShpStrDat As String
    Dim hdr_ShpEndDat As String
    Dim hdr_CustPODat As String
    Dim CustPODat_ori As String

    Dim sImu_cus1no As String
    Dim sImu_cus2no As String
    Dim sImu_hkprctrm As String
    Dim sImu_ftyprctrm As String
    Dim sImu_trantrm As String
    Dim dImu_effdat As String
    Dim dImu_expdat As String

    Private Sub SCM00001_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim YesNoCancel As Integer
        Dim status As String
        Temp_SCno = txtSCNo.Text
        If cboSCStatus.Text = "" Then
            status = ""
        Else
            status = Split(cboSCStatus.Text, " - ")(0)
        End If
        If cmdSave.Enabled = False Then
            recordStatus = False
        End If

        If recordStatus = True And (status = "ACT" Or status = "HLD") Then
            If addFlag Then
                YesNoCancel = MsgBox("Record is newly created   Do you want to save before exit?", MsgBoxStyle.YesNoCancel)
            Else
                YesNoCancel = MsgBox("Record has been modified  Do you want to save before exit?", MsgBoxStyle.YesNoCancel)
            End If

            If YesNoCancel = MsgBoxResult.Yes Then
                If cmdSave.Enabled Then
                    exitFlag = True
                    cmdSave.PerformClick()
                    If save_ok = True Then
                        Exit Sub
                    Else
                        exitFlag = False
                        e.Cancel = True
                        Exit Sub
                    End If
                Else
                    exitFlag = False
                    MsgBox("You are not allow to save record!", MsgBoxStyle.Exclamation, "Access Denied")
                    e.Cancel = True
                    Exit Sub
                End If

            ElseIf YesNoCancel = MsgBoxResult.No Then
                'ResetDefaultDisp()
                Exit Sub

            ElseIf YesNoCancel = vbCancel Then
                exitFlag = False
                e.Cancel = True
                Exit Sub
            End If
        Else
            Exit Sub
        End If

    End Sub

    Private Sub SCM00001_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles Me.KeyUp
        If e.Alt = True Then
            Select Case e.KeyValue
                Case 49
                    tabFrame.SelectTab(0)
                Case 50
                    tabFrame.SelectTab(1)
                Case 51
                    tabFrame.SelectTab(2)
                Case 52
                    tabFrame.SelectTab(3)
                Case 53
                    tabFrame.SelectTab(4)
                Case 54
                    tabFrame.SelectTab(5)
                Case Else
                    Exit Sub
            End Select
        End If
    End Sub



    Private Sub SCM00001_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Formstartup(Me.Name)
        AccessRight(Me.Name)
        Enq_right_local = Enq_right
        Del_right_local = Del_right

        initFlag = True
        disableUnusedButtons()
        FillCompCombo(LCase(gsUsrID), cboCoCde)
        GetDefaultCompany(cboCoCde, txtCoNam)

        MOQStartDate = "07/01/2003" 'Format MM/DD/YYYY
        MOAStartDate = "01/01/2005" 'Format MM/DD/YYYY
        IBOMStartDate = "04/01/2006" 'Format MM/DD/YYYY

        If (gsUsrRank <= 4 And Enq_right_local) Or gsUsrGrp = "MGT-S" Then
            authUsr = True
        Else
            authUsr = False
        End If

        loadSCItemStatus()
        skipFlag = False

        Me.KeyPreview = True
        tabFrame.SelectedTab = frmHdr
        setStatus("Init")
        initFlag = False
    End Sub

    Private Sub cmdAdd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdAdd.Click
        addFlag = True

        Dim rs As New DataSet

        gspStr = "sp_select_CUBASINF_PRI '" & cboCoCde.Text & "','" & LCase(gsUsrID) & "','" & strModule & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
            MsgBox("Error on loading SCM00001 #046 sp_select_CUBASINF_PRI : " & rtnStr)
            Exit Sub
        Else
            rs_CUBASINF_P = rs.Copy()
        End If

        fillcboPriCust()

        setStatus("ADD")

        MOQChgFlag = True
        If cboPriCust.Enabled And cboPriCust.Visible Then cboPriCust.Focus()
    End Sub

    Private Sub cmdSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSave.Click
        If DtlInputisVaild() Then
            Dim po_from As String
            Dim po_to As String

            '***check all Input is vaild
            Dim candat As Object

            Dim find_flag As Boolean

            'Lester Wu 2007-10-08
            If Me.txtMOQSC.Enabled = True And Me.txtMOQSC.ReadOnly = False Then
                If checkMOQSC() = False Then Exit Sub
            End If

            ''*************IM Period Format***********************
            ''Frankie Cheung Add IM Period 20100809
            'If (IsDate(Trim(txtIMPeriod.Text) & "-01") = False) And (Trim(txtIMPeriod.Text) <> "") Then
            '    MsgBox("Invalid IM Period Format, correct format: YYYY-MM")
            '    If txtIMPeriod.Enabled = True Then
            '        txtIMPeriod.Focus()
            '    End If
            '    Exit Sub
            'End If

            If (IsDate(Trim(txtCIHPrd.Text) & "-01") = False) And (Trim(txtCIHPrd.Text) <> "") Then
                MsgBox("Invalid CIH Period Format, correct format: YYYY-MM")
                If txtCIHPrd.Enabled = True Then
                    txtCIHPrd.Focus()
                End If
                Exit Sub
            End If

            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            If exitFlag = True Then
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
            End If

            If Not addFlag Then
                '***check timeStamp is equal
                If Not ChecktimeStamp() Then
                    MsgBox("The record has been modified by other users, please clear and try again.")
                    Me.Cursor = Windows.Forms.Cursors.Default
                    save_ok = False
                    Exit Sub
                End If
            End If

            If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                If DtlInputisVaild() Then
                    updateDetailRS()
                Else
                    Me.Cursor = Windows.Forms.Cursors.Default
                    save_ok = False
                    Exit Sub
                End If
            End If

            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                If (rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*DEL*~") Then
                    ' 2014-04-17 Request by Winnie Leung - Only prompt user if updating on Version 1
                    If Split(rs_SCORDDTL.Tables("RESULT").Rows(i)("ibi_itmsts"), " - ")(0) <> "CMP" And txtSCVerNo.Text = "1" Then
                        Me.Cursor = Windows.Forms.Cursors.Default
                        MsgBox("Item not in Complete Status")
                        If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*ADD*~" Then
                            save_ok = False
                            Exit Sub
                        End If
                    End If
                    If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_dvftycst") = 0 Then
                        Me.Cursor = Windows.Forms.Cursors.Default
                        currentRow = i
                        currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
                        If tabFrame.SelectedIndex = tabFrame_Detail Then
                            recordMove("LOAD")
                        Else
                            tabFrame.SelectedIndex = tabFrame_Detail
                        End If
                        MsgBox("Missing DV Item Cost")
                        txtDVItmCst.Focus()
                        txtDVItmCst.SelectAll()
                        save_ok = False
                        Exit Sub
                    End If

                    ' Check if unauthorized Convert to PC changes
                    If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*ADD*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_itmtyp") = "ASS" Then
                        If authUsr = False Then
                            If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_cocde") <> rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_contopc") Then
                                'currentRow = i
                                'currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
                                'If tabFrame.SelectedIndex = tabFrame_Detail Then
                                '    recordMove("LOAD")
                                'Else
                                '    tabFrame.SelectedIndex = tabFrame_Detail
                                'End If
                                'MsgBox("Unauthorized Convert to PC Changes have been detected", MsgBoxStyle.Critical, Me.Name & " - Save")
                                'save_ok = False
                                'Exit Sub

                                ' Revert to Previous Status
                                rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_contopc") = rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_cocde")
                            End If
                        End If
                    End If
                End If
            Next

            If reUpdateFlag = True Then
                If currentRow > 0 Then
                    For i As Integer = currentRow To 0 Step -1
                        recordMove("BACK")
                    Next
                End If
                For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                    If chkReplacement.Checked <> False And chkCloseOut.Checked <> False Then
                        If rs_SCORDDTL.Tables("RESULT").Rows.Count <> 1 Then
                            If i = rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
                                recordMove("BACK")
                            Else
                                recordMove("NEXT")
                            End If
                        End If
                    End If
                Next
            End If

            Cal_TotalAmt()
            If Not InputIsValid() Then
                Me.Cursor = Windows.Forms.Cursors.Default
                save_ok = False
                Exit Sub
            End If

            If rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0 Then
                UpdateShipMark()
            End If

            Dim rs As New DataSet
            Dim rs_AddDtl As DataSet
            Dim rs_AutoGenSCNo As New DataSet

            Dim SampleSC As String
            Dim CancelSC As String
            'Dim Approve As String
            Dim Replacement As String
            Dim CloseOut As String
            Dim status As String
            Dim real_ordseq As Integer


            'Kenny Add on 19-11-2002
            'For init the SampleSC Value
            SampleSC = "N"

            'S = ""
            '**************Check Sample S/C/Replacement/Close Out and status********************

            If chkCancel.Checked = True Then
                CancelSC = "Y"
            Else
                CancelSC = "N"
            End If

            If chkReplacement.Checked = True Then
                Replacement = "Y"
            Else
                Replacement = "N"
            End If

            If chkCloseOut.Checked = True Then
                CloseOut = "Y"
            Else
                CloseOut = "N"
            End If

            ''************Check SC Status**********************
            If CancelSC = "Y" Then
                If MsgBox("Detail Qty will be 0, Confirm to Cancel this SC?", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                    save_ok = False
                    Me.Cursor = Windows.Forms.Cursors.Default
                    Exit Sub
                Else
                    If rs_SCORDHDR.Tables("RESULT").Rows(0)("shipped") > 0 Then
                        status = "ACT"
                    Else
                        status = "CAN"
                    End If
                    CancelAllDtl()
                End If
            Else
                '**************Not Cancel SC ,need to Check HLD Status******************
                Dim Dtlbook As Integer
                Dim Credit As Boolean
                Dim MOQ_MOA As Boolean
                Dim Price As Boolean
                Credit = True
                MOQ_MOA = True
                Price = True

                '****Assig Default when Close Out***************
                If CloseOut = "Y" Then
                    If MsgBox("Close Out SC all Vendor will Set as Invertory Vendor?", MsgBoxStyle.YesNo) = MsgBoxResult.Yes Then
                        CloseOut_Assign_Vendor()
                    Else
                        'If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                        '    rs_SCORDDTL.MoveFirst()
                        '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                        '    If rs_SCORDDTL.EOF Then
                        '        rs_SCORDDTL.MoveFirst()
                        '    End If
                        'End If
                        save_ok = False
                        Me.Cursor = Windows.Forms.Cursors.Default
                        Exit Sub
                    End If
                End If
                '***********************************************

                If CancelSC = "N" Then
                    If Not checkDTL_HLD("Credit") Then
                        Credit = False
                        'status = "HLD"
                        '***********************Credit Limit*****************************************
                        If overlimit = True Then
                            SampleSC = "Y"
                            If chkApprove.Checked = False Then
                                If MsgBox("SC Status Hold (Over Risk Limit)", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                    'If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                                    '    rs_SCORDDTL.MoveFirst()
                                    '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                    '    If rs_SCORDDTL.EOF Then
                                    '        rs_SCORDDTL.MoveFirst()
                                    '    End If
                                    'End If
                                    save_ok = False
                                    Me.Cursor = Windows.Forms.Cursors.Default
                                    Exit Sub
                                End If
                            Else

                                If gsUsrRank > 2 And gsUsrGrp <> "MGT-S" Then
                                    MsgBox("You have no right to Approval this SC", MsgBoxStyle.Information, "Message")
                                    save_ok = False
                                    Me.Cursor = Windows.Forms.Cursors.Default
                                    Exit Sub
                                End If

                                If MsgBox("Approve this SC with (Over Customer Risk Limit)", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                    'If rs_SCORDDTL.recordCount > 0 Then
                                    '    rs_SCORDDTL.MoveFirst()
                                    '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                    '    If rs_SCORDDTL.EOF Then
                                    '        rs_SCORDDTL.MoveFirst()
                                    '    End If
                                    'End If
                                    save_ok = False
                                    Me.Cursor = Windows.Forms.Cursors.Default
                                    Exit Sub
                                Else
                                    Credit = True
                                End If
                            End If
                        Else
                            Credit = True
                        End If
                    Else
                        Credit = True
                        If addFlag = False Then
                            SampleSC = "N"
                        Else
                            SampleSC = "N"
                        End If
                    End If
                End If
                '**************************MOQ MOA*******************************************
                If CancelSC = "N" And CloseOut = "N" Then
                    If Not checkDTL_HLD("MOQ") Then
                        MOQ_MOA = False
                        'status = "HLD"
                        If chkApprove.Checked = False Then
                            If MsgBox("SC Status Hold (MOQ,MOA)", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                'If rs_SCORDDTL.recordCount > 0 Then
                                '    rs_SCORDDTL.MoveFirst()
                                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                '    If rs_SCORDDTL.EOF Then
                                '        rs_SCORDDTL.MoveFirst()
                                '    End If
                                'End If
                                save_ok = False
                                Me.Cursor = Windows.Forms.Cursors.Default
                                Exit Sub
                            End If
                        Else
                            If MsgBox("Approve this SC with not enough MOA and MOQ", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                'If rs_SCORDDTL.recordCount > 0 Then
                                '    rs_SCORDDTL.MoveFirst()
                                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                '    If rs_SCORDDTL.EOF Then
                                '        rs_SCORDDTL.MoveFirst()
                                '    End If
                                'End If
                                save_ok = False
                                Me.Cursor = Windows.Forms.Cursors.Default
                                Exit Sub
                            Else
                                MOQ_MOA = True
                                Approve_Dtl("MOQ")
                            End If

                        End If
                    Else
                        MOQ_MOA = True
                    End If
                End If
                '*********************Selling Price*******************************************
                If CancelSC = "N" And CloseOut = "N" Then
                    If Not checkDTL_HLD("Price") Then
                        Price = False
                        If chkApprove.Checked = False Then

                            If MsgBox("SC Status Hold (Selling Price < Basic Price/Min Price or Basic Price/Min Price = 0 or Factory Price = 0 )", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                'If rs_SCORDDTL.recordCount > 0 Then
                                '    rs_SCORDDTL.MoveFirst()
                                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                '    If rs_SCORDDTL.EOF Then
                                '        rs_SCORDDTL.MoveFirst()
                                '    End If
                                'End If
                                save_ok = False
                                Me.Cursor = Windows.Forms.Cursors.Default
                                Exit Sub
                            End If

                        Else
                            If MsgBox("Approve this SC with (Selling Price < Master Price or Master Price = 0 or Factory Price = 0)", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                                'If rs_SCORDDTL.recordCount > 0 Then
                                '    rs_SCORDDTL.MoveFirst()
                                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                                '    If rs_SCORDDTL.EOF Then
                                '        rs_SCORDDTL.MoveFirst()
                                '    End If
                                'End If
                                save_ok = False
                                Me.Cursor = Windows.Forms.Cursors.Default
                                Exit Sub
                            Else
                                Price = True
                                Approve_Dtl("SELPRC")
                            End If
                        End If

                    Else
                        Price = True
                        'status = "ACT"
                    End If
                End If

                ''*********************IM CIH Period*******************************************
                'If CancelSC = "N" And CloseOut = "N" Then
                '    If Not checkDTL_HLD("Period") Then
                '        IM_CIH_Period = False
                '        If chkApprove.Checked = False Then
                '            If MsgBox("SC Status Hold (IM Period <> CIH Period)", 292, "Question") = MsgBoxResult.No Then
                '                'If rs_SCORDDTL.recordCount > 0 Then
                '                '    rs_SCORDDTL.MoveFirst()
                '                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                '                '    If rs_SCORDDTL.EOF Then
                '                '        rs_SCORDDTL.MoveFirst()
                '                '    End If
                '                'End If
                '                save_ok = False
                '                Me.Cursor = Windows.Forms.Cursors.Default
                '                Exit Sub
                '            End If

                '        Else
                '            If MsgBox("Approve this SC with (IM Period <> CIH Period)", 292, "Question") = MsgBoxResult.No Then
                '                'If rs_SCORDDTL.recordCount > 0 Then
                '                '    rs_SCORDDTL.MoveFirst()
                '                '    rs_SCORDDTL.Find("sod_ordseq =" & "'" & Trim(Split(lblDtlSeq.Caption, "Seq : ")(1)) & "'")
                '                '    If rs_SCORDDTL.EOF Then
                '                '        rs_SCORDDTL.MoveFirst()
                '                '    End If
                '                'End If
                '                IM_CIH_Period = False
                '                Me.Cursor = Windows.Forms.Cursors.Default
                '                Exit Sub
                '            Else
                '                IM_CIH_Period = True
                '                Approve_Dtl("Period")
                '            End If
                '        End If
                '    Else
                '        IM_CIH_Period = True
                '    End If
                'End If

                'If Credit = True And MOQ_MOA = True And Price = True And IM_CIH_Period = True And CancelSC = "N" Then
                '    status = "ACT"
                'Else
                '    status = "HLD"
                'End If

                If Credit = True And MOQ_MOA = True And Price = True And CancelSC = "N" Then
                    status = "ACT"
                Else
                    status = "HLD"
                End If
            End If    'Cancel SC
            '**************************************************
            '******************Split Data **********************
            Dim SecCust As String
            Dim BCountry As String
            Dim SCountry As String
            Dim CCountry As String
            Dim NCountry As String
            Dim SalesRep As String
            Dim Agent As String
            Dim PayTrm As String
            Dim Figtrm As String
            Dim Prdtrm As String
            Dim ForType As String
            Dim CurCde As String
            Dim HDRCancel As String

            '*****************Cust currency*********************
            CurCde = lblTtlAmtCur.Text
            '***************************************************
            '********Hdr Cancel Date******************
            If txtCancelDat.Text = "  /  /" Then
                HDRCancel = "01/01/1900"
            Else
                HDRCancel = txtCancelDat.Text
            End If
            '************Sce Customer*******************
            If Trim(cboSecCust.Text) = "" Then
                SecCust = ""
            Else
                SecCust = Split(cboSecCust.Text, " - ")(0)
            End If
            '************Bill Country*******************
            If Trim(cboBillCountry.Text) = "" Then
                BCountry = ""
            Else
                BCountry = Split(cboBillCountry.Text, " - ")(0)
            End If
            '************Ship Country*******************
            If Trim(cboShipCountry.Text) = "" Then
                SCountry = ""
            Else
                SCountry = Split(cboShipCountry.Text, " - ")(0)
            End If
            '************Consignee Country*******************

            If Trim(strConCountry) = "" Then
                CCountry = ""
            Else
                CCountry = Trim(strConCountry)
            End If
            '************Notify Party Country*******************
            If Trim(strNotCountry) = "" Then
                NCountry = ""
            Else
                NCountry = Trim(strNotCountry)
            End If
            '************Sales Rep *******************
            If Trim(cboSalesRep.Text) = "" Then
                SalesRep = ""
            Else
                SalesRep = Split(cboSalesRep.Text, " - ")(0)
            End If
            '************Agent *******************
            If Trim(cboAgent.Text) = "" Then
                Agent = ""
            Else
                Agent = Split(cboAgent.Text, " - ")(0)
            End If
            '************Payement Term*******************
            If Trim(cboPayTrm.Text) = "" Then
                PayTrm = ""
            Else
                PayTrm = Split(cboPayTrm.Text, " - ")(0)
            End If
            '************Sample Feright Term*******************
            Figtrm = ""
            '*************Sample Product Term *****************
            Prdtrm = ""
            '*************Forwarder type***********************

            If Trim(strForTyp) = "" Then
                ForType = ""
            Else
                ForType = Trim(strForTyp)
            End If

            If (txtStartShipDat.Text <> hdr_ShpStrDat) Or (txtEndShipDat.Text <> hdr_ShpEndDat) Or (txtCancelDat.Text <> hdr_CanDat) Then
                Dim Msgcde As Integer
                Msgcde = MsgBox("Cancel or Ship Date in Header has been modified, details will be updated. Are you sure?", MsgBoxStyle.YesNoCancel)
                If Msgcde = MsgBoxResult.Yes Then
                    Apply_ShpDat()
                    Apply_CanDat()
                ElseIf Msgcde = MsgBoxResult.Cancel Then
                    save_ok = False
                    Me.Cursor = Windows.Forms.Cursors.Default
                    Exit Sub
                End If
            End If
            '*****************Auto Gen SC No.********************************
            If addFlag = True Then
                gspStr = "sp_select_DOC_GEN '" & cboCoCde.Text & "','SC','" & LCase(gsUsrID) & "'"

                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, rs_AutoGenSCNo, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #068 sp_select_DOC_GEN : " & rtnStr)
                    Me.Cursor = Windows.Forms.Cursors.Default
                    Exit Sub
                Else
                    txtSCNo.Text = rs_AutoGenSCNo.Tables("RESULT").Rows(0)(0)
                End If
            End If

            '************************************************************************************************************
            '******************************Add/Upd SCCNTINF*************************************************************

            If addFlag Then
                '*** Add SCCNTINF
                gspStr = "sp_insert_SCCNTINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & strConName & "','" & _
                         strConAdd & "','" & strConSP & "','" & CCountry & "','" & strConZIP & "','" & ForType & _
                         "','" & strForAcc & "','" & strForDesc & "','" & strForInst & "','NP','" & strNotAdd & "','" & strNotSP & _
                         "','" & NCountry & "','" & strNotZIP & "','" & strNotContractPerson & "','" & strNotTitle & _
                         "','" & strNotPhone & "','" & strNotFax & "','" & strNotEmail & "','" & LCase(gsUsrID) & "'"

            Else
                gspStr = "sp_update_SCCNTINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & strConName & "','" & _
                         strConAdd & "','" & strConSP & "','" & CCountry & "','" & strConZIP & "','" & ForType & _
                         "','" & strForAcc & "','" & strForDesc & "','" & strForInst & "','NP','" & strNotAdd & "','" & strNotSP & _
                         "','" & NCountry & "','" & strNotZIP & "','" & strNotContractPerson & "','" & strNotTitle & _
                         "','" & strNotPhone & "','" & strNotFax & "','" & strNotEmail & "','" & LCase(gsUsrID) & "'"
            End If

            If gspStr <> "" Then
                Dim rsSCCNTINF As New DataSet
                rtnLong = execute_SQLStatement(gspStr, rsSCCNTINF, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on saving SCM00001 #069 " & Split(gspStr, " '")(0) & " : " & rtnStr)
                    isUpdated = False
                    Exit Sub
                Else
                    isUpdated = True
                End If
            End If

            '************************************************************************************************************
            '*********************************SCDISPRM Dis**********************************************

            Dim drSCDISPRM_D() As DataRow

            '****************************
            '*** Delete Details Record***
            '****************************
            drSCDISPRM_D = rs_SCDISPRM_D.Tables("RESULT").Select("sdp_creusr ='~*DEL*~'")
            If drSCDISPRM_D.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_D.Length - 1
                    gspStr = "sp_physical_delete_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','D','" & drSCDISPRM_D(i).Item("sdp_seqno") & "'"

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on deleting SCM00001 #070 sp_physical_delete_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If

            '****************************
            '*** Add Details Record***
            '****************************
            drSCDISPRM_D = Nothing
            drSCDISPRM_D = rs_SCDISPRM_D.Tables("RESULT").Select("sdp_creusr ='~*ADD*~'")
            If drSCDISPRM_D.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_D.Length - 1
                    gspStr = "sp_insert_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','D','" & drSCDISPRM_D(i).Item("sdp_cde") & _
                             "','" & drSCDISPRM_D(i).Item("sdp_dsc") & "','" & drSCDISPRM_D(i).Item("sdp_pctamt") & "','" & drSCDISPRM_D(i).Item("sdp_pct") & _
                             "','" & drSCDISPRM_D(i).Item("sdp_amt") & "','" & LCase(gsUsrID) & "'"

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on saving SCM00001 #071 sp_insert_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If

            '****************************
            '*** Update Details Record***
            '****************************
            drSCDISPRM_D = Nothing
            drSCDISPRM_D = rs_SCDISPRM_D.Tables("RESULT").Select("sdp_creusr ='~*UPD*~'")
            If drSCDISPRM_D.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_D.Length - 1
                    gspStr = "sp_update_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','D','" & drSCDISPRM_D(i).Item("sdp_seqno") & _
                             "','" & drSCDISPRM_D(i).Item("sdp_cde") & "','" & drSCDISPRM_D(i).Item("sdp_dsc") & _
                             "','" & drSCDISPRM_D(i).Item("sdp_pctamt") & "','" & drSCDISPRM_D(i).Item("sdp_pct") & _
                             "','" & drSCDISPRM_D(i).Item("sdp_amt") & "','" & LCase(gsUsrID) & "'"

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on saving SCM00001 #072 sp_update_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If

            '*********************************************************************************************
            '*********************************SCDISPRM Pre**********************************************

            Dim drSCDISPRM_P() As DataRow
            '****************************
            '*** Delete Details Record***
            '****************************
            drSCDISPRM_P = rs_SCDISPRM_P.Tables("RESULT").Select("sdp_creusr ='~*DEL*~'")
            If drSCDISPRM_P.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_P.Length - 1
                    gspStr = "sp_physical_delete_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','P','" & drSCDISPRM_P(i).Item("sdp_seqno") & "'"

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on deleting SCM00001 #073 sp_physical_delete_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If

            ''****************************
            ''*** Add Details Record***
            ''****************************
            drSCDISPRM_P = Nothing
            drSCDISPRM_P = rs_SCDISPRM_P.Tables("RESULT").Select("sdp_creusr ='~*ADD*~'")
            If drSCDISPRM_P.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_P.Length - 1
                    gspStr = "sp_insert_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','P','" & drSCDISPRM_P(i).Item("sdp_cde") & _
                             "','" & drSCDISPRM_P(i).Item("sdp_dsc") & "','" & drSCDISPRM_P(i).Item("sdp_pctamt") & "','" & drSCDISPRM_P(i).Item("sdp_pct") & _
                             "','" & drSCDISPRM_P(i).Item("sdp_amt") & "','" & LCase(gsUsrID) & "'"

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on saving SCM00001 #074 sp_insert_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If

            ''****************************
            ''*** Update Details Record***
            ''****************************
            drSCDISPRM_P = Nothing
            drSCDISPRM_P = rs_SCDISPRM_P.Tables("RESULT").Select("sdp_creusr ='~*UPD*~'")
            If drSCDISPRM_P.Length > 0 Then
                For i As Integer = 0 To drSCDISPRM_P.Length - 1
                    gspStr = "sp_update_SCDISPRM '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','P','" & drSCDISPRM_P(i).Item("sdp_seqno") & _
                             "','" & drSCDISPRM_P(i).Item("sdp_cde") & "','" & drSCDISPRM_P(i).Item("sdp_dsc") & _
                             "','" & drSCDISPRM_P(i).Item("sdp_pctamt") & "','" & drSCDISPRM_P(i).Item("sdp_pct") & _
                             "','" & drSCDISPRM_P(i).Item("sdp_amt") & "','" & LCase(gsUsrID) & "'"
                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("Error on saving SCM00001 #075 sp_update_SCDISPRM : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                        End If
                    End If
                Next
            End If
            '*********************************************************************************************

            '******************************Add/Upd/Del SCORDDTL*************************************************************
            Dim drSCORDDTL() As DataRow
            '****************************
            '*** Delete Details Record***
            '****************************
            drSCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr ='~*DEL*~'")

            If drSCORDDTL.Length > 0 Then
                For i As Integer = 0 To drSCORDDTL.Length - 1
                    gspStr = "sp_Physical_Delete_SCORDDTL '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"

                    If gspStr <> "sp_Physical_Delete_SCORDDTL '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "',''" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on deleting SCM00001 #076 sp_Physical_Delete_SCORDDTL : " & rtnStr)
                            isUpdated = False
                        Else
                            isUpdated = True
                            '***************DEL Assort item with Real Seq**********************************
                            If drSCORDDTL(i).Item("sod_itmtyp").ToString = "ASS" Then
                                'gspStr = "sp_Physical_delete_SCASSINF '" & cboCoCde.Text & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"
                                gspStr = "sp_Physical_delete_SCASSINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"
                                If gspStr <> "" Then
                                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                                        MsgBox("Error on deleting SCM00001 #077 sp_Physical_delete_SCASSINF : " & rtnStr)
                                        isUpdated = False
                                    Else
                                        isUpdated = True
                                    End If
                                End If
                            End If
                            '******************************************************************************
                            '***************DEL BOM item with Real Seq**********************************
                            gspStr = "sp_Physical_Delete_SCBOMINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"
                            If gspStr <> "" Then
                                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                                If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                                    MsgBox("Error on deleting SCM00001 #078 sp_Physical_delete_SCBOMINF : " & rtnStr)
                                    isUpdated = False
                                Else
                                    isUpdated = True
                                End If
                            End If
                            ''******************************************************************************
                            ''***************DEL Carton with This OrdSeq**********************************
                            'Dim drSCDTLCTN_ordseq() As DataRow = rs_SCDTLCTN.Tables("RESULT").Select("sdc_seq = " & "'" & drSCORDDTL(i).Item("sod_ordseq") & "'")
                            ''drSCDTLCTN = rs_SCDTLCTN.Tables("RESULT").Select("sdc_seq = " & "'" & drSCORDDTL(i).Item("sod_ordseq") & "'")

                            ''drSCDTLCTN = rs_SCDTLCTN.Tables("RESULT").Select("sdc_seq = " & "'" & drSCORDDTL(i).Item("sod_ordseq") & "'")

                            'gspStr = "sp_Physical_Delete_SCDTLCTN_all '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"

                            'If gspStr <> "" Then  '*** if there is something to do with s ...

                            '    'Fixing global company code problem at 20100420
                            '    gsCompany = Trim(cboCoCde.Text)
                            '    Update_gs_Value(gsCompany)

                            '    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                            '    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                            '        MsgBox("Error on deleting SCM00001 #079 sp_Physical_delete_SCDTLCTN_all : " & rtnStr)
                            '        isUpdated = False
                            '    Else
                            '        If drSCDTLCTN_ordseq.Length > 0 Then
                            '            While drSCDTLCTN_ordseq.Length > 0
                            '                drSCDTLCTN_ordseq(0).Delete()
                            '            End While
                            '        End If
                            '        isUpdated = True
                            '    End If
                            'End If
                            ''********************************************************************************

                            '***************DEL Shipement with This OrdSeq**********************************
                            Dim drSCDTLSHP_ordseq() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = " & "'" & drSCORDDTL(i)("sod_ordseq") & "'")

                            gspStr = "sp_Physical_Delete_SCDTLSHP_all '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "'"

                            If gspStr <> "" Then  '*** if there is something to do with s ...
                                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                                If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                                    MsgBox("Error on deleting SCM00001 #080 sp_Physical_Delete_SCDTLSHP_all : " & rtnStr)
                                    isUpdated = False
                                Else
                                    If drSCDTLSHP_ordseq.Length > 0 Then
                                        While drSCDTLSHP_ordseq.Length > 0
                                            drSCDTLSHP_ordseq(0).Delete()
                                        End While
                                    End If
                                    isUpdated = True
                                End If
                            End If
                            '********************************************************************************
                        End If
                    End If
                Next
            End If

            '****************************
            '*** Add Details Record***
            '****************************
            Dim posstr As String
            Dim posend As String
            Dim poscan As String

            drSCORDDTL = Nothing
            drSCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr ='~*ADD*~' ")
            If drSCORDDTL.Length > 0 Then
                For i As Integer = 0 To drSCORDDTL.Length - 1
                    If Trim(drSCORDDTL(i).Item("sod_candat").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_candat").ToString) <> "" Then
                        candat = Format(CDate(drSCORDDTL(i).Item("sod_candat")), "MM/dd/yyyy")
                    Else
                        candat = ""
                    End If

                    If Trim(drSCORDDTL(i).Item("sod_posstr").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_posstr").ToString) <> "" Then
                        posstr = Format(CDate(drSCORDDTL(i).Item("sod_posstr")), "MM/dd/yyyy")
                    Else
                        posstr = ""
                    End If

                    If Trim(drSCORDDTL(i).Item("sod_posend").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_posend").ToString) <> "" Then
                        posend = Format(CDate(drSCORDDTL(i).Item("sod_posend")), "MM/dd/yyyy")
                    Else
                        posend = ""
                    End If

                    If Trim(drSCORDDTL(i).Item("sod_poscan").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_poscan").ToString) <> "" Then
                        poscan = Format(CDate(drSCORDDTL(i).Item("sod_poscan")), "MM/dd/yyyy")
                    Else
                        poscan = ""
                    End If

                    '***********Carlos Lui added 20120706**********
                    If Trim(imu_key.Text) = "" Then
                        sImu_cus1no = ""
                        sImu_cus2no = ""
                        sImu_hkprctrm = ""
                        sImu_ftyprctrm = ""
                        sImu_trantrm = ""
                        dImu_effdat = "01/01/1900"
                        dImu_expdat = "01/01/1900"
                    Else
                        sImu_cus1no = drSCORDDTL(i).Item("sod_cus1no")
                        sImu_cus2no = drSCORDDTL(i).Item("sod_cus2no")
                        sImu_hkprctrm = drSCORDDTL(i).Item("sod_hkprctrm")
                        sImu_ftyprctrm = drSCORDDTL(i).Item("sod_ftyprctrm")
                        sImu_trantrm = drSCORDDTL(i).Item("sod_trantrm")
                        dImu_effdat = Format(drSCORDDTL(i).Item("sod_effdat"), "MM/dd/yyyy")
                        dImu_expdat = Format(drSCORDDTL(i).Item("sod_expdat"), "MM/dd/yyyy")
                    End If

                    gspStr = "sp_insert_SCORDDTL '" & cboCoCde.Text & "','" & UCase(Trim(txtSCNo.Text)) & "','" & UCase(drSCORDDTL(i).Item("sod_itmno").ToString) & _
                             "','" & Replace(drSCORDDTL(i).Item("sod_colcde"), "'", "''") & "','" & drSCORDDTL(i).Item("sod_pckunt") & "','" & _
                             drSCORDDTL(i).Item("sod_inrctn") & "','" & drSCORDDTL(i).Item("sod_mtrctn") & "','" & drSCORDDTL(i).Item("sod_cft") & "','" & _
                             drSCORDDTL(i).Item("sod_cbm") & "','" & drSCORDDTL(i).Item("sod_hkprctrm") & "','" & drSCORDDTL(i).Item("sod_ftyprctrm") & "','" & _
                             drSCORDDTL(i).Item("sod_trantrm") & "','" & IIf(drSCORDDTL(i).Item("sod_conftr").ToString = "", 1, drSCORDDTL(i).Item("sod_conftr")) & _
                             "','" & drSCORDDTL(i).Item("sod_prcgrp") & "','" & drSCORDDTL(i).Item("sod_cus1no") & "','" & drSCORDDTL(i).Item("sod_cus2no") & _
                             "','" & Format(drSCORDDTL(i).Item("sod_effdat"), "MM/dd/yyyy") & "','" & Format(drSCORDDTL(i).Item("sod_expdat"), "MM/dd/yyyy") & _
                             "','" & drSCORDDTL(i).Item("sod_qutdat") & "','" & "1900-01-01" & "','" & drSCORDDTL(i).Item("sod_dv") & "','" & _
                             drSCORDDTL(i).Item("sod_venno") & "','" & drSCORDDTL(i).Item("sod_cusven") & "','" & drSCORDDTL(i).Item("sod_tradeven") & "','" & _
                             drSCORDDTL(i).Item("sod_examven") & "','" & drSCORDDTL(i).Item("sod_fcurcde") & "','" & drSCORDDTL(i).Item("sod_ftycst") & "','" & _
                             drSCORDDTL(i).Item("sod_bomcst") & "','" & drSCORDDTL(i).Item("sod_ftyprc") & "','" & drSCORDDTL(i).Item("sod_ftyunt") & "','" & _
                             drSCORDDTL(i).Item("sod_venitm") & "','" & drSCORDDTL(i).Item("sod_dvfcurcde") & "','" & drSCORDDTL(i).Item("sod_dvftycst") & "','" & _
                             drSCORDDTL(i).Item("sod_dvbomcst") & "','" & drSCORDDTL(i).Item("sod_dvftyprc") & "','" & drSCORDDTL(i).Item("sod_dvftyunt") & "','" & _
                             drSCORDDTL(i).Item("sod_dvitmcst") & "','" & drSCORDDTL(i).Item("sod_itmcstcur") & "','" & _
                             drSCORDDTL(i).Item("ibi_itmsts") & "','" & drSCORDDTL(i).Item("sod_itmtyp") & "','" & Replace(drSCORDDTL(i).Item("sod_itmdsc"), "'", "''") & _
                             "','" & drSCORDDTL(i).Item("sod_pckseq") & "','" & Replace(drSCORDDTL(i).Item("sod_pckitr"), "'", "''") & "','" & _
                             drSCORDDTL(i).Item("sod_inrdin") & "','" & drSCORDDTL(i).Item("sod_inrwin") & "','" & drSCORDDTL(i).Item("sod_inrhin") & "','" & _
                             drSCORDDTL(i).Item("sod_mtrdin") & "','" & drSCORDDTL(i).Item("sod_mtrwin") & "','" & drSCORDDTL(i).Item("sod_mtrhin") & "','" & _
                             drSCORDDTL(i).Item("sod_inrdcm") & "','" & drSCORDDTL(i).Item("sod_inrwcm") & "','" & drSCORDDTL(i).Item("sod_inrhcm") & "','" & _
                             drSCORDDTL(i).Item("sod_mtrdcm") & "','" & drSCORDDTL(i).Item("sod_mtrwcm") & "','" & drSCORDDTL(i).Item("sod_mtrhcm") & "','" & _
                             drSCORDDTL(i).Item("sod_ordqty") & "','" & drSCORDDTL(i).Item("sod_oneprc") & "','" & drSCORDDTL(i).Item("sod_apprve") & "','" & _
                             drSCORDDTL(i).Item("sod_curcde") & "','" & drSCORDDTL(i).Item("sod_itmprc") & "','" & drSCORDDTL(i).Item("sod_basprc") & "','" & drSCORDDTL(i).Item("sod_untprc") & "','" & _
                             drSCORDDTL(i).Item("sod_pcprc") & "','" & drSCORDDTL(i).Item("sod_netuntprc") & "','" & drSCORDDTL(i).Item("sod_selprc") & "','" & _
                             drSCORDDTL(i).Item("sod_alsitmno") & "','" & Replace(drSCORDDTL(i).Item("sod_alscolcde"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_coldsc"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_cuscol"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_cusitm"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_seccusitm"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_cusstyno"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_cussku"), "'", "''") & "','" & _
                             drSCORDDTL(i).Item("sod_custum") & "','" & Replace(drSCORDDTL(i).Item("sod_resppo"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_cuspo"), "'", "''") & "','" & drSCORDDTL(i).Item("sod_cussub") & "','" & _
                             drSCORDDTL(i).Item("sod_season") & "','" & drSCORDDTL(i).Item("sod_year") & "','" & Replace(drSCORDDTL(i).Item("sod_hrmcde"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_typcode"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_code1"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_code2"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_code3"), "'", "''") & "','" & _
                             drSCORDDTL(i).Item("sod_cususdcur") & "','" & drSCORDDTL(i).Item("sod_cususd") & "','" & drSCORDDTL(i).Item("sod_cuscadcur") & "','" & _
                             drSCORDDTL(i).Item("sod_cuscad") & "','" & Replace(drSCORDDTL(i).Item("sod_dtyrat"), "'", "''") & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_dept"), "'", "''") & "','" & drSCORDDTL(i).Item("sod_venmoqchg") & "','" & _
                             drSCORDDTL(i).Item("sod_cusmoqchg") & "','" & drSCORDDTL(i).Item("sod_moqchg") & "','" & drSCORDDTL(i).Item("sod_orgmoqchg") & "','" & _
                             drSCORDDTL(i).Item("sod_tirtyp") & "','" & drSCORDDTL(i).Item("sod_moq") & "','" & drSCORDDTL(i).Item("sod_moqunttyp") & "','" & _
                             drSCORDDTL(i).Item("sod_moa") & "','" & Format(CDate(drSCORDDTL(i).Item("sod_shpstr")), "MM/dd/yyyy") & "','" & _
                             Format(CDate(drSCORDDTL(i).Item("sod_shpend")), "MM/dd/yyyy") & "','" & candat & "','" & drSCORDDTL(i).Item("sod_ctnstr") & "','" & _
                             drSCORDDTL(i).Item("sod_ctnend") & "','" & drSCORDDTL(i).Item("sod_ttlctn") & "','" & posstr & "','" & posend & "','" & poscan & "','" & _
                             Replace(drSCORDDTL(i).Item("sod_rmk"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_pormk"), "'", "''") & "','" & _
                             drSCORDDTL(i).Item("sod_qutno") & "','" & drSCORDDTL(i).Item("sod_refdat") & "','" & drSCORDDTL(i).Item("sod_pjobno") & "','" & _
                             drSCORDDTL(i).Item("sod_updpo") & "','" & drSCORDDTL(i).Item("sod_chgfty") & "','" & drSCORDDTL(i).Item("sod_contopc") & "','" & _
                             drSCORDDTL(i).Item("sod_ztnvbeln") & "','" & drSCORDDTL(i).Item("sod_ztnposnr") & "','" & drSCORDDTL(i).Item("sod_zorvbeln") & "','" & _
                             drSCORDDTL(i).Item("sod_zorposnr") & "','" & drSCORDDTL(i).Item("sod_tordno") & "','" & drSCORDDTL(i).Item("sod_tordseq") & "','" & _
                             drSCORDDTL(i).Item("sod_assitmcount") & "','" & drSCORDDTL(i).Item("sod_discnt") & "','" & drSCORDDTL(i).Item("sod_subcde") & "','" & _
                             drSCORDDTL(i).Item("sod_clmno") & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "','" & _
                             status & "','" & CloseOut & "','" & Replacement & "','" & drSCORDDTL(i).Item("sod_effcpo") & "','" & LCase(gsUsrID) & "'"


                    If gspStr <> "" Then  '*** if there is something to do with s ...
                        rs_AddDtl = Nothing
                        rtnLong = execute_SQLStatement(gspStr, rs_AddDtl, rtnStr)

                        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                            MsgBox("Error on saving SCM00001 #081 sp_select_SCORDDTL_insert : " & rtnStr)
                            isUpdated = False
                        Else
                            real_ordseq = rs_AddDtl.Tables("RESULT").Rows(0)(0)
                            isUpdated = True
                            'Check real order sequence no. is same as existing sequence no.
                            '-- Update Assortment Real Order Sequeence No. --
                            If rs_SCASSINF.Tables("RESULT").Rows.Count > 0 Then
                                Dim drSCASSINF() As DataRow = rs_SCASSINF.Tables("RESULT").Select("sai_ordseq = '" & drSCORDDTL(i).Item("sod_ordseq").ToString & "'")
                                rs_SCASSINF.Tables("RESULT").Columns("sai_ordseq2").ReadOnly = False
                                If drSCASSINF.Length > 0 Then
                                    For j As Integer = 0 To drSCASSINF.Length - 1
                                        drSCASSINF(j).Item("sai_ordseq2") = real_ordseq
                                    Next
                                End If
                            End If

                            '-- Update BOM Real Order Sequeence No. --
                            If rs_SCBOMINF.Tables("RESULT").Rows.Count > 0 Then
                                Dim drSCBOMINF() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = '" & drSCORDDTL(i)("sod_ordseq").ToString & "'")
                                If drSCBOMINF.Length > 0 Then
                                    rs_SCBOMINF.Tables("RESULT").Columns("sbi_ordseq2").ReadOnly = False
                                    For j As Integer = 0 To drSCBOMINF.Length - 1
                                        drSCBOMINF(j).Item("sbi_ordseq2") = real_ordseq
                                    Next
                                End If
                            End If

                            ''*******************ADD Dtl Carton*******************************************
                            'Dim drSCDTLCTN_dtl() As DataRow = rs_SCDTLCTN.Tables("RESULT").Select("sdc_creusr ='~*ADD*~' and sdc_seq = ' " & drSCORDDTL(i).Item("sod_ordseq") & "'")

                            'If drSCDTLCTN_dtl.Length > 0 Then
                            '    For j As Integer = 0 To drSCDTLCTN_dtl.Length - 1
                            '        gspStr = "sp_insert_SCDTLCTN '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & real_ordseq & _
                            '                 "','" & drSCDTLCTN_dtl(j).Item("sdc_from") & "','" & drSCDTLCTN_dtl(j).Item("sdc_to") & _
                            '                 "','" & drSCDTLCTN_dtl(j).Item("sdc_ttlctn") & "','" & LCase(gsUsrID) & "'"

                            '        If gspStr <> "" Then  '*** if there is something to do with s ...

                            '            'Fixing global company code problem at 20100420
                            '            gsCompany = Trim(cboCoCde.Text)
                            '            Update_gs_Value(gsCompany)

                            '            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                            '            If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                            '                MsgBox("Error on saving SCM00001 #082 sp_insert_SCDTLCTN : " & rtnStr)
                            '                isUpdated = False
                            '            Else
                            '                isUpdated = True
                            '            End If
                            '        End If
                            '        rs_SCDTLCTN.Tables("RESULT").Columns("sdc_creusr").ReadOnly = False
                            '        drSCDTLCTN_dtl(j).Item("sdc_creusr") = "~*ADDED*~"
                            '    Next
                            'End If
                            ''******************************************************************************
                            ''*****************ADD Dtl Shipement Date*******************************************
                            Dim drSCDTLSHP_dtl() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_creusr ='~*ADD*~' and sds_seq = ' " & drSCORDDTL(i).Item("sod_ordseq") & "'")


                            If drSCDTLSHP_dtl.Length > 0 Then
                                For j As Integer = 0 To drSCDTLSHP_dtl.Length - 1
                                    If drSCDTLSHP_dtl(j).Item("sds_pofrom") = "" Then
                                        po_from = "01/01/1900"
                                    Else
                                        If IsDate(drSCDTLSHP_dtl(j).Item("sds_pofrom")) = True Then
                                            po_from = Format(CDate(drSCDTLSHP_dtl(j).Item("sds_pofrom")), "MM/dd/yyyy")
                                        Else
                                            po_from = "01/01/1900"
                                        End If
                                    End If

                                    If drSCDTLSHP_dtl(j).Item("sds_poto") = "" Then
                                        po_to = "01/01/1900"
                                    Else
                                        If IsDate(drSCDTLSHP_dtl(j).Item("sds_poto")) = True Then
                                            po_to = Format(CDate(drSCDTLSHP_dtl(j).Item("sds_poto")), "MM/dd/yyyy")
                                        Else
                                            po_to = "01/01/1900"
                                        End If
                                    End If

                                    gspStr = "sp_insert_SCDTLSHP '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & real_ordseq & "','" & _
                                             drSCDTLSHP_dtl(j).Item("sds_scfrom") & "','" & drSCDTLSHP_dtl(j).Item("sds_scto") & "','" & _
                                             po_from & "','" & po_to & "','" & drSCDTLSHP_dtl(j).Item("sds_ordqty") & "','" & _
                                             drSCDTLSHP_dtl(j).Item("sds_ctnstr") & "','" & drSCDTLSHP_dtl(j).Item("sds_ctnend") & "','" & _
                                             drSCDTLSHP_dtl(j).Item("sds_ttlctn") & "','" & IIf(IsDBNull(drSCDTLSHP_dtl(j).Item("sds_dest")), "", Replace(drSCDTLSHP_dtl(j).Item("sds_dest"), "'", "''")) & _
                                             "','" & Replace(drSCDTLSHP_dtl(j).Item("sds_rmk"), "'", "''") & "','" & LCase(gsUsrID) & "'"

                                    If gspStr <> "" Then  '*** if there is something to do with s ...
                                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                                        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                                            MsgBox("Error on saving SCM00001 #088 sp_insert_SCDTLSHP : " & rtnStr)
                                            isUpdated = False
                                        Else
                                            isUpdated = True
                                        End If
                                    End If
                                    rs_SCDTLSHP.Tables("RESULT").Columns("sds_creusr").ReadOnly = False
                                    drSCDTLSHP_dtl(j).Item("sds_creusr") = "~*ADDED*~"
                                Next
                            End If
                            '******************************************************************************

                        End If
                    End If
                Next
            End If

            '****************************
            '*** Update Details Record***
            '****************************
            drSCORDDTL = Nothing
            Dim drSCORDDTL_ori() As DataRow
            Dim old_toordno As String
            Dim old_toordseq As String
            Dim old_ordqty As String

            If chkApprove.Checked = False And cboSCStatus.Text.Substring(0, 3) = "HLD" And status.Substring(0, 3) = "ACT" Then
                drSCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' ")
            Else
                drSCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr = '~*UPD*~' ")
            End If

            If drSCORDDTL.Length > 0 Then
                For i As Integer = 0 To drSCORDDTL.Length - 1
                    If checkUpdateDetail(drSCORDDTL(i).Item("sod_ordseq"), drSCORDDTL(i)) Then
                        drSCORDDTL_ori = Nothing
                        drSCORDDTL_ori = rs_SCORDDTL_ori.Tables("RESULT").Select("sod_ordseq = '" & drSCORDDTL(i).Item("sod_ordseq") & "'")
                        If drSCORDDTL_ori.Length > 0 Then
                            old_toordno = drSCORDDTL_ori(0).Item("sod_tordno").ToString
                            old_toordseq = drSCORDDTL_ori(0).Item("sod_tordseq").ToString
                            old_ordqty = drSCORDDTL_ori(0).Item("sod_ordqty").ToString
                        Else
                            old_toordno = ""
                            old_toordseq = "0"
                            old_ordqty = "0"
                        End If

                        If Trim(drSCORDDTL(i).Item("sod_candat").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_candat").ToString) <> "" Then
                            candat = Format(CDate(drSCORDDTL(i).Item("sod_candat")), "MM/dd/yyyy")
                        Else
                            candat = ""
                        End If

                        If Trim(drSCORDDTL(i).Item("sod_posstr").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_posstr").ToString) <> "" Then
                            posstr = Format(CDate(drSCORDDTL(i).Item("sod_posstr")), "MM/dd/yyyy")
                        Else
                            posstr = ""
                        End If

                        If Trim(drSCORDDTL(i).Item("sod_posend").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_posend").ToString) <> "" Then
                            posend = Format(CDate(drSCORDDTL(i).Item("sod_posend")), "MM/dd/yyyy")
                        Else
                            posend = ""
                        End If

                        If Trim(drSCORDDTL(i).Item("sod_poscan").ToString) <> "/  /" And Trim(drSCORDDTL(i).Item("sod_poscan").ToString) <> "" Then
                            poscan = Format(CDate(drSCORDDTL(i).Item("sod_poscan")), "MM/dd/yyyy")
                        Else
                            poscan = ""
                        End If

                        If Trim(imu_key.Text) = "" Then
                            sImu_cus1no = ""
                            sImu_cus2no = ""
                            sImu_hkprctrm = ""
                            sImu_ftyprctrm = ""
                            sImu_trantrm = ""
                            dImu_effdat = "01/01/1900"
                            dImu_expdat = "01/01/1900"
                        Else
                            sImu_cus1no = drSCORDDTL(i).Item("sod_cus1no")
                            sImu_cus2no = drSCORDDTL(i).Item("sod_cus2no")
                            sImu_hkprctrm = drSCORDDTL(i).Item("sod_hkprctrm")
                            sImu_ftyprctrm = drSCORDDTL(i).Item("sod_ftyprctrm")
                            sImu_trantrm = drSCORDDTL(i).Item("sod_trantrm")
                            dImu_effdat = Format(drSCORDDTL(i).Item("sod_effdat"), "MM/dd/yyyy")
                            dImu_expdat = Format(drSCORDDTL(i).Item("sod_expdat"), "MM/dd/yyyy")
                        End If

                        gspStr = "sp_update_SCORDDTL '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCORDDTL(i).Item("sod_ordseq") & "','" & _
                                 drSCORDDTL(i).Item("sod_venno") & "','" & drSCORDDTL(i).Item("sod_fcurcde") & "','" & drSCORDDTL(i).Item("sod_ftycst") & _
                                 "','" & drSCORDDTL(i).Item("sod_ftyprc") & "','" & drSCORDDTL(i).Item("sod_updpo") & "','" & drSCORDDTL(i).Item("sod_chgfty") & _
                                 "','" & UCase(drSCORDDTL(i).Item("sod_itmno").ToString) & "','" & drSCORDDTL(i).Item("sod_itmtyp") & "','" & _
                                 Replace(drSCORDDTL(i).Item("sod_itmdsc"), "'", "''") & "','" & drSCORDDTL(i).Item("sod_colcde") & "','" & _
                                 drSCORDDTL(i).Item("sod_cuscol") & "','" & drSCORDDTL(i).Item("sod_coldsc") & "','" & drSCORDDTL(i).Item("sod_qutno") & _
                                 "','" & Format(CDate(drSCORDDTL(i).Item("sod_refdat")), "MM/dd/yyyy") & "','" & drSCORDDTL(i).Item("sod_cusitm") & "','" & _
                                 drSCORDDTL(i).Item("sod_cussku") & "','" & drSCORDDTL(i).Item("sod_resppo") & "','" & drSCORDDTL(i).Item("sod_cuspo") & _
                                 "','" & drSCORDDTL(i).Item("sod_ordqty") & "','" & drSCORDDTL(i).Item("sod_discnt") & "','" & drSCORDDTL(i).Item("sod_oneprc") & _
                                 "','" & drSCORDDTL(i).Item("sod_untprc") & "','" & drSCORDDTL(i).Item("sod_selprc") & "','" & drSCORDDTL(i).Item("sod_hrmcde") & _
                                 "','" & drSCORDDTL(i).Item("sod_dtyrat") & "','" & drSCORDDTL(i).Item("sod_dept") & "','" & drSCORDDTL(i).Item("sod_typcode") & _
                                 "','" & drSCORDDTL(i).Item("sod_code1") & "','" & drSCORDDTL(i).Item("sod_code2") & "','" & drSCORDDTL(i).Item("sod_code3") & _
                                 "','" & drSCORDDTL(i).Item("sod_cususdcur") & "','" & drSCORDDTL(i).Item("sod_cususd") & _
                                 "','" & drSCORDDTL(i).Item("sod_cuscadcur") & "','" & drSCORDDTL(i).Item("sod_cuscad") & _
                                 "','" & drSCORDDTL(i).Item("sod_inrdin") & "','" & drSCORDDTL(i).Item("sod_inrwin") & "','" & drSCORDDTL(i).Item("sod_inrhin") & _
                                 "','" & drSCORDDTL(i).Item("sod_mtrdin") & "','" & drSCORDDTL(i).Item("sod_mtrwin") & "','" & drSCORDDTL(i).Item("sod_mtrhin") & _
                                 "','" & drSCORDDTL(i).Item("sod_inrdcm") & "','" & drSCORDDTL(i).Item("sod_inrwcm") & "','" & drSCORDDTL(i).Item("sod_inrhcm") & _
                                 "','" & drSCORDDTL(i).Item("sod_mtrdcm") & "','" & drSCORDDTL(i).Item("sod_mtrwcm") & "','" & drSCORDDTL(i).Item("sod_mtrhcm") & _
                                 "','" & Format(CDate(drSCORDDTL(i).Item("sod_shpstr")), "MM/dd/yyyy") & _
                                 "','" & Format(CDate(drSCORDDTL(i).Item("sod_shpend")), "MM/dd/yyyy") & _
                                 "','" & candat & "','" & posstr & "','" & posend & "','" & poscan & "','" & _
                                 drSCORDDTL(i).Item("sod_ctnstr") & "','" & drSCORDDTL(i).Item("sod_ctnend") & "','" & drSCORDDTL(i).Item("sod_ttlctn") & "','" & _
                                 Replace(drSCORDDTL(i).Item("sod_rmk"), "'", "''") & "','" & Replace(drSCORDDTL(i).Item("sod_pormk"), "'", "''") & "','" & _
                                 Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "','" & drSCORDDTL(i).Item("sod_pckunt") & "','" & _
                                 drSCORDDTL(i).Item("sod_inrctn") & "','" & drSCORDDTL(i).Item("sod_mtrctn") & "','" & drSCORDDTL(i).Item("sod_cft") & "','" & _
                                 drSCORDDTL(i).Item("sod_cbm") & "','" & drSCORDDTL(i).Item("sod_curcde") & "','" & drSCORDDTL(i).Item("sod_subcde") & "','" & _
                                 drSCORDDTL(i).Item("sod_ftyunt") & "','" & drSCORDDTL(i).Item("sod_venitm") & "','" & drSCORDDTL(i).Item("sod_itmprc") & "','" & _
                                 drSCORDDTL(i).Item("sod_basprc") & "','" & Replace(drSCORDDTL(i).Item("sod_pckitr"), "'", "''") & "','" & drSCORDDTL(i).Item("sod_clmno") & "','" & _
                                 drSCORDDTL(i).Item("sod_moq") & "','" & drSCORDDTL(i).Item("sod_moa") & "','" & drSCORDDTL(i).Item("sod_apprve") & "','" & _
                                 status & "','" & CloseOut & "','" & Replacement & "','" & Split(drSCORDDTL(i).Item("sod_cusven").ToString, " - ")(0) & "','" & _
                                 drSCORDDTL(i).Item("sod_cussub") & "','" & drSCORDDTL(i).Item("sod_pjobno") & "','" & drSCORDDTL(i).Item("sod_seccusitm") & _
                                 "','" & drSCORDDTL(i).Item("sod_orgmoqchg") & "','" & drSCORDDTL(i).Item("sod_moqchg") & "','" & drSCORDDTL(i).Item("sod_netuntprc") & _
                                 "','" & drSCORDDTL(i).Item("sod_bomcst") & "','" & drSCORDDTL(i).Item("sod_ztnvbeln") & "','" & _
                                 drSCORDDTL(i).Item("sod_ztnposnr") & "','" & drSCORDDTL(i).Item("sod_zorvbeln") & "','" & drSCORDDTL(i).Item("sod_zorposnr") & _
                                 "','" & IIf(drSCORDDTL(i).Item("sod_conftr").ToString = "", 1, drSCORDDTL(i).Item("sod_conftr")) & "','" & _
                                 IIf(drSCORDDTL(i).Item("sod_contopc").ToString = "", "", drSCORDDTL(i).Item("sod_contopc")) & "','" & _
                                 drSCORDDTL(i).Item("sod_pcprc") & "','" & drSCORDDTL(i).Item("sod_custum") & "','" & drSCORDDTL(i).Item("sod_dv") & "','" & _
                                 drSCORDDTL(i).Item("sod_dvftycst") & "','" & drSCORDDTL(i).Item("sod_dvftyprc") & "','" & drSCORDDTL(i).Item("sod_dvbomcst") & _
                                 "','" & drSCORDDTL(i).Item("sod_dvfcurcde") & "','" & drSCORDDTL(i).Item("sod_dvftyunt") & "','" & _
                                 drSCORDDTL(i).Item("sod_tradeven") & "','" & drSCORDDTL(i).Item("sod_examven") & "','" & drSCORDDTL(i).Item("sod_cusstyno") & _
                                 "','" & drSCORDDTL(i).Item("sod_moqunttyp") & "','" & drSCORDDTL(i).Item("sod_qutdat") & "','" & _
                                 drSCORDDTL(i).Item("sod_dvitmcst") & "','" & drSCORDDTL(i).Item("sod_itmcstcur") & "','" & "1900-01-01" & "','" & _
                                 drSCORDDTL(i).Item("sod_prcgrp") & "','" & drSCORDDTL(i).Item("sod_cus1no") & "','" & drSCORDDTL(i).Item("sod_cus2no") & _
                                 "','" & drSCORDDTL(i).Item("sod_hkprctrm") & "','" & drSCORDDTL(i).Item("sod_ftyprctrm") & "','" & _
                                 drSCORDDTL(i).Item("sod_trantrm") & "','" & drSCORDDTL(i).Item("sod_effdat") & "','" & drSCORDDTL(i).Item("sod_expdat") & _
                                 "','" & drSCORDDTL(i).Item("sod_tordno") & "','" & drSCORDDTL(i).Item("sod_tordseq") & "','" & _
                                 old_toordno & "','" & old_toordseq & "','" & old_ordqty & "','" & drSCORDDTL(i).Item("sod_year") & _
                                 "','" & drSCORDDTL(i).Item("sod_season") & "','" & drSCORDDTL(i).Item("sod_effcpo") & "','" & LCase(gsUsrID) & "'"

                        If gspStr <> "" Then  '*** if there is something to do with s ...
                            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                            If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                                MsgBox("Error on saving SCM00001 #083 sp_update_SCORDDTL : " & rtnStr)
                                isUpdated = False
                            Else
                                isUpdated = True
                            End If
                        End If
                    End If
                Next
            End If

            '************************************************************************************************************

            '***********************************************************************************************************
            '***********************************************************************************************************
            '******************************Add/Upd SCORDHDR*************************************************************
            '***********************************************************************************************************
            '***********************************************************************************************************
            Dim srname As String
            Dim saldiv As String
            Dim saltem As String

            srname = Split(cboSalesRep.Text, " - ")(0)
            saldiv = Split(txtSalDivTem.Text)(1)
            saltem = Split(Split(txtSalDivTem.Text, "TEAM ")(1), ")")(0)

            If addFlag = True Then
                ' Update Exchange Rate and Date
                SalRate(CurCde, "USD", 0, "RATE")

                '*** Add SCORDHDR
                gspStr = "sp_insert_SCORDHDR '" & cboCoCde.Text & "','" & Trim(UCase(txtSCNo.Text)) & "','" & CancelSC & "','" & SampleSC & "','" & _
                        CloseOut & "','" & Replacement & "','" & Format(CDate(txtIssDat.Text), "MM/dd/yyyy") & "','" & _
                        Format(CDate(txtRvsDat.Text), "MM/dd/yyyy") & "','" & status & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & _
                        SecCust & "','" & Replace(txtBillAdd.Text, "'", "''") & "','" & Replace(txtBillSP.Text, "'", "''") & "','" & BCountry & _
                        "','" & txtBillZIP.Text & "','" & Replace(txtShipAdd.Text, "'", "''") & "','" & txtShipSP.Text & "','" & SCountry & "','" & _
                        txtShipZIP.Text & "','" & Replace(cboContactPerson.Text, "'", "''") & "','" & srname & "','" & saldiv & "','" & saltem & _
                        "','" & Agent & "','" & cboPrcTrm.Text & "','" & PayTrm & "','" & Figtrm & "','" & Prdtrm & "','" & txtRespPO.Text & "','" & _
                        CDbl(txtTotalCube.Text) & "','" & CDbl(txtTotalCFT.Text) & "','" & CurCde & "','" & CLng(txtTotalCtn.Text) & "','" & _
                        CDbl(txtAmt.Text) & "','" & CDbl(txtNetAmt.Text) & "','" & Replace(txtRemark.Text, "'", "''") & "','" & txtCustPO.Text & "','" & _
                        Format(CDate(txtCustPoDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(txtStartShipDat.Text), "MM/dd/yyyy") & "','" & _
                        Format(CDate(txtEndShipDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(HDRCancel), "MM/dd/yyyy") & "','" & _
                        Format(CDate(strDueDat), "MM/dd/yyyy") & "','" & "" & "','" & strSAddSeq & "','" & txtEmail.Text & "','" & _
                        Trim(Me.txtMOQSC.Text) & "','" & strCurExRat & "','" & strCurExEffDat & "','" & txtCusTtlCtn.Text & "','" & _
                        txtDestination.Text & "','" & LCase(gsUsrID) & "'"

                'gspStr = "sp_insert_SCORDHDR '" & cboCoCde.Text & "','" & Trim(UCase(txtSCNo.Text)) & "','" & CancelSC & "','" & SampleSC & "','" & _
                '         CloseOut & "','" & Replacement & "','" & Format(CDate(txtIssDat.Text), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(txtRvsDat.Text), "MM/dd/yyyy") & "','" & status & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & _
                '         SecCust & "','" & Replace(txtBillAdd.Text, "'", "''") & "','" & Replace(txtBillSP.Text, "'", "''") & "','" & BCountry & _
                '         "','" & txtBillZIP.Text & "','" & Replace(txtShipAdd.Text, "'", "''") & "','" & txtShipSP.Text & "','" & SCountry & "','" & _
                '         txtShipZIP.Text & "','" & Replace(cboContactPerson.Text, "'", "''") & "','" & SalesRep & "','" & Agent & "','" & _
                '         cboPrcTrm.Text & "','" & PayTrm & "','" & Figtrm & "','" & Prdtrm & "','" & txtRespPO.Text & "','" & _
                '         CDbl(txtTotalCube.Text) & "','" & CDbl(txtTotalCFT.Text) & "','" & CurCde & "','" & CLng(txtTotalCtn.Text) & "','" & _
                '         CDbl(txtAmt.Text) & "','" & CDbl(txtNetAmt.Text) & "','" & Replace(txtRemark.Text, "'", "''") & "','" & txtCustPO.Text & "','" & _
                '         Format(CDate(txtCustPoDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(txtStartShipDat.Text), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(txtEndShipDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(HDRCancel), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(strDueDat), "MM/dd/yyyy") & "','" & "" & "','" & strSAddSeq & "','" & txtEmail.Text & "','" & _
                '         Trim(Me.txtMOQSC.Text) & "','" & strCurExRat & "','" & strCurExEffDat & "','" & txtCusTtlCtn.Text & "','" & _
                '         txtDestination.Text & "','" & LCase(gsUsrID) & "'"
            Else
                '*** Update SCORDHDR
                gspStr = "sp_update_SCORDHDR '" & cboCoCde.Text & "','" & Trim(UCase(txtSCNo.Text)) & "','" & txtSCVerNo.Text & "','" & CancelSC & _
                         "','" & SampleSC & "','" & CloseOut & "','" & Replacement & "','" & Format(CDate(txtIssDat.Text), "MM/dd/yyyy") & "','" & _
                         Format(CDate(txtRvsDat.Text), "MM/dd/yyyy") & "','" & status & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & SecCust & _
                         "','" & Replace(txtBillAdd.Text, "'", "''") & "','" & Replace(txtBillSP.Text, "'", "''") & "','" & BCountry & "','" & _
                         txtBillZIP.Text & "','" & Replace(txtShipAdd.Text, "'", "''") & "','" & Replace(txtShipSP.Text, "'", "''") & "','" & _
                         SCountry & "','" & txtShipZIP.Text & "','" & Replace(cboContactPerson.Text, "'", "''") & "','" & srname & "','" & saldiv & _
                         "','" & saltem & "','" & Agent & "','" & cboPrcTrm.Text & "','" & PayTrm & "','" & Figtrm & "','" & Prdtrm & "','" & _
                         txtRespPO.Text & "','" & CDbl(txtTotalCube.Text) & "','" & CDbl(txtTotalCFT.Text) & "','" & CurCde & "','" & _
                         CLng(txtTotalCtn.Text) & "','" & CDbl(txtAmt.Text) & "','" & CDbl(txtNetAmt.Text) & "','" & Replace(txtRemark.Text, "'", "''") & _
                         "','" & txtCustPO.Text & "','" & Format(CDate(txtCustPoDat.Text), "MM/dd/yyyy") & "','" & _
                         Format(CDate(txtStartShipDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(txtEndShipDat.Text), "MM/dd/yyyy") & "','" & _
                         Format(CDate(HDRCancel), "MM/dd/yyyy") & "','" & Format(CDate(strDueDat), "MM/dd/yyyy") & "','" & "" & "','" & strSAddSeq & _
                         "','" & txtEmail.Text & "','" & Trim(Me.txtMOQSC.Text) & "','" & strCurExRat & "','" & strCurExEffDat & "','" & _
                         txtCusTtlCtn.Text & "','" & txtDestination.Text & "','" & LCase(gsUsrID) & "'"

                'gspStr = "sp_update_SCORDHDR '" & cboCoCde.Text & "','" & Trim(UCase(txtSCNo.Text)) & "','" & txtSCVerNo.Text & "','" & CancelSC & _
                '         "','" & SampleSC & "','" & CloseOut & "','" & Replacement & "','" & Format(CDate(txtIssDat.Text), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(txtRvsDat.Text), "MM/dd/yyyy") & "','" & status & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & SecCust & _
                '         "','" & Replace(txtBillAdd.Text, "'", "''") & "','" & Replace(txtBillSP.Text, "'", "''") & "','" & BCountry & "','" & _
                '         txtBillZIP.Text & "','" & Replace(txtShipAdd.Text, "'", "''") & "','" & Replace(txtShipSP.Text, "'", "''") & "','" & _
                '         SCountry & "','" & txtShipZIP.Text & "','" & Replace(cboContactPerson.Text, "'", "''") & "','" & SalesRep & "','" & Agent & _
                '         "','" & cboPrcTrm.Text & "','" & PayTrm & "','" & Figtrm & "','" & Prdtrm & "','" & txtRespPO.Text & "','" & _
                '         CDbl(txtTotalCube.Text) & "','" & CDbl(txtTotalCFT.Text) & "','" & CurCde & "','" & CLng(txtTotalCtn.Text) & "','" & _
                '         CDbl(txtAmt.Text) & "','" & CDbl(txtNetAmt.Text) & "','" & Replace(txtRemark.Text, "'", "''") & "','" & txtCustPO.Text & _
                '         "','" & Format(CDate(txtCustPoDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(txtStartShipDat.Text), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(txtEndShipDat.Text), "MM/dd/yyyy") & "','" & Format(CDate(HDRCancel), "MM/dd/yyyy") & "','" & _
                '         Format(CDate(strDueDat), "MM/dd/yyyy") & "','" & "" & "','" & strSAddSeq & "','" & txtEmail.Text & "','" & _
                '         Trim(Me.txtMOQSC.Text) & "','" & strCurExRat & "','" & strCurExEffDat & "','" & txtCusTtlCtn.Text & "','" & _
                '         txtDestination.Text & "','" & LCase(gsUsrID) & "'"
            End If

            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
            If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on saving SCM00001 #084 " & Split(gspStr, " '")(0) & " : " & rtnStr)
                isUpdated = False
                Exit Sub
            Else
                isUpdated = True
            End If

            '************************************************************************************************************


            '***************Add / Update / delete Assort item without Real Seq**********************************
            If rs_SCASSINF_ori.Tables("RESULT").Rows.Count = 0 Then
                Dim drSCASSINF() As DataRow
                '*** Add ***
                drSCASSINF = rs_SCASSINF.Tables("RESULT").Select("sai_creusr ='~*ADD*~'")
                If drSCASSINF.Length > 0 Then
                    For i As Integer = 0 To drSCASSINF.Length - 1
                        'Checking detail record click delete flag or not ?
                        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                            Dim drTmpDtl() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_ordseq = '" & Str(drSCASSINF(i).Item("sai_ordseq")) & "' and sod_creusr <>'~*NEW*~'")
                            If drTmpDtl.Length > 0 Then
                                Update_SCASSINF_TABLE("ADD", drSCASSINF(i))
                            End If
                        End If
                    Next
                End If

                '*** Update ***
                drSCASSINF = Nothing
                drSCASSINF = rs_SCASSINF.Tables("RESULT").Select("sai_creusr ='~*UPD*~'")
                If drSCASSINF.Length > 0 Then
                    For i As Integer = 0 To drSCASSINF.Length - 1
                        Update_SCASSINF_TABLE("UPDATE", drSCASSINF(i))
                    Next
                End If
            Else
                rs_SCASSINF.Tables("RESULT").Columns("sai_creusr").ReadOnly = False
                For i As Integer = 0 To rs_SCASSINF_ori.Tables("RESULT").Rows.Count - 1
                    find_flag = False
                    If rs_SCASSINF.Tables("RESULT").Rows.Count > 0 Then
                        For j As Integer = 0 To rs_SCASSINF.Tables("RESULT").Rows.Count - 1
                            If rs_SCASSINF.Tables("RESULT").Rows(j)("sai_ordno") = rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_ordno") And _
                                 rs_SCASSINF.Tables("RESULT").Rows(j)("sai_ordseq") = rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_ordseq") And _
                                 rs_SCASSINF.Tables("RESULT").Rows(j)("sai_itmno") = rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_itmno") And _
                                 rs_SCASSINF.Tables("RESULT").Rows(j)("sai_assitm") = rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_assitm") And _
                                 rs_SCASSINF.Tables("RESULT").Rows(j)("sai_colcde") = rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_colcde") Then
                                If rs_SCASSINF.Tables("RESULT").Rows(j)("sai_assdsc").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_assdsc").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_cusitm").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_cusitm").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_coldsc").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_coldsc").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_cussku").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_cussku").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_upcean").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_upcean").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_cusrtl").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_cusrtl").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_untcde").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_untcde").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_inrqty").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_inrqty").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_mtrqty").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_mtrqty").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_cusstyno").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_cusstyno").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_tordno").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_tordno").ToString Or _
                                   rs_SCASSINF.Tables("RESULT").Rows(j)("sai_tordseq").ToString <> rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_tordseq").ToString Then
                                    rs_SCASSINF.Tables("RESULT").Rows(j)("sai_creusr") = "~*UPD*~"
                                    find_flag = True
                                Else
                                    rs_SCASSINF.Tables("RESULT").Rows(j)("sai_creusr") = "~*XXX*~"
                                    find_flag = True
                                End If
                                j = rs_SCASSINF.Tables("RESULT").Rows.Count
                            End If
                        Next
                    End If
                    If find_flag = False Then
                        Update_SCASSINF_TABLE("DELETE", rs_SCASSINF_ori.Tables("RESULT").Rows(i))
                    End If
                Next

                '*** Add ***
                Dim drSCASSINF() As DataRow
                drSCASSINF = rs_SCASSINF.Tables("RESULT").Select("sai_creusr ='~*ADD*~'")
                If drSCASSINF.Length > 0 Then
                    For i As Integer = 0 To drSCASSINF.Length - 1
                        Update_SCASSINF_TABLE("ADD", drSCASSINF(i))
                    Next
                End If

                '*** Update ***
                drSCASSINF = Nothing
                drSCASSINF = rs_SCASSINF.Tables("RESULT").Select("sai_creusr ='~*UPD*~'")
                If drSCASSINF.Length > 0 Then
                    For i As Integer = 0 To drSCASSINF.Length - 1
                        Update_SCASSINF_TABLE("UPDATE", drSCASSINF(i))
                    Next
                End If

            End If
            '***************************************************************************************************

            '***************Add / Update / delete BOM item without Real Seq**********************************
            If rs_SCBOMINF_OLD.Tables("RESULT").Rows.Count = 0 Then
                Dim drSCBOMINF() As DataRow
                '*** Add ***
                drSCBOMINF = rs_SCBOMINF.Tables("RESULT").Select("sbi_creusr ='~*ADD*~'")
                If drSCBOMINF.Length > 0 Then
                    For i As Integer = 0 To drSCBOMINF.Length - 1
                        'Checking detail record click delete flag or not ?
                        'Only update item was created.
                        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                            Dim drTmpDtl() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_ordseq = '" & Str(drSCBOMINF(i).Item("sbi_ordseq")) & "' and sod_creusr <>'~*NEW*~'")
                            If drTmpDtl.Length > 0 Then
                                Update_SCBOMINF_TABLE("ADD", drSCBOMINF(i))
                            End If
                        End If
                    Next
                End If

                '*** Update ***
                drSCBOMINF = Nothing
                drSCBOMINF = rs_SCBOMINF.Tables("RESULT").Select("sbi_creusr ='~*UPD*~'")
                If drSCBOMINF.Length > 0 Then
                    For i As Integer = 0 To drSCBOMINF.Length - 1
                        Update_SCBOMINF_TABLE("UPDATE", drSCBOMINF(i))
                    Next
                End If
            Else
                rs_SCBOMINF.Tables("RESULT").Columns("sbi_creusr").ReadOnly = False
                For i As Integer = 0 To rs_SCBOMINF_OLD.Tables("RESULT").Rows.Count - 1
                    find_flag = False
                    If rs_SCBOMINF.Tables("RESULT").Rows.Count > 0 Then
                        For j As Integer = 0 To rs_SCBOMINF.Tables("RESULT").Rows.Count - 1
                            If rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_ordno") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_ordno") And _
                                 rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_ordseq") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_ordseq") And _
                                 rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_itmno") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_itmno") And _
                                 rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_assitm") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_assitm") And _
                                 rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bomitm") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bomitm") And _
                                 rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_colcde") = rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_colcde") Then

                                If rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_assinrqty") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_assinrqty") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_assmtrqty") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_assmtrqty") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_venno") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_venno") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bomdsce") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bomdsce") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bomdscc") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bomdscc") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_coldsc") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_coldsc") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_pckunt") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_pckunt") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_ordqty") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_ordqty") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_fcurcde") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_fcurcde") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_ftyprc") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_ftyprc") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bcurcde") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bcurcde") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bomcst") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bomcst") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_obcurcde") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_obcurcde") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_obomcst") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_obomcst") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_obomprc") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_obomprc") Or _
                                   rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_bompoflg") <> rs_SCBOMINF_OLD.Tables("RESULT").Rows(i)("sbi_bompoflg") Then
                                    rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_creusr") = "~*UPD*~"
                                    find_flag = True
                                Else
                                    rs_SCBOMINF.Tables("RESULT").Rows(j)("sbi_creusr") = "~*XXX*~"
                                    find_flag = True
                                End If
                                j = rs_SCBOMINF.Tables("RESULT").Rows.Count
                            End If
                        Next
                    End If
                    If find_flag = False Then
                        Update_SCBOMINF_TABLE("DELETE", rs_SCBOMINF_OLD.Tables("RESULT").Rows(i))
                    End If
                Next

                '*** Add ***
                Dim drSCBOMINF() As DataRow
                drSCBOMINF = rs_SCBOMINF.Tables("RESULT").Select("sbi_creusr ='~*ADD*~'")
                If drSCBOMINF.Length > 0 Then
                    For i As Integer = 0 To drSCBOMINF.Length - 1
                        Update_SCBOMINF_TABLE("ADD", drSCBOMINF(i))
                    Next
                End If

                '*** Update ***
                drSCBOMINF = Nothing
                drSCBOMINF = rs_SCBOMINF.Tables("RESULT").Select("sbi_creusr ='~*UPD*~'")
                If drSCBOMINF.Length > 0 Then
                    For i As Integer = 0 To drSCBOMINF.Length - 1
                        Update_SCBOMINF_TABLE("UPDATE", drSCBOMINF(i))
                    Next
                End If

            End If

            '*************ADD/UPD/DEL DTL Shipement************************

            '******************************************************
            Dim drSCDTLSHP() As DataRow

            '****************************
            '*** Delete Details Record***
            '****************************
            drSCDTLSHP = rs_SCDTLSHP.Tables("RESULT").Select("sds_creusr ='~*DEL*~' or sds_status = 'Y'")

            For i As Integer = 0 To drSCDTLSHP.Length - 1

                gspStr = "sp_Physical_Delete_SCDTLSHP '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCDTLSHP(i).Item("sds_seq") & _
                         "','" & drSCDTLSHP(i).Item("sds_shpseq") & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...

                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on deleting SCM00001 #095 sp_Physical_Delete_SCDTLSHP : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

            Next

            '****************************
            '*** Add Details Record***
            '****************************
            drSCDTLSHP = Nothing
            drSCDTLSHP = rs_SCDTLSHP.Tables("RESULT").Select("sds_creusr ='~*ADD*~' ")

            For i As Integer = 0 To drSCDTLSHP.Length - 1
                gspStr = "sp_insert_SCDTLSHP '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCDTLSHP(i).Item("sds_seq") & "','" & _
                          drSCDTLSHP(i).Item("sds_scfrom") & "','" & drSCDTLSHP(i).Item("sds_scto") & "','" & drSCDTLSHP(i).Item("sds_pofrom") & _
                          "','" & drSCDTLSHP(i).Item("sds_poto") & "','" & drSCDTLSHP(i).Item("sds_ordqty") & "','" & _
                          drSCDTLSHP(i).Item("sds_ctnstr") & "','" & drSCDTLSHP(i).Item("sds_ctnend") & "','" & drSCDTLSHP(i).Item("sds_ttlctn") & _
                          "','" & Replace(drSCDTLSHP(i).Item("sds_dest"), "'", "''") & "','" & Replace(drSCDTLSHP(i).Item("sds_rmk"), "'", "''") & _
                          "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #096 sp_insert_SCDTLSHP : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If
            Next

            '****************************
            '*** Update Details Record***
            '****************************
            drSCDTLSHP = Nothing
            drSCDTLSHP = rs_SCDTLSHP.Tables("RESULT").Select("sds_status <> 'Y'")

            For i As Integer = 0 To drSCDTLSHP.Length - 1
                If checkUpdateShipDetail(drSCDTLSHP(i).Item("sds_seq"), drSCDTLSHP(i).Item("sds_shpseq"), drSCDTLSHP(i)) = True Then
                    If drSCDTLSHP(i).Item("sds_pofrom") = "" Then
                        po_from = "01/01/1900"
                    Else
                        If IsDate(drSCDTLSHP(i).Item("sds_pofrom")) = True Then
                            po_from = Format(CDate(drSCDTLSHP(i).Item("sds_pofrom")), "MM/dd/yyyy")
                        Else
                            po_from = "01/01/1900"
                        End If
                    End If

                    If drSCDTLSHP(i).Item("sds_poto") = "" Then
                        po_to = "01/01/1900"
                    Else
                        If IsDate(drSCDTLSHP(i).Item("sds_poto")) = True Then
                            po_to = Format(CDate(drSCDTLSHP(i).Item("sds_poto")), "MM/dd/yyyy")
                        Else
                            po_to = "01/01/1900"
                        End If
                    End If

                    gspStr = "sp_update_SCDTLSHP '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCDTLSHP(i).Item("sds_seq") & "','" & _
                        drSCDTLSHP(i).Item("sds_shpseq") & "','" & drSCDTLSHP(i).Item("sds_scfrom") & "','" & drSCDTLSHP(i).Item("sds_scto") & _
                        "','" & po_from & "','" & po_to & "','" & _
                        drSCDTLSHP(i).Item("sds_ordqty") & "','" & Trim(drSCDTLSHP(i).Item("sds_ctnstr")) & "','" & Trim(drSCDTLSHP(i).Item("sds_ctnend")) & _
                        "','" & drSCDTLSHP(i).Item("sds_ttlctn") & "','" & Replace(drSCDTLSHP(i).Item("sds_dest"), "'", "''") & "','" & _
                        Replace(drSCDTLSHP(i).Item("sds_rmk"), "'", "''") & "','" & LCase(gsUsrID) & "'"

                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #097 sp_update_SCDTLSHP : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If
            Next

            ''*************ADD/UPD/DEL COMPONENT BREAKDOWN ************************
            'Dim drSCCPTBKD As DataRow()

            ''*****************************************
            ''*** Delete Component Breakdown Record ***
            ''*****************************************
            'drSCCPTBKD = Nothing
            'drSCCPTBKD = rs_SCCPTBKD.Tables("RESULT").Select("scb_status = 'Y'")

            'For i As Integer = 0 To drSCCPTBKD.Length - 1
            '    gspStr = "sp_physical_delete_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & _
            '              drSCCPTBKD(i).Item("scb_ordseq") & "','" & drSCCPTBKD(i).Item("scb_cptseq") & "'"
            '    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
            '    If rtnLong <> RC_SUCCESS Then
            '        MsgBox("Error on deleting SCM00001 #117 sp_physical_delete_SCCPTBKD : " & rtnStr)
            '        isUpdated = False
            '    Else
            '        isUpdated = True
            '    End If
            'Next

            ''**************************************
            ''*** Add Component Breakdown Record ***
            ''**************************************
            'drSCCPTBKD = Nothing
            'drSCCPTBKD = rs_SCCPTBKD.Tables("RESULT").Select("scb_creusr = '~*ADD*~' and scb_status <> 'Y'")
            'For i As Integer = 0 To drSCCPTBKD.Length - 1
            '    gspStr = "sp_insert_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCCPTBKD(i).Item("scb_ordseq") & "','" & _
            '             drSCCPTBKD(i).Item("scb_itmno") & "','" & UCase(Replace(drSCCPTBKD(i).Item("scb_cpt"), "'", "''")) & "','" & drSCCPTBKD(i).Item("scb_curcde") & "','" & _
            '             drSCCPTBKD(i).Item("scb_cst") & "','" & drSCCPTBKD(i).Item("scb_cstpct") & "','" & drSCCPTBKD(i).Item("scb_pct") & "','" & _
            '             LCase(gsUsrID) & "'"
            '    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
            '    If rtnLong <> RC_SUCCESS Then
            '        MsgBox("Error on saving SCM00001 #118 sp_insert_SCCPTBKD : " & rtnStr)
            '        isUpdated = False
            '    Else
            '        isUpdated = True
            '    End If
            'Next

            ''*****************************************
            ''*** Update Component Breakdown Record ***
            ''*****************************************
            'drSCCPTBKD = Nothing
            'drSCCPTBKD = rs_SCCPTBKD.Tables("RESULT").Select("scb_status <> 'Y' and scb_creusr <> '~*ADD*~'")
            'For i As Integer = 0 To drSCCPTBKD.Length - 1
            '    If checkUpdateComponent(drSCCPTBKD(i).Item("scb_ordseq"), drSCCPTBKD(i).Item("scb_cptseq"), drSCCPTBKD(i)) = True Then
            '        gspStr = "sp_update_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCCPTBKD(i).Item("scb_ordseq") & _
            '             "','" & drSCCPTBKD(i).Item("scb_itmno") & "','" & drSCCPTBKD(i).Item("scb_cptseq") & _
            '             "','" & UCase(Replace(drSCCPTBKD(i).Item("scb_cpt"), "'", "''")) & "','" & drSCCPTBKD(i).Item("scb_curcde") & "','" & _
            '             drSCCPTBKD(i).Item("scb_cst") & "','" & drSCCPTBKD(i).Item("scb_cstpct") & "','" & drSCCPTBKD(i).Item("scb_pct") & "','" & LCase(gsUsrID) & "'"
            '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
            '        If rtnLong <> RC_SUCCESS Then
            '            MsgBox("Error on saving SCM00001 #119 sp_update_SCCPTBKD : " & rtnStr)
            '            isUpdated = False
            '        Else
            '            isUpdated = True
            '        End If
            '    End If
            'Next

            ' *** SALES CONFIRMATION MATERIAL BREAKDOWN ***
            Dim drSCCPTBKD As DataRow()
            Dim flag_CUCPTBKD As Boolean
            Dim flag_CheckDelete As Boolean
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                flag_CUCPTBKD = False
                flag_CheckDelete = False
                If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*NEW*~" Or rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*DEL*~" Then
                    ' Delete SC Detail - Flag for Material Breakdown removal
                    flag_CheckDelete = True
                End If

                drSCCPTBKD = rs_SCCPTBKD.Tables("RESULT").Select("scb_ordseq = '" & rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordseq").ToString & "'")
                If drSCCPTBKD.Length > 0 Then
                    For j As Integer = 0 To drSCCPTBKD.Length - 1
                        If drSCCPTBKD(j)("scb_status") = "Y" Or flag_CheckDelete = True Then
                            ' Remove Material Breakdown Component from SCCPTBKD
                            gspStr = "sp_physical_delete_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & _
                                     drSCCPTBKD(j)("scb_ordseq") & "','" & drSCCPTBKD(j)("scb_cptseq") & "'"
                            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                            If rtnLong <> RC_SUCCESS Then
                                MsgBox("Error on deleting SCM00001 #117 sp_physical_delete_SCCPTBKD : " & rtnStr)
                                isUpdated = False
                            Else
                                isUpdated = True
                            End If

                            ' Update CUCPTBKD (Once Per Detail)
                            flag_CUCPTBKD = updateCUCPTBKD(i, flag_CUCPTBKD)
                        ElseIf drSCCPTBKD(j)("scb_creusr") = "~*ADD*~" And drSCCPTBKD(j)("scb_status") <> "Y" Then
                            ' Insert Material Breakdown Component into SCCPTBKD
                            gspStr = "sp_insert_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCCPTBKD(j)("scb_ordseq") & _
                                     "','" & drSCCPTBKD(j)("scb_itmno") & "','" & UCase(Replace(drSCCPTBKD(j)("scb_cpt"), "'", "''")) & "','" & _
                                     drSCCPTBKD(j)("scb_curcde") & "','" & drSCCPTBKD(j)("scb_cst") & "','" & drSCCPTBKD(j)("scb_cstpct") & _
                                     "','" & drSCCPTBKD(j)("scb_pct") & "','" & LCase(gsUsrID) & "'"
                            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                            If rtnLong <> RC_SUCCESS Then
                                MsgBox("Error on saving SCM00001 #118 sp_insert_SCCPTBKD : " & rtnStr)
                                isUpdated = False
                            Else
                                isUpdated = True
                            End If

                            ' Update CUCPTBKD (Once Per Detail)
                            flag_CUCPTBKD = updateCUCPTBKD(i, flag_CUCPTBKD)
                        ElseIf drSCCPTBKD(j)("scb_creusr") <> "~*ADD*~" And drSCCPTBKD(j)("scb_status") <> "Y" Then
                            ' Check if update is required
                            If checkUpdateComponent(drSCCPTBKD(j)("scb_ordseq"), drSCCPTBKD(j)("scb_cptseq"), drSCCPTBKD(j)) = True Then
                                ' Update Material Breakdown Component into SCCPTBKD
                                gspStr = "sp_update_SCCPTBKD '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCCPTBKD(j)("scb_ordseq") & _
                                         "','" & drSCCPTBKD(j)("scb_itmno") & "','" & drSCCPTBKD(j)("scb_cptseq") & "','" & _
                                         UCase(Replace(drSCCPTBKD(j)("scb_cpt"), "'", "''")) & "','" & drSCCPTBKD(j)("scb_curcde") & "','" & _
                                         drSCCPTBKD(j)("scb_cst") & "','" & drSCCPTBKD(j)("scb_cstpct") & "','" & drSCCPTBKD(j)("scb_pct") & "','" & LCase(gsUsrID) & "'"
                                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                                If rtnLong <> RC_SUCCESS Then
                                    MsgBox("Error on saving SCM00001 #119 sp_update_SCCPTBKD : " & rtnStr)
                                    isUpdated = False
                                Else
                                    isUpdated = True
                                End If

                                ' Update CUCPTBKD (Once Per Detail)
                                flag_CUCPTBKD = updateCUCPTBKD(i, flag_CUCPTBKD)
                            End If
                        End If
                    Next
                End If
            Next

            '******************************Add/Upd/Del SCSHPMRK*************************************************************

            Dim drSCSHPMRK() As DataRow

            '****************************
            '*** Delete Details Record***
            '****************************
            drSCSHPMRK = rs_SCSHPMRK.Tables("RESULT").Select("ssm_creusr ='~*DEL*~'")

            For i As Integer = 0 To drSCSHPMRK.Length - 1

                gspStr = "sp_Physical_Delete_SCSHPMRK '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & drSCSHPMRK(i).Item("ssm_shptyp") & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...

                    'Fixing global company code problem at 20100420
                    gsCompany = Trim(cboCoCde.Text)
                    Update_gs_Value(gsCompany)

                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on deleting SCM00001 #098 sp_Physical_Delete_SCSHPMRK : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If
            Next

            '****************************
            '*** Add Details Record***
            '****************************
            drSCSHPMRK = Nothing
            drSCSHPMRK = rs_SCSHPMRK.Tables("RESULT").Select("ssm_creusr ='~*ADD*~' ")


            For i As Integer = 0 To drSCSHPMRK.Length - 1

                gspStr = "sp_insert_SCSHPMRK '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & _
                         Replace(drSCSHPMRK(i).Item("ssm_imgnam"), "'", "''") & "','" & drSCSHPMRK(i).Item("ssm_imgpth") & "','" & _
                         Replace(drSCSHPMRK(i).Item("ssm_shptyp"), "'", "''") & "','" & Replace(drSCSHPMRK(i).Item("ssm_engdsc"), "'", "''") & _
                         "','" & Replace(drSCSHPMRK(i).Item("ssm_chndsc"), "'", "''") & "','" & _
                         Replace(drSCSHPMRK(i).Item("ssm_engrmk"), "'", "''") & "','" & Replace(drSCSHPMRK(i).Item("ssm_chnrmk"), "'", "''") & _
                         "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...

                    'Fixing global company code problem at 20100420
                    gsCompany = Trim(cboCoCde.Text)
                    Update_gs_Value(gsCompany)

                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #099 sp_insert_SCSHPMRK : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If
            Next

            '****************************
            '*** Update Details Record***
            '****************************
            drSCSHPMRK = Nothing
            drSCSHPMRK = rs_SCSHPMRK.Tables("RESULT").Select("ssm_creusr ='~*UPD*~' ")


            For i As Integer = 0 To drSCSHPMRK.Length - 1

                gspStr = "sp_update_SCSHPMRK '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & Replace(drSCSHPMRK(i).Item("ssm_imgnam"), "'", "''") & _
                         "','" & drSCSHPMRK(i).Item("ssm_imgpth") & "','" & drSCSHPMRK(i).Item("ssm_shptyp") & "','" & _
                         Replace(drSCSHPMRK(i).Item("ssm_engdsc"), "'", "''") & "','" & Replace(drSCSHPMRK(i).Item("ssm_chndsc"), "'", "''") & "','" & _
                         Replace(drSCSHPMRK(i).Item("ssm_engrmk"), "'", "''") & "','" & Replace(drSCSHPMRK(i).Item("ssm_chnrmk"), "'", "''") & "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...

                    'Fixing global company code problem at 20100420
                    gsCompany = Trim(cboCoCde.Text)
                    Update_gs_Value(gsCompany)

                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #100 sp_update_SCSHPMRK : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If
            Next

            ''************************************************************************************************************

            '*********************************
            '*** Update PO Shipmark Record ***
            '*********************************
            Dim drPOSHPMRK() As DataSet
            drPOSHPMRK = Nothing
            'drPOSHPMRK = rs_POSHPMRK.Tables("RESULT").Select("psm_


            Me.Cursor = Windows.Forms.Cursors.Default
            Temp_SCno = txtSCNo.Text

            ' Print Cancellation SC with BOM Item
            If CancelSC = "Y" Then
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                gsCompany = Trim(cboCoCde.Text)
                Update_gs_Value(gsCompany)
                'If SCR00003.SCR00003_showSC_BOMPO(UCase(txtSCNo.Text), UCase(txtSCNo.Text)) = "No Record Found" Then
                '    MsgBox("No BOM item found in this calcellated S/C.")
                'End If
                Me.Cursor = Windows.Forms.Cursors.Default
            End If

            setStatus("Save")
            cmdClear.PerformClick()
        End If
    End Sub

    Private Sub cmdCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCopy.Click
        If Cust_InActive = True And Not rs_CUBASINF_P.Tables.Count = 0 Then
            MsgBox("This SC's Customer is Inactive Status or Deleted from Customer Master", MsgBoxStyle.Information, "Message")
            Exit Sub
        End If

        If Split(cboSCStatus.Text, " - ")(0) = "HLD" Then
            MsgBox("This SC in Hold status!", MsgBoxStyle.Information, "Message")
            Exit Sub
        End If

        tabFrame.SelectedIndex = tabFrame_Header

        freeze_TabControl(tabFrame_Header)
        grpHeader.Enabled = False
        panSCCopyCust.Width = 385
        panSCCopyCust.Height = 223
        panSCCopyCust.Location = New Point(275, 200)
        panSCCopyCust.Visible = True
        loadPanSCCopyCust()
    End Sub
    'Private Sub cmdCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCopy.Click
    '    gsCompany = Trim(cboCoCde.Text)

    '    If Cust_InActive = True And Not rs_CUBASINF_P.Tables.Count = 0 Then
    '        MsgBox("This SC's Customer is InActive Status or Deleted from Customer Master", MsgBoxStyle.Information, "Message")
    '        Exit Sub
    '    End If

    '    If Split(cboSCStatus.Text, " - ")(0) <> "HLD" Then
    '        addFlag = True
    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor

    '        'If CopySC_SUB Is Nothing Then
    '        CopySC_SUB = New frmCopySC
    '        CopySC_SUB.myOwner = Me
    '        'End If
    '        CopySC_SUB.rs_SCORDDTL_Copy = rs_SCORDDTL.Copy()
    '        CopySC_SUB.rs_SCORDDTL_Fail = rs_SCORDDTL.Clone()
    '        CopySC_SUB.rs_SCASSINF_Copy = rs_SCASSINF.Clone()
    '        CopySC_SUB.rs_SCBOMINF_Copy = rs_SCBOMINF.Clone()

    '        chkReplacement.Checked = False
    '        chkCloseOut.Checked = False

    '        Enq_right = Enq_right_local

    '        'If CopySC_Cust_SUB Is Nothing Then
    '        CopySC_Cust_SUB = New frmCopySC_Cust
    '        CopySC_Cust_SUB.myOwner = Me
    '        'End If

    '        CopySC_Cust_SUB.ShowDialog()

    '    Else
    '        MsgBox("This SC in Hold status!", MsgBoxStyle.Information, "Message")
    '        Exit Sub
    '    End If

    '    If copyFlag = True Then
    '        If tabFrame.SelectedIndex <> 0 Then
    '            tabFrame.SelectTab(0)
    '        End If

    '        currentRow = 0
    '        currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
    '        MaxSeq = rs_SCORDDTL.Tables("RESULT").Rows(0)("max_seq")

    '        display_combo("ACT", cboSCStatus)
    '        Cal_TotalAmt()
    '        setStatus("ADD")
    '        rs_SCORDHDR.Tables("RESULT").Columns("soh_ordsts").ReadOnly = False
    '        rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts") = "ACT"

    '        ' Mark Lau 20081110
    '        'lblDVTtlCstCur.Text = ""
    '        txtDVTtlCst.Text = "0"
    '        lblDVFtyUnt.Text = ""
    '        lblDVItmCstCur.Text = ""
    '        'lblDVBOMCstCur.Text = ""
    '        txtDVItmCst.Text = "0"
    '        txtDVBOMCst.Text = "0"
    '        lblDVName.Text = ""

    '        'Added by Mark Lau 20090831
    '        strCurExRat = "0"
    '        strCurExEffDat = ""
    '        strCurExRat = CopySC_SUB.strCurExRat
    '        strCurExEffDat = CopySC_SUB.strCurExEffDat

    '        ClearDVTtlCst()

    '        '***********Folder 4************************
    '        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
    '            recordMove("LOAD")
    '        Else
    '            setDtlStatus("INIT")
    '        End If


    '        'hdr_CanDat = Format(Date.Now, "MM/DD/yyyy")
    '        hdr_ShpStrDat = Format(Date.Now, "MM/DD/yyyy")
    '        hdr_ShpEndDat = Format(Date.Now, "MM/dd/yyyy")
    '        hdr_CustPODat = Format(Date.Now, "MM/dd/yyyy")
    '        txtCustPO.Text = ""
    '        Me.txtMOQSC.Text = "" 'Lester Wu 2007-10-07

    '        ' Mark Lau 20080618
    '        cboCustUM.Items.Clear()
    '        LoadCustUM()

    '        ' Added by Mark Lau 20090918
    '        Dim strRemark As String
    '        strRemark = ""
    '        strRemark = txtRemark.Text

    '        ' Added by Mark Lau 20090707
    '        Dim strOldPriCust As String
    '        Dim strOldSecCust As String

    '        strOldPriCust = Split(cboPriCust.Text, " - ")(0)

    '        If Trim(cboSecCust.Text) <> "" Then
    '            strOldSecCust = Split(cboSecCust.Text, " - ")(0)
    '        Else
    '            strOldSecCust = ""
    '        End If


    '        ' Added by Mark Lau 20091014
    '        Dim strOldCocde As String
    '        strOldCocde = Me.cboCoCde.Text
    '        If CopySC_SUB.strNewCocde <> strOldCocde Then
    '            display_combo(CopySC_SUB.strNewCocde, cboCoCde)
    '        End If


    '        If (strOldPriCust <> strPriCust_Copy) Or (strOldSecCust <> strSecCust_Copy) Or (CopySC_SUB.strNewCocde <> strOldCocde) Then
    '            ' Added by Mark Lau 20090518
    '            display_combo(strPriCust_Copy, cboPriCust)

    '            display_combo(strSecCust_Copy, cboSecCust)
    '        End If

    '        txtRespPO.Text = ""
    '        txtCustPoDat.Text = Format(Date.Now, "MM/dd/yyyy")
    '        txtCancelDat.Text = Format(Date.Now, "MM/dd/yyyy")
    '        txtStartShipDat.Text = Format(Date.Now, "MM/dd/yyyy")
    '        txtEndShipDat.Text = Format(Date.Now, "MM/dd/yyyy")
    '        txtCusTtlCtn.Text = ""
    '        txtDestination.Text = ""
    '        txtCustPO.Enabled = True
    '        '**************Display Primary Customer information***********************
    '        '    txtBillAdd.Text = rs_CUBASINF_P("cci_cntadr").Value
    '        ' Allan Yuen
    '        'txtBillAdd.Text = rs_CUBASINF_P("cci_cntadr").value
    '        If rs_CUCNTINF_BA.Tables("RESULT").Rows.Count > 0 Then
    '            txtBillAdd.Text = rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntadr")
    '        Else
    '            txtBillAdd.Text = ""
    '        End If

    '        Dim dr_CUBASINF_P() As DataRow = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & strPriCust_Copy & "'")

    '        txtBillSP.Text = dr_CUBASINF_P(0).Item("cci_cntstt")
    '        txtBillZIP.Text = dr_CUBASINF_P(0).Item("cci_cntpst")
    '        display_combo(dr_CUBASINF_P(0).Item("cci_cntcty"), cboBillCountry)
    '        If rs_CUBASINF_S.Tables("RESULT").Rows.Count > 0 And Trim(cboSecCust.Text) <> "" Then
    '            Dim dr_CUBASINF_S() As DataRow = rs_CUBASINF_S.Tables("RESULT").Select("csc_seccus = " & "'" & Split(cboSecCust.Text, " - ")(0) & "'")
    '            If dr_CUBASINF_S.Length > 0 Then
    '                If dr_CUBASINF_S(0).Item("ship_cci_cntadr").ToString <> "N/A" Then
    '                    txtShipAdd.Text = dr_CUBASINF_S(0).Item("ship_cci_cntadr")
    '                    txtShipSP.Text = dr_CUBASINF_S(0).Item("ship_cci_cntstt")
    '                    If dr_CUBASINF_S(0).Item("ship_cci_cntcty").ToString <> "" Then
    '                        Call display_combo(dr_CUBASINF_S(0).Item("ship_cci_cntcty"), cboShipCountry)
    '                    Else
    '                        cboShipCountry.SelectedIndex = -1
    '                    End If
    '                    txtShipZIP.Text = dr_CUBASINF_S(0).Item("ship_cci_cntpst")
    '                    txtRemark.Text = dr_CUBASINF_S(0).Item("cbi_cerdoc")
    '                End If
    '            Else
    '                txtRemark.Text = ""
    '                txtShipAdd.Text = ""
    '                txtShipSP.Text = ""
    '                display_combo("", cboShipCountry)
    '                txtShipZIP.Text = ""

    '            End If
    '        Else
    '            txtRemark.Text = dr_CUBASINF_P(0).Item("cbi_cerdoc")
    '            txtShipAdd.Text = dr_CUBASINF_P(0).Item("ship_cci_cntadr")
    '            txtShipSP.Text = dr_CUBASINF_P(0).Item("ship_cci_cntstt")
    '            If dr_CUBASINF_P(0).Item("ship_cci_cntcty").ToString <> "" Then
    '                display_combo(dr_CUBASINF_P(0).Item("ship_cci_cntcty"), cboShipCountry)
    '            Else
    '                cboShipCountry.SelectedIndex = -1
    '            End If
    '            txtShipZIP.Text = dr_CUBASINF_P(0).Item("ship_cci_cntpst")
    '            fillcboShipAdd("P")
    '        End If
    '        '***************************************************************************
    '        ' Added by Mark Lau 20080628
    '        If rs_CUBASINF_Person.Tables("RESULT").Rows.Count > 0 Then
    '            Dim dr_CUBASINF_Person() As DataRow = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'BUYR'")
    '            If dr_CUBASINF_Person.Length = 0 Then
    '                dr_CUBASINF_Person = Nothing
    '                dr_CUBASINF_Person = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'SALE'")
    '            End If

    '            If dr_CUBASINF_Person.Length = 0 Then
    '                dr_CUBASINF_Person = Nothing
    '                dr_CUBASINF_Person = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'MAGT'")
    '            End If

    '            If dr_CUBASINF_Person.Length = 0 Then
    '                dr_CUBASINF_Person = Nothing
    '                dr_CUBASINF_Person = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y'")
    '            End If

    '            If dr_CUBASINF_Person.Length > 0 Then
    '                cboContactPerson.Enabled = True
    '                display_combo(dr_CUBASINF_Person(0).Item("cci_cntctp"), cboContactPerson)
    '            Else
    '                cboContactPerson.Enabled = False
    '            End If
    '        Else
    '            cboContactPerson.Enabled = False
    '        End If

    '        ' Added by Mark Lau 20080620
    '        txtEmail.Enabled = True
    '        '***************************************************************************
    '        display_combo(dr_CUBASINF_P(0).Item("cbi_srname"), cboSalesRep)
    '        display_combo(dr_CUBASINF_P(0).Item("cpi_prctrm"), cboPrcTrm)
    '        display_combo(dr_CUBASINF_P(0).Item("cpi_paytrm"), cboPayTrm)
    '        lblTtlAmtCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        lblNetAmtCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        '******************Detial Folder*************************
    '        lblSelprcCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        lblBasprcCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        lblPCPrcCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        lblSubttlCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        lblNetprcCur.Text = dr_CUBASINF_P(0).Item("cpi_curcde")
    '        '******************Ship Mark*****************************
    '        If rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0 Then
    '            rs_SCSHPMRK.Tables("RESULT").Columns("ssm_creusr").ReadOnly = False
    '            For i As Integer = 0 To rs_SCSHPMRK.Tables("RESULT").Rows.Count - 1
    '                If rs_SCSHPMRK.Tables("RESULT").Rows(i)("ssm_creusr").ToString <> "~*DEL*~" And _
    '                   rs_SCSHPMRK.Tables("RESULT").Rows(i)("ssm_creusr").ToString <> "~*NEW*~" Then
    '                    If (strOldPriCust <> strPriCust_Copy) Or (strOldSecCust <> strSecCust_Copy) Then
    '                        rs_SCSHPMRK.Tables("RESULT").Rows(i).Delete()
    '                        txtEngDsc.Text = ""
    '                        txtChiDsc.Text = ""
    '                        txtEngRmk.Text = ""
    '                        txtChiRmk.Text = ""
    '                    Else
    '                        rs_SCSHPMRK.Tables("RESULT").Rows(i)("ssm_creusr") = "~*ADD*~"
    '                    End If
    '                End If
    '            Next
    '            rs_SCSHPMRK.AcceptChanges()
    '        End If


    '        ' Added by Mark Lau 20090918
    '        If (strOldPriCust = strPriCust_Copy) And (strOldSecCust = strSecCust_Copy) Then
    '            txtRemark.Text = strRemark
    '        End If


    '        strPriCust_Copy = ""
    '        strSecCust_Copy = ""

    '        '******************Dis & Pre*****************************
    '        If rs_SCDISPRM_D.Tables("RESULT").Rows.Count > 0 Then
    '            rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
    '            rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
    '            For i As Integer = 0 To rs_SCDISPRM_D.Tables("RESULT").Rows.Count - 1
    '                If rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
    '                    rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") = "~*ADD*~"
    '                End If
    '                If rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_pctamt") <> "Amount" And Val(rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_amt")) > 0 Then
    '                    rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_amt") = 0
    '                End If
    '            Next
    '        End If
    '        If rs_SCDISPRM_P.Tables("RESULT").Rows.Count > 0 Then
    '            rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
    '            rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
    '            For i As Integer = 0 To rs_SCDISPRM_P.Tables("RESULT").Rows.Count - 1
    '                If rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
    '                    rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") = "~*ADD*~"
    '                End If
    '                If rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_pctamt") <> "Amount" And Val(rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_amt")) > 0 Then
    '                    rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_amt") = 0
    '                End If
    '            Next
    '        End If

    '        SetComboStatus(cboPriCust, "Disable")
    '        SetComboStatus(cboSecCust, "Disable")

    '        '*******************************************
    '        '--- Retrive Customer request charge moq or not ----
    '        Dim rsCUITMPRC As DataSet
    '        Dim rsIMBOMASS As DataSet
    '        Dim rsIMBOMINF As DataSet
    '        Dim rs As DataSet
    '        Dim SecCust As String

    '        gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & Trim(Split(cboPrdVen.Text, "-")(0)) & "'"
    '        'Fixing global company code problem at 20100420
    '        gsCompany = Trim(cboCoCde.Text)
    '        Update_gs_Value(gsCompany)

    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
    '            Me.Cursor = Windows.Forms.Cursors.Default
    '            MsgBox("Error on loading SCM00001 #102 sp_select_VNBASINF : " & rtnStr)
    '            Exit Sub
    '        Else
    '            If rs.Tables("RESULT").Rows.Count > 0 Then
    '                If rs.Tables("RESULT").Rows(0)("vbi_moqchg") = "Y" Then
    '                    VENMOQChgFlag = True
    '                Else
    '                    VENMOQChgFlag = False
    '                End If
    '            End If
    '        End If
    '        '-------------------------------------

    '        '---- Get Customer Charge MOQ or not
    '        gspStr = "sp_select_CUPRCINF '" & cboCoCde.Text & "','" & Trim(Split(cboPriCust.Text, "-")(0)) & "'"
    '        'Fixing global company code problem at 20100420
    '        gsCompany = Trim(cboCoCde.Text)
    '        Update_gs_Value(gsCompany)

    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '        rs = Nothing
    '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
    '            Me.Cursor = Windows.Forms.Cursors.Default
    '            MsgBox("Error on loading SCM00001 #103 sp_select_CUPRCINF : " & rtnStr)
    '            Exit Sub
    '        Else
    '            If rs.Tables("RESULT").Rows.Count > 0 Then
    '                If rs.Tables("RESULT").Rows(0)("cpi_moqchgflg") = "Y" Then
    '                    CUSMOQChgFlag = True
    '                Else
    '                    CUSMOQChgFlag = False
    '                End If
    '            End If
    '        End If
    '        '------------------------------------

    '        For j As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
    '            For k As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
    '                rs_SCORDDTL.Tables("RESULT").Columns(k).ReadOnly = False
    '            Next
    '            '
    '            '    While Not rs_SCORDDTL.EOF
    '            If (Trim(cboSecCust.Text) = "") Then
    '                SecCust = ""
    '            Else
    '                SecCust = Split(cboSecCust.Text, " - ")(0)
    '            End If

    '            '***********Commented by Carlos Lui 20120704**********
    '            gspStr = "sp_select_CUITMSUM_SCV2 '" & cboCoCde.Text & "','" & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_itmno") & "','" & SecCust & "','" & Split(cboPriCust.Text, " - ")(0) & "'"
    '            'Fixing global company code problem at 20100420
    '            gsCompany = Trim(cboCoCde.Text)
    '            Update_gs_Value(gsCompany)

    '            Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '            rs_CUITMPRC = Nothing
    '            rtnLong = execute_SQLStatement(gspStr, rs_CUITMPRC, rtnStr)


    '            '******************************************************************************************************
    '            '****************************Query CUITMSUM ****************************************************
    '            '******************************************************************************************************
    '            If rtnLong <> RC_SUCCESS Then
    '                Me.Cursor = Windows.Forms.Cursors.Default
    '                MsgBox("Error on loading SCM00001 #104 sp_select_CUITMSUM_SCV : " & rtnStr)
    '                Exit Sub
    '            Else
    '                If rs_CUITMPRC.Tables("RESULT").Rows.Count > 0 Then
    '                    Dim dr_CUITMPRC() As DataRow = rs_CUITMPRC.Tables("RESULT").Select("cis_untcde = '" & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_pckunt") & _
    '                                                                                       "' and cis_inrqty = " & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_inrctn") & _
    '                                                                                       " and cis_mtrqty = " & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_mtrctn") & _
    '                                                                                       " and cis_colcde = '" & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_colcde") & _
    '                                                                                       "' and cis_cft = " & rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_cft"))
    '                    If dr_CUITMPRC.Length <> 1 Then
    '                        Me.Cursor = Windows.Forms.Cursors.Default
    '                        MsgBox("Error get CIH price during copy!")
    '                        Exit Sub
    '                    End If

    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_netuntprc") = rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_untprc")

    '                    'Update Key information
    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_cus1no") = dr_CUITMPRC(0).Item("imu_cus1no")
    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_cus2no") = dr_CUITMPRC(0).Item("imu_cus2no")
    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_hkprctrm") = dr_CUITMPRC(0).Item("imu_hkprctrm")
    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_ftyprctrm") = dr_CUITMPRC(0).Item("imu_ftyprctrm")
    '                    rs_SCORDDTL.Tables("RESULT").Rows(j)("sod_trantrm") = dr_CUITMPRC(0).Item("imu_trantrm")

    '                    sImu_cus1no = dr_CUITMPRC(0).Item("imu_cus1no")
    '                    sImu_cus2no = dr_CUITMPRC(0).Item("imu_cus2no")
    '                    sImu_hkprctrm = dr_CUITMPRC(0).Item("imu_hkprctrm")
    '                    sImu_ftyprctrm = dr_CUITMPRC(0).Item("imu_ftyprctrm")
    '                    sImu_trantrm = dr_CUITMPRC(0).Item("imu_trantrm")

    '                    'aabbcc TO BE COMPLETED
    '                    'fillVenMrk(dr_CUITMPRC(0).Item("cis_itmno"), dr_CUITMPRC(0).Item("cis_untcde"), dr_CUITMPRC(0).Item("cis_inrqty"), dr_CUITMPRC(0).Item("cis_mtrqty"))
    '                    'fillCusVen(dr_CUITMPRC(0).Item("cis_itmno"))

    '                    '***************Get Assort Item******************
    '                    Dim Tibi_typ As String

    '                    '**** Allan Yuen add this function cater item have assortment or not
    '                    Tibi_typ = ""
    '                    If dr_CUITMPRC.Length > 0 Then
    '                        For l As Integer = 0 To dr_CUITMPRC.Length - 1
    '                            If Tibi_typ <> "ASS" Then
    '                                Tibi_typ = dr_CUITMPRC(l).Item("ibi_typ")
    '                            End If
    '                        Next
    '                    End If

    '                    If Tibi_typ = "ASS" Then
    '                        gspStr = "sp_select_IMBOMASS_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & Split(cboPriCust.Text, " - ")(0) & "'"
    '                        'Fixing global company code problem at 20100420
    '                        gsCompany = Trim(cboCoCde.Text)
    '                        Update_gs_Value(gsCompany)

    '                        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '                        rs_IMBOMASS = Nothing
    '                        rtnLong = execute_SQLStatement(gspStr, rs_IMBOMASS, rtnStr)

    '                        If rtnLong <> RC_SUCCESS Then
    '                            Me.Cursor = Windows.Forms.Cursors.Default
    '                            MsgBox("Error on loading SCM00001 #105 sp_select_IMBOMASS_SC : " & rtnStr)
    '                            Exit Sub
    '                        Else
    '                            '*******If got IMBOMASS Record*****************
    '                            If rs_IMBOMASS.Tables("RESULT").Rows.Count > 0 Then
    '                                assItmCount = rs_IMBOMASS.Tables("RESULT").Rows.Count
    '                            Else
    '                                assItmCount = 1
    '                            End If
    '                            '**********************************************
    '                        End If
    '                    Else
    '                        assItmCount = 1
    '                    End If
    '                End If
    '            End If

    '            'aabbcc
    '            'cboVenno_ChangeVenno()
    '            cboPrdVen_ChangePV()
    '            If rs_SCORDDTL.Tables("RESULT").Rows.Count <> 1 Then
    '                If j = rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
    '                    recordMove("BACK")
    '                Else
    '                    recordMove("NEXT")
    '                End If
    '                'If j < rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
    '                '    recordMove("NEXT")
    '                'End If
    '            Else
    '                updateDetailRS()
    '            End If
    '        Next

    '        For k As Integer = 1 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
    '            recordMove("BACK")
    '        Next


    '        Display_Dtl("SCORDDTL")
    '        setStatus("Updating")

    '        cboCusStyNo.Enabled = True

    '        Me.Cursor = Windows.Forms.Cursors.Default

    '    Else
    '        '* Allan Yuen Fix Copy Funcation bug at 2003/02/11
    '        addFlag = False
    '        Me.Cursor = Windows.Forms.Cursors.Default
    '    End If
    'End Sub

    Public Sub cmdFind_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdFind.Click
        '*** perform query on database after user input an item number
        If (Trim(txtSCNo.Text) = "") Then
            If txtSCNo.Enabled And txtSCNo.Visible Then
                txtSCNo.Focus()
            End If
            MsgBox("Please Enter SC Number")
            Exit Sub
        End If

        findFlag = True

        '--- Update Company Code before execute ---
        gsCompany = Trim(cboCoCde.Text)
        Update_gs_Value(gsCompany)

        Dim rsSCORDHDR(1) As DataSet

        gspStr = "sp_select_SCORDHDR '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rsSCORDHDR(0), rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #010 sp_select_SCORDHDR : " & rtnStr)
            Exit Sub
        End If

        If rsSCORDHDR(0).Tables("RESULT").Rows.Count = 0 Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("No Record Found!")
            Exit Sub
        Else
            rs_SCORDHDR = rsSCORDHDR(0).Copy()

            For i As Integer = 0 To rs_SCORDHDR.Tables("RESULT").Columns.Count - 1
                rs_SCORDHDR.Tables("RESULT").Columns(i).ReadOnly = False
            Next

            currentRow = 0

            gspStr = "sp_select_SYUSRRIGHT_Check '" & cboCoCde.Text & "','" & LCase(gsUsrID) & "','" & txtSCNo.Text & "','" & strModule & "'"
            rtnLong = execute_SQLStatement(gspStr, rsSCORDHDR(1), rtnStr)

            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #011 sp_select_SYUSRRIGHT_Check : " & rtnStr)
                Exit Sub
            End If

            If rsSCORDHDR(1).Tables("RESULT").Rows.Count = 0 Then
                MsgBox("You have no access rights to this document.")
                Exit Sub
            End If
        End If

        gspStr = "sp_select_SCCNTINF '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_SCCNTINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #012 sp_select_SCCNTINF : " & rtnStr)
            Exit Sub
        End If

        gspStr = "sp_select_SCDISPRM '" & cboCoCde.Text & "','" & txtSCNo.Text & "','D'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCDISPRM_D, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #013 sp_select_SCDISPRM : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCDISPRM_D.Tables("RESULT").Columns.Count - 1
                rs_SCDISPRM_D.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCDISPRM_D_ori = rs_SCDISPRM_D.Copy()
            'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_cde").ReadOnly = False
            'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_dsc").ReadOnly = False
            'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_pctamt").ReadOnly = False
            'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_pct").ReadOnly = False
            'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
        End If

        gspStr = "sp_select_SCDISPRM '" & cboCoCde.Text & "','" & txtSCNo.Text & "','P'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCDISPRM_P, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #014 sp_select_SCDISPRM : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCDISPRM_P.Tables("RESULT").Columns.Count - 1
                rs_SCDISPRM_P.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCDISPRM_P_ori = rs_SCDISPRM_P.Copy()
            'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_cde").ReadOnly = False
            'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_dsc").ReadOnly = False
            'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_pctamt").ReadOnly = False
            'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_pct").ReadOnly = False
            'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
        End If

        gspStr = "sp_select_SCORDDTL '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCORDDTL, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #015 sp_select_SCORDDTL : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
                rs_SCORDDTL.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCORDDTL_ori = rs_SCORDDTL.Copy()

            'currentOrdSeq = 1
            currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(0)("sod_ordseq")
        End If

        gspStr = "sp_select_SCCPTBKD '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCCPTBKD, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #111 sp_select_SCCPTBKD : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCCPTBKD.Tables("RESULT").Columns.Count - 1
                rs_SCCPTBKD.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCCPTBKD_ori = rs_SCCPTBKD.Copy()
        End If

        gspStr = "sp_select_SCSHPMRK '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCSHPMRK, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #016 sp_select_SCSHPMRK : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCSHPMRK.Tables("RESULT").Columns.Count - 1
                rs_SCSHPMRK.Tables("RESULT").Columns(i).ReadOnly = False
            Next
        End If
        gspStr = "sp_select_SCASSINF '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCASSINF, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #017 sp_select_SSCASSINF : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCASSINF.Tables("RESULT").Columns.Count - 1
                rs_SCASSINF.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCASSINF_ori = rs_SCASSINF.Copy()
        End If
        gspStr = "sp_select_SCDTLSHP '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCDTLSHP, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #018 sp_select_SCDTLSHP : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCDTLSHP.Tables("RESULT").Columns.Count - 1
                rs_SCDTLSHP.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCDTLSHP_ori = rs_SCDTLSHP.Copy()
        End If
        'gspStr = "sp_select_SCDTLCTN '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        'rtnLong = execute_SQLStatement(gspStr, rs_SCDTLCTN, rtnStr)
        '
        'If rtnLong <> RC_SUCCESS Then
        '    Me.Cursor = Windows.Forms.Cursors.Default
        '    MsgBox("Error on loading SCM00001 #019 sp_select_SCDTLCTN : " & rtnStr)
        '    Exit Sub
        'End If
        gspStr = "sp_select_SCBOMINF '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_SCBOMINF, rtnStr)

        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #020 sp_select_SCBOMINF : " & rtnStr)
            Exit Sub
        Else
            For i As Integer = 0 To rs_SCBOMINF.Tables("RESULT").Columns.Count - 1
                rs_SCBOMINF.Tables("RESULT").Columns(i).ReadOnly = False
            Next
            rs_SCBOMINF_OLD = rs_SCBOMINF.Copy()
        End If

        If rs_SCORDHDR.Tables("RESULT").Rows.Count > 0 Then
            current_TimeStamp = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_timstp")
            skipDVErrorFlag = True
            If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                lblTtlAmt.Visible = False
                lblTtlAmtCur.Visible = False
                txtAmt.Visible = False
                lblNetAmt.Visible = False
                lblNetAmtCur.Visible = False
                txtNetAmt.Visible = False
                setDtlStatus("NoPrice")
            Else
                lblTtlAmt.Visible = True
                lblTtlAmtCur.Visible = True
                txtAmt.Visible = True
                lblNetAmt.Visible = True
                lblNetAmtCur.Visible = True
                txtNetAmt.Visible = True
                setDtlStatus("Price")
            End If

            SetComboStatus(cboPriCust, "Disable")
            SetComboStatus(cboSecCust, "Disable")
            display()
            setStatus("Updating")
            display_UpdatePO()
            skipDVErrorFlag = False
            recordStatus = False
            tabFrame.Focus()
        End If

        findFlag = False
    End Sub

    Private Sub cmdClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdClear.Click
        Dim YesNoCancel As Integer
        Dim status As String

        If cboSCStatus.Text = "" Then
            status = ""
        Else
            status = Split(cboSCStatus.Text, " - ")(0)
        End If

        If cmdSave.Enabled = False Then
            recordStatus = False
        End If

        If recordStatus = True And (status = "ACT" Or status = "HLD") Then
            If addFlag = True Then
                YesNoCancel = MsgBox("Record is newly created.  Do you want to save before clear the screen?", MsgBoxStyle.YesNoCancel, "Clear Entry")
            Else
                YesNoCancel = MsgBox("Record has been modified.  Do you want to save before clear the screen?", MsgBoxStyle.YesNoCancel, "Clear Entry")
            End If

            If YesNoCancel = MsgBoxResult.Yes Then
                If cmdSave.Enabled Then
                    exitFlag = True
                    cmdSave.PerformClick()
                    If save_ok = True Then
                        Temp_SCno = txtSCNo.Text
                        initFlag = True
                        setStatus("Clear")
                        initFlag = False
                    Else
                        exitFlag = False
                        Exit Sub
                    End If
                Else
                    exitFlag = False
                    MsgBox("You are not allow to save record!", MsgBoxStyle.Exclamation)
                    Exit Sub
                End If
            ElseIf YesNoCancel = MsgBoxResult.No Then
                Temp_SCno = txtSCNo.Text
                setStatus("Clear")
            ElseIf YesNoCancel = MsgBoxResult.Cancel Then
                exitFlag = False
                Exit Sub
            End If
        Else
            Temp_SCno = txtSCNo.Text
            setStatus("Clear")
        End If

        Call fillcboPriCust()
    End Sub

    Private Sub cmdSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSearch.Click
        Dim frmSYM00018 As New SYM00018

        frmSYM00018.keyName = txtSCNo.Name
        frmSYM00018.strModule = "SC"

        frmSYM00018.show_frmSYM00018(Me)
    End Sub

    Private Sub cmdInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdInsRow.Click
        recordStatus = True
        If tabFrame.SelectedIndex = tabFrame_DisPrm Then
            Dim dr() As DataRow
            If focusedObject = "grdDis" Then
                dr = rs_SCDISPRM_D.Tables("RESULT").Select("sdp_dsc = ''")
                If dr.Length = 0 Then
                    Dim newRow As DataRow = rs_SCDISPRM_D.Tables("RESULT").NewRow
                    newRow.Item("sdp_seqno") = rs_SCDISPRM_D.Tables("RESULT").Rows.Count + 1
                    newRow.Item("sdp_cde") = " "
                    newRow.Item("sdp_dsc") = " "
                    newRow.Item("sdp_pctamt") = "Percentage"
                    newRow.Item("sdp_pct") = 0
                    newRow.Item("sdp_amt") = 0
                    newRow.Item("sdp_status") = " "
                    newRow.Item("sdp_creusr") = "~*ADD*~"
                    rs_SCDISPRM_D.Tables("RESULT").Rows.Add(newRow)
                End If
            ElseIf focusedObject = "grdPre" Then
                dr = rs_SCDISPRM_P.Tables("RESULT").Select("sdp_dsc = ''")
                If dr.Length = 0 Then
                    Dim newRow As DataRow = rs_SCDISPRM_P.Tables("RESULT").NewRow
                    newRow.Item("sdp_seqno") = rs_SCDISPRM_P.Tables("RESULT").Rows.Count + 1
                    newRow.Item("sdp_cde") = " "
                    newRow.Item("sdp_dsc") = " "
                    newRow.Item("sdp_pctamt") = "Percentage"
                    newRow.Item("sdp_pct") = 0
                    newRow.Item("sdp_amt") = 0
                    newRow.Item("sdp_status") = " "
                    newRow.Item("sdp_creusr") = "~*ADD*~"
                    rs_SCDISPRM_P.Tables("RESULT").Rows.Add(newRow)
                End If
            End If
        ElseIf tabFrame.SelectedIndex = tabFrame_Detail Then
            If DtlInputisVaild() Then
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    updateDetailRS()
                ElseIf addFlag = True Then
                    hdr_CanDat = txtCancelDat.Text
                    hdr_ShpStrDat = txtStartShipDat.Text
                    hdr_ShpEndDat = txtEndShipDat.Text
                End If
                If authUsr = False And (gsFlgCst = "0" Or gsFlgCstExt = "0") And chkReplacement.Checked = True Then
                    MsgBox("You have no right to amend a Replacement SC", MsgBoxStyle.Information, "Message")
                    Exit Sub
                End If
                setDtlStatus("FIND")
                If (txtItmno.Text <> "" And cboColPckInfo.Text <> "") _
                Or chkDelDtl.Checked = True Or rs_SCORDDTL.Tables("RESULT").Rows.Count = 0 Then

                    lblApproved.Visible = False
                    If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                        currentRow = rs_SCORDDTL.Tables("RESULT").Rows.Count
                        currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(rs_SCORDDTL.Tables("RESULT").Rows.Count - 1)("sod_ordseq") + 1
                    Else
                        currentOrdSeq = currentOrdSeq + 1
                    End If
                    MaxSeq = MaxSeq + 1
                    lblDtlSeq.Text = MaxSeq
                    Dim newRow As DataRow = rs_SCORDDTL.Tables("RESULT").NewRow
                    newRow.Item("sod_ordseq") = MaxSeq
                    newRow.Item("sod_creusr") = "~*ADD*~"
                    newRow.Item("sod_updpo") = "Y"
                    newRow.Item("sod_colpck") = ""
                    newRow.Item("sod_shpstr") = txtStartShipDat.Text
                    newRow.Item("sod_shpend") = txtEndShipDat.Text
                    newRow.Item("sod_candat") = IIf(txtCancelDat.Text = "  /  /", "", txtCancelDat.Text)
                    newRow.Item("sod_shpqty") = 0
                    newRow.Item("sod_orgmoqchg") = 0
                    newRow.Item("sod_moqchg") = 0
                    newRow.Item("sod_apprve") = "N"
                    newRow.Item("sod_refdat") = Format(Date.Now, "MM/dd/yyyy")
                    newRow.Item("sod_credat") = Format(Date.Now, "MM/dd/yyyy")
                    newRow.Item("sod_upddat") = Format(Date.Now, "MM/dd/yyyy")
                    newRow.Item("sod_imqutdatchg") = "N"
                    rs_SCORDDTL.Tables("RESULT").Rows.Add(newRow)

                    If Trim(txtItmno.Text) <> "" Then
                        Find_DtlItem()
                    End If
                    recordMove("INIT")
                    Display_Dtl("ADD")
                    If txtSCVerNo.Text = "1" Then
                        chkChgFty.Enabled = False
                    Else
                        chkChgFty.Enabled = True
                    End If

                    recordStatus = True
                    recordStatus_dtl = True
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                End If
            End If
        End If
    End Sub

    Private Sub cmdDelRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDelRow.Click
        recordStatus = True
        If tabFrame.SelectedIndex = tabFrame_DisPrm Then
            If focusedObject = "grdDis" Then
                If grdDis.SelectedRows.Count > 0 Then
                    rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_status").ReadOnly = False
                    rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                    For i As Integer = 0 To grdDis.SelectedRows.Count - 1
                        If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_status").ToString = " " Then
                            If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr").ToString <> "~*ADD*~" Then
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr") = "~*DEL*~"
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_status") = "Y"
                            ElseIf rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr").ToString = "~*ADD*~" Then
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr") = "~*NEW*~"
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_status") = "Y"
                            End If
                        Else
                            If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr").ToString = "~*NEW*~" Then
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr") = "~*ADD*~"
                            Else
                                rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_creusr") = "~*UPD*~"
                            End If
                            rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_status") = " "
                        End If
                    Next
                End If
            ElseIf focusedObject = "grdPre" Then
                If grdPre.SelectedRows.Count > 0 Then
                    rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_status").ReadOnly = False
                    rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                    For i As Integer = 0 To grdDis.SelectedRows.Count - 1
                        If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_status").ToString = " " Then
                            If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr").ToString <> "~*ADD*~" Then
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr") = "~*DEL*~"
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_status") = "Y"
                            ElseIf rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr").ToString = "~*ADD*~" Then
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr") = "~*NEW*~"
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdDis.SelectedRows.Item(i).Index)("sdp_status") = "Y"
                            End If
                        Else
                            If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr").ToString = "~*NEW*~" Then
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr") = "~*ADD*~"
                            Else
                                rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_creusr") = "~*UPD*~"
                            End If
                            rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedRows.Item(i).Index)("sdp_status") = " "
                        End If
                    Next
                End If
            End If
        ElseIf tabFrame.SelectedIndex = tabFrame_Detail Then
            If chkDelDtl.Enabled = True Then
                If chkDelDtl.Checked = True Then
                    chkDelDtl.Checked = False
                Else
                    chkDelDtl.Checked = True
                End If
            End If
        ElseIf tabFrame.SelectedIndex = tabFrame_Shpmrk Then
            chkDelShp.Checked = True
        End If
    End Sub

    Private Sub cmdExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdExit.Click
        Close()
    End Sub

    Private Sub disableUnusedButtons()
        cmdFirst.Enabled = False
        cmdPrevious.Enabled = False
        cmdNext.Enabled = False
        cmdLast.Enabled = False
    End Sub

    Private Sub loadSCItemStatus()
        cboSCStatus.Items.Clear()
        cboSCStatus.Items.Add("ACT - Active")
        cboSCStatus.Items.Add("HLD - Waiting for Approval")
        cboSCStatus.Items.Add("REL - Released")
        cboSCStatus.Items.Add("CAN - Cancel")
        cboSCStatus.Items.Add("CLO - Close")
    End Sub

    Private Sub filllstDipPrm()
        If rs_SYDISPRM.Tables("RESULT").Rows.Count > 0 Then
            lstDis.Clear()
            Dim drDis() As DataRow = rs_SYDISPRM.Tables("RESULT").Select("ydp_type = 'D'")
            If drDis.Length > 0 Then
                For i As Integer = 0 To drDis.Length - 1
                    lstDis.Add(drDis(i).Item("ydp_cde") & " - " & drDis(i).Item("ydp_dsc"))
                Next
            End If

            lstPre.Clear()
            Dim drPre() As DataRow = rs_SYDISPRM.Tables("RESULT").Select("ydp_type = 'P'")
            If drPre.Length > 0 Then
                For i As Integer = 0 To drPre.Length - 1
                    lstPre.Add(drPre(i).Item("ydp_cde") & " - " & drPre(i).Item("ydp_dsc"))
                Next
            End If
        End If
    End Sub

    Private Sub fillcountry()
        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ ='02'")
        If dr.Length > 0 Then
            cboBillCountry.Items.Clear()
            cboShipCountry.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboBillCountry.Items.Add(dr(i).Item("ysi_cde") & " - " & dr(i).Item("ysi_dsc"))
                cboShipCountry.Items.Add(dr(i).Item("ysi_cde") & " - " & dr(i).Item("ysi_dsc"))
            Next
        End If

    End Sub

    Private Sub fillcboPriCust()
        Dim dr() As DataRow
        If addFlag = True Then
            dr = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno >= '50000'")
        Else
            dr = rs_CUBASINF_P.Tables("RESULT").Select("")
        End If

        If dr.Length > 0 Then
            cboPriCust.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPriCust.Items.Add(dr(i).Item("cbi_cusno") & " - " & dr(i).Item("cbi_cussna"))
            Next
        End If

    End Sub

    Private Sub fillcboPrcTrm()
        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ ='03'")
        If dr.Length > 0 Then
            cboPrcTrm.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPrcTrm.Items.Add(dr(i).Item("ysi_cde"))
            Next
            cboPrcTrm.Sorted = True
        End If
    End Sub

    Private Sub fillcboPayTrm()
        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ ='04'")
        If dr.Length > 0 Then
            cboPayTrm.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPayTrm.Items.Add(dr(i).Item("ysi_cde") & " - " & dr(i).Item("ysi_dsc"))
            Next
            cboPayTrm.Sorted = True
        End If
    End Sub

    Private Sub FillcboSubCde()
        'rs_SYSETINF.Filter = "ysi_typ ='09'"
        'If rs_SYSETINF.recordCount > 0 Then
        '    rs_SYSETINF.sort = "ysi_cde"
        '    rs_SYSETINF.MoveFirst()
        '    cboSubCde.Clear()
        '    cboSubCde.AddItem(" ")
        '    While Not rs_SYSETINF.EOF
        '        cboSubCde.AddItem(rs_SYSETINF("ysi_cde"))
        '        rs_SYSETINF.MoveNext()
        '    End While
        'End If
    End Sub

    Private Sub setStatus(ByVal Mode As String)
        If Mode = "Init" Then
            prev_tab = tabFrame_Header
            initFlag = True
            tabFrame.SelectedIndex = tabFrame_Header
            SetInputBoxesStatus("DisableAll")
            ResetDefaultDisp()
            SetStatusBar(Mode)
            tabFrame.SelectedTab = frmHdr
            MaxSeq = 0
            cmdAdd.Enabled = Enq_right_local
            cmdSave.Enabled = False
            cmdInsRow.Enabled = False
            cmdDelete.Enabled = False
            cmdDelRow.Enabled = False

            cboCoCde.Enabled = True
            txtConftr.Text = ""
            chkPC.Checked = False
            ABUASSORT("HIDE")

            cboCustUM.Enabled = False

            cmdCopy.Enabled = False
            cmdFind.Enabled = True
            cmdExit.Enabled = True
            cmdClear.Enabled = True
            cmdSearch.Enabled = True

            cmdFirst.Enabled = False
            cmdLast.Enabled = False
            cmdNext.Enabled = False
            cmdPrevious.Enabled = False
            cmdCtnSeq.Enabled = False

            '***Fill Default Date******
            txtCustPoDat.Text = Format(Now, "MM/dd/yyyy")
            cmdCustPOChg.Enabled = False
            txtCancelDat.Text = Format(Now, "MM/dd/yyyy")
            txtStartShipDat.Text = Format(Now, "MM/dd/yyyy")
            txtEndShipDat.Text = Format(Now, "MM/dd/yyyy")
            strDueDat = Format(Now, "MM/dd/yyyy")
            '**************************

            CustPODat_ori = ""
            txtCusTtlCtn.Text = ""
            txtDestination.Text = ""

            '*** Enable key field(s) in header****
            txtSCNo.Enabled = True
            txtSCNo.Text = Temp_SCno
            txtSCNo.BackColor = Color.White
            '*************************************
            txtSCVerNo.BackColor = Color.White
            txtIssDat.BackColor = Color.White
            txtRvsDat.BackColor = Color.White
            'optMain.Checked = True
            optMain.Checked = False
            optSide.Checked = False
            optInner.Checked = False
            prevShpMrkTyp = Nothing

            lblDisInfo.ForeColor = Color.Black
            lblPreInfo.ForeColor = Color.Black

            lblDVItmCstCur.Text = ""
            txtDVItmCst.Text = "0"
            'lblDVBOMCstCur.Text = ""
            txtDVBOMCst.Text = "0"
            'lblDVTtlCstCur.Text = ""
            txtDVTtlCst.Text = "0"
            lblDVFtyUnt.Text = ""

            txtMOQUnttyp.Enabled = False
            txtMOQUnttyp.Text = ""


            strCurExRat = "0"
            strCurExEffDat = ""
            cmdOrgScCst.Enabled = False
            imu_key.Text = ""

            If formError = True Then
                cmdAdd.Enabled = False
                cmdSave.Enabled = False
                cmdCopy.Enabled = False
                cmdInsRow.Enabled = False
                cmdDelete.Enabled = False
                cmdDelRow.Enabled = False
                cmdFind.Enabled = False
                cmdExit.Enabled = True
                cmdClear.Enabled = False
                cmdSearch.Enabled = False
                cmdFirst.Enabled = False
                cmdLast.Enabled = False
                cmdNext.Enabled = False
                cmdPrevious.Enabled = False
                txtSCNo.Enabled = False
            End If

            currentRow = 0
            currentOrdSeq = 1

            '********Reset Flag***********
            addFlag = False
            recordStatus = False
            initFlag = False
            rplSeqFlag = False

            Reset_PO()

            grpHeader.Enabled = True
            grpDisPrm.Enabled = True
            grpDetail.Enabled = True
            grpShpmrk.Enabled = True
            grpSummary.Enabled = True
            grpUpdatePO.Enabled = True

            cmdShpmrkAttchmnt.Enabled = False

            clearPanHdrRmk()
            panHdrSCRmk.Visible = False
            panMatBrkdwn.Visible = False
            panDtlShpDat.Visible = False
            panSumPODates.Visible = False

            cboPriCust.Text = ""
            SetComboStatus(cboPriCust, "Disable")
            cboSecCust.Text = ""
            SetComboStatus(cboSecCust, "Disable")

            dgSummary.DataSource = Nothing
            dgAssort.DataSource = Nothing
            dgSCShpDat.DataSource = Nothing

            '***********************************************************************************************
            '***************************************ADD RECORD**********************************************
            '***********************************************************************************************
        ElseIf Mode = "ADD" Then
            SetInputBoxesStatus("EnableAll")
            disableUnusedButtons()
            SetStatusBar(Mode)
            reUpdateFlag = False
            cmdDelete.Enabled = False
            cmdInsRow.Enabled = True
            cmdDelRow.Enabled = True
            cmdAdd.Enabled = False
            cmdFind.Enabled = False
            cmdSearch.Enabled = False
            cmdCopy.Enabled = False
            txtSCVerNo.Text = 1
            txtSCVerNo.Enabled = False
            txtSCVerNo.BackColor = Color.White

            cboCoCde.Enabled = False
            txtCoNam.Enabled = False

            txtIssDat.Enabled = False
            txtIssDat.BackColor = Color.White

            txtRvsDat.Enabled = False
            txtRvsDat.BackColor = Color.White

            'If gsUsRank <= 4 Or gsUsrGrp = "MGT-S" Then 'Marco at 20040521
            If (gsUsrRank <= 4 And Enq_right_local) Or gsUsrGrp = "MGT-S" Then
                authUsr = True
            Else
                authUsr = False
            End If

            txtSalDivTem.Enabled = False

            'txtImgPth.Enabled = False
            txtTotalCube.Enabled = False
            txtTotalCFT.Enabled = False
            txtTotalCtn.Enabled = False
            txtAmt.Enabled = False
            txtNetAmt.Enabled = False
            cboSCStatus.Enabled = False

            If gsFlgCst = "1" And gsFlgCstExt = "1" And authUsr = True Then
                chkReplacement.Enabled = True
            Else
                chkReplacement.Enabled = False
            End If

            chkCloseOut.Enabled = True
            If authUsr = True Then
                chkApprove.Enabled = True
            Else
                chkApprove.Enabled = False
            End If
            chkCancel.Enabled = False
            chkhdrpo.Enabled = False
            chkhdrpo.Checked = True
            '******************LOCK THE KEY FIELD****************
            txtSCNo.Text = ""
            txtSCNo.Enabled = False
            '****************************************************
            '******************Folder 1****************
            SetComboStatus(cboPriCust, "Enable")
            SetComboStatus(cboSecCust, "Disable")

            txtBillAdd.Enabled = False
            txtBillSP.Enabled = False
            txtBillZIP.Enabled = False
            cboBillCountry.Enabled = False
            txtTotalCube.Enabled = False
            txtTotalCFT.Enabled = False
            txtTotalCtn.Enabled = False
            txtAmt.Enabled = False
            txtNetAmt.Enabled = False
            txtShipAdd.Enabled = False
            txtShipSP.Enabled = False
            txtShipZIP.Enabled = False
            txtJobNo.Enabled = False
            txtRunNo.Enabled = False
            cboShipCountry.Enabled = False
            If gsUsrRank <= 6 And Enq_right_local Then
                cboPrcTrm.Enabled = True
                cboPayTrm.Enabled = True
            Else
                cboPrcTrm.Enabled = False
                cboPayTrm.Enabled = False
            End If

            cmdCtnSeq.Enabled = True

            'Added by Mark Lau 20070622
            ABUASSORT("HIDE")

            ' Added by Mark Lau 20080611
            cboCustUM.Enabled = False

            ' Added by Mark Lau 20080620
            txtEmail.Enabled = False

            ' Added by Mark Lau 2009026
            strCurExRat = "0"
            strCurExEffDat = ""

            cmdItmCstEn.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
            txtTtlCst.Enabled = False
            txtDVItmCst.Enabled = False
            txtDVBOMCst.Enabled = False
            txtDVTtlCst.Enabled = False

            ' Added by Mark Lau 20081107
            'lblDVTtlCstCur.Text = ""
            txtDVTtlCst.Text = "0"
            lblDVFtyUnt.Text = ""
            lblDVItmCstCur.Text = ""
            'lblDVBOMCstCur.Text = ""
            txtDVItmCst.Text = "0"
            txtDVBOMCst.Text = "0"
            lblDVName.Text = ""

            ' Added by Mark Lau 20090205
            txtMOQUnttyp.Enabled = False
            txtMOQUnttyp.Text = ""

            txtCustPoDat.Enabled = True
            cmdCustPOChg.Enabled = False
            txtStartShipDat.Enabled = True
            txtEndShipDat.Enabled = True
            txtCancelDat.Enabled = True

            '***Fill Default Date******
            txtIssDat.Text = Format(Date.Now, "MM/dd/yyyy")
            txtRvsDat.Text = Format(Date.Now, "MM/dd/yyyy")
            txtCustPoDat.Text = "  /  /"
            'txtCancelDat.Text = Format(Date.Now, "MM/dd/yyyy")
            'txtStartShipDat.Text = Format(Date.Now, "MM/dd/yyyy")
            'txtEndShipDat.Text = Format(Date.Now, "MM/dd/yyyy")
            txtCancelDat.Text = "  /  /"
            txtStartShipDat.Text = "  /  /"
            txtEndShipDat.Text = "  /  /"
            strDueDat = Format(Date.Now, "MM/dd/yyyy")
            '**************************

            txtCusTtlCtn.Text = ""
            txtDestination.Text = ""

            If txtSCVerNo.Text = "1" Then
                lblDtlPORmk.Text = "Additional" & Environment.NewLine & "PO Remark"
                cmdDtlPORmk.Location = New Point(cmdDtlPORmk.Location.X, 440)
            Else
                lblDtlPORmk.Text = "PO Remark"
                cmdDtlPORmk.Location = New Point(cmdDtlPORmk.Location.X, 427)
            End If

            If copyFlag = False Then

                currentRow = 0
                currentOrdSeq = 0

                gspStr = "sp_select_SCDISPRM '','',''"
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, rs_SCDISPRM_D, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #047 sp_select_SCDISPRM : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCDISPRM_D.Tables("RESULT").Columns.Count - 1
                        rs_SCDISPRM_D.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCDISPRM_D_ori = rs_SCDISPRM_D.Copy()
                    'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_cde").ReadOnly = False
                    'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_dsc").ReadOnly = False
                    'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_pctamt").ReadOnly = False
                    'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_pct").ReadOnly = False
                    'rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
                End If
                gspStr = "sp_select_SCDISPRM '','',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCDISPRM_P, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #048 sp_select_SCDISPRM : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCDISPRM_P.Tables("RESULT").Columns.Count - 1
                        rs_SCDISPRM_P.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCDISPRM_P_ori = rs_SCDISPRM_P.Copy()
                    'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_cde").ReadOnly = False
                    'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_dsc").ReadOnly = False
                    'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_pctamt").ReadOnly = False
                    'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_pct").ReadOnly = False
                    'rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
                End If

                gspStr = "sp_select_SCORDDTL '',''"
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, rs_SCORDDTL, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #049 sp_select_SCORDDTL : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
                        rs_SCORDDTL.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCORDDTL_ori = Nothing
                    rs_SCORDDTL_ori = rs_SCORDDTL.Copy()
                End If

                gspStr = "sp_select_SCCPTBKD '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCCPTBKD, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #111 sp_select_SCCPTBKD : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCCPTBKD.Tables("RESULT").Columns.Count - 1
                        rs_SCCPTBKD.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCCPTBKD_ori = Nothing
                    rs_SCCPTBKD_ori = rs_SCCPTBKD.Copy()
                End If
                gspStr = "sp_select_SCSHPMRK '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCSHPMRK, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #050 sp_select_SCSHPMRK : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCSHPMRK.Tables("RESULT").Columns.Count - 1
                        rs_SCSHPMRK.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                End If
                gspStr = "sp_select_SCASSINF '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCASSINF, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #051 sp_select_SCASSINF : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCASSINF.Tables("RESULT").Columns.Count - 1
                        rs_SCASSINF.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCASSINF_ori = Nothing
                    rs_SCASSINF_ori = rs_SCASSINF.Copy()
                End If
                'gspStr = "sp_select_SCDTLCTN '',''"
                'rtnLong = execute_SQLStatement(gspStr, rs_SCDTLCTN, rtnStr)
                'If rtnLong <> RC_SUCCESS Then
                '    Me.Cursor = Windows.Forms.Cursors.Default
                '    MsgBox("Error on loading SCM00001 #052 sp_select_SCDTLCTN : " & rtnStr)
                '    Exit Sub
                'End If
                gspStr = "sp_select_SCDTLSHP '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCDTLSHP, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #053 sp_select_SCDTLSHP : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCDTLSHP.Tables("RESULT").Columns.Count - 1
                        rs_SCDTLSHP.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCDTLSHP_ori = Nothing
                    rs_SCDTLSHP_ori = rs_SCDTLSHP.Copy()
                End If
                gspStr = "sp_select_SCBOMINF '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCBOMINF, rtnStr)
                Me.Cursor = Windows.Forms.Cursors.Default
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #054 sp_select_SCBOMINF : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCBOMINF.Tables("RESULT").Columns.Count - 1
                        rs_SCBOMINF.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                    rs_SCBOMINF_OLD = Nothing
                    rs_SCBOMINF_OLD = rs_SCBOMINF.Copy()
                End If

                grdDis.DataSource = rs_SCDISPRM_D.Tables("RESULT").DefaultView
                Display_Dis()
                grdPre.DataSource = rs_SCDISPRM_P.Tables("RESULT").DefaultView
                Display_pre()
                MaxSeq = 0
                setDtlStatus("INIT")
                display_combo("ACT", cboSCStatus)
                'Add your codes here
            Else
                '*** query item master header
                'Fixing global company code problem at 20100420
                gsCompany = Trim(cboCoCde.Text)
                Update_gs_Value(gsCompany)

                gspStr = "sp_select_SCASSINF '',''"
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, rs_SCASSINF_ori, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("Error on loading SCM00001 #055 sp_select_SCASSINF : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCASSINF.Tables("RESULT").Columns.Count - 1
                        rs_SCASSINF.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                End If

                gspStr = "sp_select_SCBOMINF '',''"
                rtnLong = execute_SQLStatement(gspStr, rs_SCBOMINF_OLD, rtnStr)

                Me.Cursor = Windows.Forms.Cursors.Default
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #056 sp_select_SCBOMINF : " & rtnStr)
                    Exit Sub
                Else
                    For i As Integer = 0 To rs_SCBOMINF.Tables("RESULT").Columns.Count - 1
                        rs_SCBOMINF.Tables("RESULT").Columns(i).ReadOnly = False
                    Next
                End If
            End If

            cmdShpmrkAttchmnt.Enabled = False
            grpUpdatePO.Enabled = False

        ElseIf Mode = "Updating" Then
            SetInputBoxesStatus("EnableAll")
            disableUnusedButtons()

            ' Added by Mark Lau 20080611
            LoadCustUM()
            ' Added by Mark Lau 20080620
            txtEmail.Enabled = True
            '

            cmdAdd.Enabled = False
            cmdSave.Enabled = Enq_right_local
            cmdCopy.Enabled = Enq_right_local
            cmdInsRow.Enabled = Enq_right_local
            cmdDelRow.Enabled = Enq_right_local
            'cmdDelete.Enabled = Del_right_local
            cmdDelete.Enabled = False

            If gsUsrGrp = "CED-S" Or gsUsrGrp = "SAL-ZS" Then
                cmdItmCstEn.Enabled = True
            Else
                cmdItmCstEn.Enabled = False
            End If


            cmdFind.Enabled = False
            cmdSearch.Enabled = False
            cmdExit.Enabled = True
            cmdClear.Enabled = True

            '****Header********
            cboCoCde.Enabled = False
            txtCoNam.Enabled = False
            txtSCVerNo.Enabled = False
            txtSCVerNo.BackColor = Color.White
            txtIssDat.Enabled = False
            txtIssDat.BackColor = Color.White
            txtRvsDat.Enabled = False
            txtRvsDat.BackColor = Color.White
            cboSCStatus.Enabled = False
            chkReplacement.Enabled = False
            chkCloseOut.Enabled = False
            reUpdateFlag = False
            txtJobNo.Enabled = False
            txtRunNo.Enabled = False
            'If rs_SCORDHDR("soh_verno").Value <> "1" And Authusr = True And rs_SCORDHDR("shipped").Value = 0 Then
            'Allan Yuen Enhance Cancel Function at 12 June 2003
            If authUsr = True And rs_SCORDHDR.Tables("RESULT").Rows(0)("shipped") = 0 Then
                chkCancel.Enabled = True
            Else
                chkCancel.Enabled = False
            End If

            If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_verno").ToString <> "1" Then
                chkhdrpo.Enabled = True
            Else
                chkhdrpo.Enabled = False
                chkhdrpo.Checked = True
            End If
            '******************
            '******************LOCK THE KEY FIELD****************
            txtSCNo.Enabled = False
            txtSCNo.BackColor = Color.White
            '****************************************************
            '******************Folder 1****************
            'cboPriCust.DropDownStyle = ComboBoxStyle.DropDownList
            'cboPriCust.Enabled = False
            SetComboStatus(cboPriCust, "Disable")
            'cboSecCust.DropDownStyle = ComboBoxStyle.DropDownList
            'cboSecCust.Enabled = False
            SetComboStatus(cboSecCust, "Disable")
            If txtSCVerNo.Text = "1" And (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") Then
                'txtCustPoDat.Enabled = True
                txtCustPoDat.Enabled = False
                cmdCustPOChg.Enabled = True
            Else
                txtCustPoDat.Enabled = False
                cmdCustPOChg.Enabled = False
            End If
            txtBillAdd.Enabled = False
            txtBillSP.Enabled = False
            txtBillZIP.Enabled = False
            cboBillCountry.Enabled = False
            txtTotalCube.Enabled = False
            txtTotalCFT.Enabled = False
            txtTotalCtn.Enabled = False
            txtAmt.Enabled = False
            txtNetAmt.Enabled = False
            txtShipAdd.Enabled = False
            txtShipSP.Enabled = False
            txtShipZIP.Enabled = False
            cboShipCountry.Enabled = False
            txtSalDivTem.Enabled = False
            If gsUsrRank <= 6 And Enq_right_local Then
                cboPrcTrm.Enabled = True
                cboPayTrm.Enabled = True
            Else
                cboPrcTrm.Enabled = False
                cboPayTrm.Enabled = False
            End If
            If rs_CUBASINF_Agent.Tables("RESULT").Rows.Count > 0 Then
                cboAgent.Enabled = True
            Else
                cboAgent.Enabled = False
            End If
            cmdCtnSeq.Enabled = True
            '******************************************
            '***********folder 5***********************
            'txtImgPth.Enabled = False
            '******************************************
            '*********Display the Defalult Ship Mark as Main *****************
            DisplayShpMrk("OPTION")
            SetStatusBar(Mode)
            '*****************************************************************
            '***********Folder 4************************
            If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                recordMove("LOAD")
                MaxSeq = rs_SCORDDTL.Tables("RESULT").Rows(0)("max_seq")
            Else
                setDtlStatus("INIT")
            End If

            '*******************************************

            '*********Check SC Status***************************
            If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts") <> "ACT" And rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts") <> "HLD" Then
                SetInputBoxesStatus("DisableAll")
                'SSTab1.Enabled = True
                dgSummary.Enabled = True
                cmdExit.Enabled = True
                cmdClear.Enabled = True

                '                cmdCopy.Enabled = True
                cmdCopy.Enabled = Enq_right_local

                chkApprove.Enabled = False
                optMain.Enabled = True
                optSide.Enabled = True
                optInner.Enabled = True
                txtEngDsc.Enabled = True
                txtChiDsc.Enabled = True
                txtEngRmk.Enabled = True
                txtChiRmk.Enabled = True
                txtEngDsc.ReadOnly = True
                txtChiDsc.ReadOnly = True
                txtEngRmk.ReadOnly = True
                txtChiRmk.ReadOnly = True
                txtRemark.Enabled = True
                txtRemark.ReadOnly = True
                recordMove("LOAD")
                'Added by Mark Lau 20070623
                chkPC.Enabled = False
                'Added by Mark Lau 20080623
                txtEmail.Enabled = True
                txtEmail.ReadOnly = True

                'Enable Tab Control
                tabFrame.Enabled = True
                frmHdr.Enabled = True
                frmDisPre.Enabled = True
                frmDtl.Enabled = True
                frmShpDoc.Enabled = True
                frmSum.Enabled = True

            Else
                '***************************************************
                If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_smpsc") = "Y" Then
                    If gsUsrRank <= 2 Or gsUsrGrp = "MGT-S" Then
                        authUsr = True
                    Else
                        authUsr = False
                    End If
                End If
                If authUsr = True And gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    chkApprove.Enabled = True
                Else
                    chkApprove.Enabled = False
                End If
            End If

            ' Added by Mark Lau 20090205
            txtMOQUnttyp.Enabled = False

            recordStatus = False
            'Add your codes here
            'prevShpMrkTyp = "M"

            'Check if there are any assoicated PO related for update
            cmdShpmrkAttchmnt.Enabled = True

        ElseIf Mode = "Save" Then
            SetStatusBar(Mode)
            setStatus("Init")
            MsgBox("Record Saved!")
            If txtSCNo.Enabled And txtSCNo.Visible Then txtSCNo.Focus()
        ElseIf Mode = "Delete" Then
            Call SetStatusBar(Mode)

            'Add your codes here
        ElseIf Mode = "Clear" Then
            ResetDefaultDisp()
            SetStatusBar(Mode)
            setStatus("Init")
            If txtSCNo.Enabled And txtSCNo.Visible Then txtSCNo.Focus()
            dgSummary.Refresh()
            cboPriCust.Items.Clear()
            cboSecCust.Items.Clear()
            cboContactPerson.Items.Clear()
            cboBillAdd.Items.Clear()
            cboShipAdd.Items.Clear()
            cboSalesRep.Items.Clear()
            txtSalDivTem.Text = ""
            cboSCStatus.SelectedIndex = -1
            'cboContactPerson.SelectedIndex = -1
            cboBillCountry.SelectedIndex = -1
            cboShipCountry.SelectedIndex = -1
            'cboSalesRep.SelectedIndex = -1
            cboPrcTrm.SelectedIndex = -1
            cboPayTrm.SelectedIndex = -1
        End If
    End Sub

    Private Sub ResetDefaultDisp()
        hdr_CanDat = ""
        hdr_ShpStrDat = ""
        hdr_ShpEndDat = ""
        hdr_CustPODat = ""
        beforeStatus = ""
        Total_D_Amt = 0
        Total_D_Per = 0
        Total_P_Amt = 0
        Total_P_Per = 0
        beforeNetAmt = 0
        lblApproved.Visible = False
        sort_seq = ""
        txtRemark.ReadOnly = False
        detailError = False
        copyFlag = False


        '*** Header Page ***
        chkhdrpo.Enabled = False
        chkhdrpo.Checked = False
        cboShipAdd.Items.Clear()
        cboBillAdd.Items.Clear()
        Pricustno = ""
        Seccustno = ""

        'Me.chkSample.value = 0

        chkCancel.Checked = False
        chkApprove.Checked = False

        txtSCVerNo.Text = ""
        cboSCStatus.Text = ""
        txtIssDat.Text = ""
        txtRvsDat.Text = ""

        cboPriCust.Text = ""
        cboSecCust.Text = ""
        txtBillAdd.Text = ""
        txtBillSP.Text = ""
        cboBillCountry.Text = ""
        txtBillZIP.Text = ""

        txtShipAdd.Text = ""
        txtShipSP.Text = ""
        cboShipCountry.Text = ""
        txtShipZIP.Text = ""
        cboContactPerson.Text = ""
        txtRemark.Text = ""

        cboAgent.Text = ""
        cboSalesRep.Text = ""
        txtCustPO.Text = ""

        txtMOQSC.Text = "" 'Lester Wu 2007-10-07

        txtRespPO.Text = ""

        ' Added by Mark Lau 20080620
        txtEmail.Text = ""
        txtEmail.ReadOnly = False

        cboPrcTrm.Text = ""
        cboPayTrm.Text = ""
        txtTotalCube.Text = ""
        txtTotalCFT.Text = ""

        lblDtlSeq.Text = "0"
        ' Remark by Allan Yuen
        lblTtlAmtCur.Text = ""
        lblNetAmtCur.Text = ""

        txtAmt.Text = ""
        txtNetAmt.Text = ""
        txtTotalCtn.Text = ""
        'Me.cboSFreightTrm.Text = ""
        'Me.cboSProdTrm.Text = ""

        txtItmno.Text = ""
        cboColPckInfo.Items.Clear()
        chkReplacement.Checked = False
        chkCloseOut.Checked = False

        '*** Details Page ***
        txtItmStatus.Text = ""
        txtItmno.Enabled = False
        txtPJobNo.Enabled = False
        txtItmno.Text = ""
        txtItmDsc.Text = ""
        cboColPckInfo.Enabled = False
        cboColPckInfo.SelectedIndex = -1
        cboColPckInfo.SelectedIndex = -1
        txtCustColCde.Text = ""
        txtColDsc.Text = ""
        txtRefDoc.Text = ""
        txtRefdat.Text = Format(Date.Now, "MM/dd/yyyy")
        txtCustItmno.Text = ""
        txtSKUNo.Text = ""
        cboSeason.Text = ""
        txtCustPODtl.Text = ""
        txtRespPODtl.Text = ""
        txtOrdQty.Text = ""
        txtPC.Text = "" 'Lester Wu 2007-07-03
        txtShipped.Text = ""
        txtUM.Text = ""
        txtDiscount.Text = ""
        txtMOQChg.Text = ""
        txtPckItr.Text = ""
        txtDept.Text = ""
        txtJobNo.Text = ""
        txtRunNo.Text = ""
        txtPJobNo.Text = ""
        txtSecCusItm.Text = ""
        strCusSub = ""
        txtTentOrdno.Text = ""
        txtTentOrdSeq.Text = ""

        txtMOQ.Text = ""
        txtMOQUnttyp.Text = ""
        txtMOA.Text = ""

        lblBasprcCur.Text = ""
        txtItmPrc.Text = ""
        lblPCPrcCur.Text = ""
        lblSelprcCur.Text = ""
        txtUntPrc.Text = ""
        lblSubttlCur.Text = ""
        txtSelprc.Text = ""
        lblNetprcCur.Text = ""
        txtNetUntPrc.Text = ""
        txtPeriod.Text = ""


        cboHSTU.Text = ""
        txtDuty.Text = ""

        optUPC.Checked = True

        txtCdeMer.Text = ""
        txtCdeInr.Text = ""
        txtCdeCtn.Text = ""

        cboRetailUSDCur.Items.Clear()
        txtRetailUSD.Text = ""
        cboRetailCADCur.Items.Clear()
        txtRetailCAD.Text = ""
        fillcboRetailCur()

        txtInnerLin = 0
        txtInnerWin = 0
        txtInnerHin = 0
        txtMasterLin = 0
        txtMasterWin = 0
        txtMasterHin = 0
        txtInnerLcm = 0
        txtInnerWcm = 0
        txtInnerHcm = 0
        txtMasterLcm = 0
        txtMasterWcm = 0
        txtMasterHcm = 0

        cboPrdVen.Items.Clear()
        cboCusVen.Items.Clear()
        chkDelDtl.Enabled = False
        chkDelDtl.Checked = False
        txtStartShip.Text = Format(Date.Now, "MM/dd/yyyy")
        txtEndShip.Text = Format(Date.Now, "MM/dd/yyyy")
        txtCanDat.Text = Format(Date.Now, "MM/dd/yyyy")
        txtPOStartShip.Text = "  /  /"
        txtPOEndShip.Text = "  /  /"
        txtPOCanDat.Text = "  /  /"
        chkUpdatePO.Checked = True
        chkChgFty.Checked = False

        txtStartCarton.Text = ""
        txtEndCarton.Text = ""
        lblVenItm.Text = ""
        lblItmCstCur.Text = ""
        'lblBOMCstCur.Text = ""
        'lblTtlCstCur.Text = ""
        lblFtyUnt.Text = ""
        txtTtlCst.Text = 0
        txtItmCst.Text = 0
        txtBOMCst.Text = 0
        lblTotalCtn.Text = ""
        txtDtlSCRmk.Text = ""
        txtDtlPORmk.Text = ""
        txtIMPeriod.Text = ""
        txtCIHPrd.Text = ""

        txtOldItem.Text = ""
        txtOldColor.Text = ""

        'Marco added 20070518
        txtZTNVBELN.Text = ""
        txtZTNPOSNR.Text = ""

        txtZORVBELN.Text = ""
        txtZORPOSNR.Text = ""

        txtZORVBELN.Enabled = True
        txtZORVBELN.ReadOnly = True
        txtZORPOSNR.Enabled = True
        txtZORPOSNR.ReadOnly = True

        imu_key.Text = ""

        cboSeason.Text = ""
        txtEffDat.Text = ""
        txtExpDat.Text = ""
        txtPrcGrp.Text = ""

        txtDtlPORmk.Text = ""

        '***********Folder 5 ***********************
        chkDelShp.Checked = False
        txtEngDsc.ReadOnly = False
        txtChiDsc.ReadOnly = False
        txtEngRmk.ReadOnly = False
        txtChiRmk.ReadOnly = False

        Reset_ShipMark()

        recordStatus_dtl = False

        formError = False
        addFlag = False
        exitFlag = False
        historyFlag = False
        save_ok = False
        isUpdated = False
        overlimit = False
        dispSMFlag = False
        poChange = False
        advOrd = False
        custInactive = False

        rs_SCORDHDR = Nothing
        rs_SCCNTINF = Nothing
        rs_SCDISPRM_D = Nothing
        rs_SCDISPRM_P = Nothing
        rs_SCORDDTL = Nothing
        rs_SCSHPMRK = Nothing
        rs_SCORDDTL_Summary = Nothing

        rs_POORDHDR = Nothing
        rs_POORDHDR_ori = Nothing
        rs_POSHPMRK = Nothing
        rs_POSHPMRK_ori = Nothing

        lblLeft.Text = ""
        lblRight.Text = ""

        If (gsUsrRank <= 4 And Enq_right_local) Or gsUsrGrp = "MGT-S" Then
            authUsr = True
        Else
            authUsr = False
        End If

        Reset_ShipMark()
    End Sub

    Private Sub SetInputBoxesStatus(ByVal Mode As String)
        Dim v As Object

        '*** (1) If Mode = "EnableAll", enable all controls
        If Mode = "EnableAll" Then
            cboPriCust.DropDownStyle = ComboBoxStyle.DropDown
            cboSecCust.DropDownStyle = ComboBoxStyle.DropDown
            cboContactPerson.DropDownStyle = ComboBoxStyle.DropDown
            cboSalesRep.DropDownStyle = ComboBoxStyle.DropDown
            cboPrcTrm.DropDownStyle = ComboBoxStyle.DropDown
            cboPayTrm.DropDownStyle = ComboBoxStyle.DropDown
            cboHSTU.DropDownStyle = ComboBoxStyle.DropDown

            For Each v In Me.Controls
                If IsInputBoxes(v) Then
                    v.Enabled = True
                End If
            Next

            '*** (2) If Mode = "DisableAll", disable all controls
        ElseIf Mode = "DisableAll" Then
            cboPriCust.DropDownStyle = ComboBoxStyle.DropDownList
            cboSecCust.DropDownStyle = ComboBoxStyle.DropDownList
            cboContactPerson.DropDownStyle = ComboBoxStyle.DropDownList
            cboSalesRep.DropDownStyle = ComboBoxStyle.DropDownList
            cboPrcTrm.DropDownStyle = ComboBoxStyle.DropDownList
            cboPayTrm.DropDownStyle = ComboBoxStyle.DropDownList
            cboHSTU.DropDownStyle = ComboBoxStyle.DropDownList

            For Each v In Me.Controls
                If IsInputBoxes(v) Then
                    v.Enabled = False
                End If
            Next
        End If
    End Sub

    Public Function IsInputBoxes(ByVal v As Object) As Boolean
        If (TypeOf v Is TextBox) Or (TypeOf v Is CheckBox) Or _
           (TypeOf v Is ComboBox) Or (TypeOf v Is Button) Or _
           (TypeOf v Is ListBox) Or (TypeOf v Is RadioButton) Or _
           (TypeOf v Is DataGrid) Or (TypeOf v Is TabControl) Or (TypeOf v Is DateTimePicker) Or _
           (TypeOf v Is MaskedTextBox) Then
            IsInputBoxes = True
        Else
            IsInputBoxes = False
        End If
    End Function

    Private Sub SetComboStatus(ByVal combo As ComboBox, ByVal mode As String)
        If mode = "Enable" Then
            combo.Enabled = True
            combo.DropDownStyle = ComboBoxStyle.DropDown
        Else
            combo.DropDownStyle = ComboBoxStyle.DropDownList
            combo.Enabled = False
        End If
    End Sub

    Private Sub SetStatusBar(ByVal Mode As String)
        If Mode = "Init" Then
            lblLeft.Text = "Please Enter a SC No."
        ElseIf Mode = "ADD" Then
            lblLeft.Text = "ADD"
        ElseIf Mode = "Updating" Then
            lblLeft.Text = "Updating"
        ElseIf Mode = "Save" Then
            lblLeft.Text = "Record Saved"
        ElseIf Mode = "Delete" Then
            lblLeft.Text = "Record Deleted"
        ElseIf Mode = "ReadOnly" Then
            lblLeft.Text = "Read Only"
        ElseIf Mode = "Clear" Then
            lblLeft.Text = "Clear Screen"
        End If
    End Sub

    Private Sub Reset_ShipMark()
        cboShipMark.SelectedIndex = -1
        '' picShipMark.Image = Nothing
        'txtImgPth.Text = ""
        txtEngDsc.Text = ""
        txtChiDsc.Text = ""
        txtEngRmk.Text = ""
        txtChiRmk.Text = ""
    End Sub

    Private Sub ABUASSORT(ByVal Action As String)
        txtConftr.Enabled = False

        Select Case Action
            Case "SHOW"
                txtConftr.Visible = True
                chkPC.Visible = True
                cboColPckInfo.Width = 313

                If chkPC.Checked = True Then
                    If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                        txtPCPrc.Visible = False
                        lblPCPrc.Visible = False
                        lblPCPrcCur.Visible = False
                    Else
                        txtPCPrc.Visible = True
                        lblPCPrc.Visible = True
                        lblPCPrcCur.Visible = True
                    End If
                    txtUntPrc.ReadOnly = True
                    lblPeriod.Visible = False 'Frankie 20101018
                    txtOrdQty.ReadOnly = True
                    txtPC.Visible = True
                    lblPC.Visible = True
                Else
                    txtUntPrc.ReadOnly = False
                    txtPCPrc.Visible = False
                    lblPCPrc.Visible = False
                    lblPCPrcCur.Visible = False
                    lblPeriod.Visible = True 'Frankie 20101018
                    txtOrdQty.ReadOnly = False
                    txtPC.Visible = False
                    lblPC.Visible = False
                End If
            Case "HIDE"
                txtConftr.Visible = False
                chkPC.Visible = False
                cboColPckInfo.Width = 381
                chkPC.Enabled = False
                txtUntPrc.ReadOnly = False
                txtPCPrc.Visible = False
                lblPCPrc.Visible = False
                lblPCPrcCur.Visible = False
                lblPeriod.Visible = True 'Frankie 20101018
                txtOrdQty.ReadOnly = False
                txtPC.Visible = False
                lblPC.Visible = False
        End Select
    End Sub

    Private Sub cboCoCde_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboCoCde.SelectedIndexChanged
        txtCoNam.Text = ChangeCompany(cboCoCde.Text, Me.Name)
        getDefault_Path()

        Enq_right_local = Enq_right
        Del_right_local = Del_right

        'gspStr = "sp_select_CUBASINF_PC '" & cboCoCde.Text & "','" & LCase(gsUsrID) & "','" & strModule & "','Primary'"

        'Me.Cursor = Windows.Forms.Cursors.WaitCursor

        'rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_PC, rtnStr)

        'Me.Cursor = Windows.Forms.Cursors.Default
        'If rtnLong <> RC_SUCCESS Then
        '    MsgBox("Error on loading SCM00001 #005 sp_select_CUBASINF_PC : " & rtnStr)
        '    Exit Sub
        'End If

        gsCompany = Trim(cboCoCde.Text)
        Update_gs_Value(gsCompany)

        gspStr = "sp_list_SYSETINF"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_SYSETINF, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #006 sp_list_SYSETINF : " & rtnStr)
            Exit Sub
        End If

        gspStr = "sp_select_CUBASINF_P '" & cboCoCde.Text & "','Primary'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_P, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #007 sp_select_CUBASINF_P : " & rtnStr)
            Exit Sub
        End If

        gspStr = "sp_select_CUBASINF_P '" & cboCoCde.Text & "','Sales Rep'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_SalRep, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #008 sp_select_CUBASINF_P : " & rtnStr)
            Exit Sub
        End If

        gspStr = "sp_select_SYDISPRM_ALL"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_SYDISPRM, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #009 sp_select_SYDISPRM_ALL : " & rtnStr)
            Exit Sub
        End If

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        If rs_SYSETINF.Tables("RESULT").Rows.Count = 0 Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("No Record Found in SYSETINF", MsgBoxStyle.Critical, "SCM00001 LOADING ERROR")
            formError = True
            setStatus("Init")
            Exit Sub
        Else
            formError = False
            filllstDipPrm()
            fillcountry()
            fillcboPriCust()
            fillcboPrcTrm()
            fillcboPayTrm()
            FillcboSubCde()
            fillcboSeason()
            fillcboRetailCur()
        End If
        Me.Cursor = Windows.Forms.Cursors.Default
    End Sub

    Private Sub enableComboBox(ByVal enable As Boolean, ByVal cbo As ComboBox)
        If enable = True Then
            cbo.DropDownStyle = ComboBoxStyle.DropDown
            cbo.Enabled = True
        Else
            cbo.DropDownStyle = ComboBoxStyle.DropDownList
            cbo.Enabled = False
        End If
    End Sub

    Private Sub display()
        txtSCNo.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordno")
        txtSCVerNo.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_verno")
        txtIssDat.Text = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_issdat")), "MM/dd/yyyy")
        txtRvsDat.Text = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_rvsdat")), "MM/dd/yyyy")

        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts").ToString, cboSCStatus)

        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_clsout") = "Y" Then
            chkCloseOut.Checked = True
        Else
            chkCloseOut.Checked = False
        End If

        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_canflg") = "Y" Then
            chkCancel.Checked = True
        Else
            chkCancel.Checked = False
        End If

        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_rplmnt") = "Y" Then
            chkReplacement.Checked = True
        Else
            chkReplacement.Checked = False
        End If

        '***************Folder 1******************************************

        '**********Handling Customer is Deleted or InAvtive'***********************
        Dim tmp As String
        If cboPriCust.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus1no").ToString) = -1 Then
            cboPriCust.Items.Add(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus1no").ToString)
            tmp = Split(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus1no").ToString, " - ")(0)
            display_combo(tmp, cboPriCust)
            cboPriCust.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus1no").ToString
            Cust_InActive = True
        Else
            cboPriCust.SelectedIndex = cboPriCust.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus1no").ToString)
        End If

        If cboSecCust.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString) = -1 And _
           Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString) <> "" Then
            cboSecCust.Items.Add(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString)
            tmp = Split(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString, " - ")(0)
            display_combo(tmp, cboSecCust)
            cboSecCust.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString
            Cust_InActive = True
        Else
            cboSecCust.SelectedIndex = cboSecCust.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cus2no").ToString)
        End If
        '***************************************************************************
        CreditUse = rs_SCORDHDR.Tables("RESULT").Rows(0)("cpi_rskuse")
        CreditAmt = rs_SCORDHDR.Tables("RESULT").Rows(0)("cpi_rsklmt")

        txtBillAdd.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_biladr")
        txtBillSP.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_bilstt")
        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_bilcty"), cboBillCountry)
        txtBillZIP.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_bilzip")
        txtShipAdd.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpadr")
        txtShipSP.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpstt")
        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpcty").ToString <> "" Then
            display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpcty"), cboShipCountry)
        Else
            cboShipCountry.SelectedIndex = -1
        End If

        txtShipZIP.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpzip")
        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cttper"), cboContactPerson)
        If cboContactPerson.Text <> rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cttper") Then
            MsgBox("Contact Person not found in Customer Master.", MsgBoxStyle.Exclamation)
            cboContactPerson.Items.Add(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cttper"))
            display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cttper"), cboContactPerson)
        End If

        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_Email") <> "" Then
            txtEmail.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_Email")
        End If

        txtRemark.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_rmk")

        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_agt"), cboAgent)

        'If cboSalesRep.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_salrep")) Then
        '    cboSalesRep.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_salrep_all")
        'Else
        '    cboSalesRep.SelectedIndex = cboSalesRep.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_salrep"))
        'End If
        If cboSalesRep.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_srname")) Then
            cboSalesRep.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_srname_all")
        Else
            cboSalesRep.SelectedIndex = cboSalesRep.FindString(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_srname"))
        End If

        txtCustPO.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cuspo")
        txtMOQSC.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_moqsc") 'Lester Wu 2007-10-07
        txtCustPoDat.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cpodat"), "MM/dd/yyyy")
        'txtCancelDat.Text = IIf(Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat").ToString) = "/  /", "  /  /", Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")), "MM/dd/yyyy"))
        If Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat").ToString) = "/  /" Then
            txtCancelDat.Text = "  /  /"
        Else
            txtCancelDat.Text = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")), "MM/dd/yyyy")
        End If
        txtRespPO.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_resppo")
        txtStartShipDat.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpstr"), "MM/dd/yyyy")
        txtEndShipDat.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpend"), "MM/dd/yyyy")

        txtCusTtlCtn.Text = IIf(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cusctn") = 0, "", rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cusctn"))
        txtDestination.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_dest")

        '---------------GET Before Image--------------------------
        'hdr_CanDat = IIf(Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat").ToString) = "/  /", "  /  /", Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")), "MM/dd/yyyy"))

        hdr_CustPODat = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cpodat"), "MM/dd/yyyy")
        CustPODat_ori = hdr_CustPODat

        If Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat").ToString) = "/  /" Then
            hdr_CanDat = "  /  /"
        Else
            hdr_CanDat = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")), "MM/dd/yyyy")
        End If
        hdr_ShpStrDat = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpstr"), "MM/dd/yyyy")
        hdr_ShpEndDat = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpend"), "MM/dd/yyyy")
        If rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts") <> "ACT" Then
            beforeNetAmt = 0
        Else
            beforeNetAmt = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_netamt")
        End If

        beforeStatus = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts")
        '-----------------------------------------------------------


        strDueDat = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_lbldue")
        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_prctrm"), cboPrcTrm)
        display_combo(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_paytrm"), cboPayTrm)
        txtTotalCube.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ttlvol"), "#0.0000")
        txtTotalCFT.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cft"), "#0.0000")

        txtTotalCtn.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ttlctn")
        txtAmt.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ttlamt"), "######0.00")
        txtNetAmt.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_netamt"), "######0.00")

        lblTtlAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
        lblNetAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
        cboShipAdd.SelectedIndex = -1
        cboBillAdd.SelectedIndex = -1

        strCurExRat = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curexrat")
        strCurExEffDat = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curexeffdat")

        If rs_SCCNTINF.Tables("RESULT").Rows.Count > 0 Then
            ' Edited by Mark Lau 20081106
            strConName = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_cseadr")

            strConAdd = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_cseadr")

            strConSP = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_csestt")

            strConCountry = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_csecty")

            strConZIP = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_csezip")

            strForAcc = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_fwdno")

            strForDesc = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_fwddsc")

            strForInst = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_fwditr")

            strForTyp = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_fwdtyp")

            strNotContractPerson = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopctp")

            strNotTitle = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_noptil")

            strNotAdd = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopadr")

            strNotSP = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopstt")

            strNotCountry = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopcty")

            strNotZIP = Replace(rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopzip"), "'", "''")

            strNotPhone = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopphn")

            strNotFax = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopfax")

            strNotEmail = rs_SCCNTINF.Tables("RESULT").Rows(0)("sci_nopeml")
        End If

        dv_dis = rs_SCDISPRM_D.Tables("RESULT").DefaultView
        grdDis.DataSource = dv_dis
        Display_Dis()

        dv_pre = rs_SCDISPRM_P.Tables("RESULT").DefaultView
        grdPre.DataSource = dv_pre
        Display_pre()

        poChange = False
        lblRight.Text = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_credat")), "MM/dd/yyyy") & " " & Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_upddat")), "MM/dd/yyyy") & _
                                      " " & rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_updusr")
    End Sub

    Private Sub cboPriCust_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPriCust.SelectedIndexChanged
        If initFlag = False Then
            cboPriCustChange()
        End If
    End Sub

    Private Sub cboPriCustChange()
        recordStatus = True
        '******************************Have Detail Line and Change customer Handle*********************
        If Trim(cboPriCust.Text) <> "" And cboPriCust.Enabled = True Then
            If Pricustno = Split(cboPriCust.Text, " - ")(0) Then
                Exit Sub
            End If
        End If

        If (rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Or rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0) And cboPriCust.Enabled = True Then
            ' Added by Mark Lau 20090518
            If copyFlag = False Then
                If MsgBox("All Detail and Shipmark Record will be Delete", MsgBoxStyle.YesNo) = MsgBoxResult.Yes Then
                    clearDetail()
                    clearShipMark()
                    setDtlStatus("INIT")
                    Display_Dtl("INIT")
                    Reset_ShipMark()
                    txtItmno.Text = ""
                    'Exit Sub
                Else
                    cboPriCust.Items.Clear()
                    display_combo(Pricustno, cboPriCust)
                    Exit Sub
                End If
            End If
        End If
        '*************************************************************************************************

        If Trim(cboPriCust.Text) <> "" Then
            Dim cusno As String
            cusno = Split(cboPriCust.Text, " - ")(0)
            Pricustno = Split(cboPriCust.Text, " - ")(0)

            gspStr = "sp_select_CUBASINF_SC '" & cboCoCde.Text & "','" & cusno & "','Agent'"
            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_Agent, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #032 sp_select_CUBASINF_SC : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUBASINF_SC '" & cboCoCde.Text & "','" & cusno & "','Secondary'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_S, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #033 sp_select_CUBASINF_SC : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUBASINF_SC '" & cboCoCde.Text & "','" & cusno & "','Contact Person'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_Person, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #034 sp_select_CUBASINF_SC : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUSHPINF '" & cboCoCde.Text & "','" & cusno & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUSHPINF, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #035 sp_select_CUSHPINF : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUSHPMRK '" & cboCoCde.Text & "','" & cusno & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUSHPMRK, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #036 sp_select_CUSHPMRK : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUCNTINF_SC '" & cboCoCde.Text & "','" & cusno & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUCNTINF_P, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #037 sp_select_CUCNTINF_SC : " & rtnStr)
                Exit Sub
            End If

            gspStr = "sp_select_CUCNTINF_SC_BA '" & cboCoCde.Text & "','" & cusno & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUCNTINF_BA, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #038 sp_select_CUCNTINF_SC_BA : " & rtnStr)
                Exit Sub
            End If

            Me.Cursor = Windows.Forms.Cursors.Default
            fillcboShipAdd("P")
            fillcboBillAdd()
            '*******Display Agent****************************
            fillcboAgent()
            If rs_CUBASINF_Agent.Tables("RESULT").Rows.Count > 0 Then
                Dim dr() As DataRow = rs_CUBASINF_Agent.Tables("RESULT").Select("cai_cusdef = 'Y'")
                If dr.Length > 0 Then
                    display_combo(dr(0).Item("cai_cusagt"), cboAgent)
                End If
            End If
            '************************************************
            '*******Display Person****************************
            fillcboPerson()

            If rs_CUBASINF_Person.Tables("RESULT").Rows.Count > 0 Then
                Dim drPerson() As DataRow = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'BUYR'")
                If drPerson.Length = 0 Then
                    drPerson = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'SALE'")
                    If drPerson.Length = 0 Then
                        drPerson = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y' and cci_cnttyp = 'MAGT'")
                        If drPerson.Length = 0 Then
                            drPerson = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntdef ='Y'")
                        End If
                    End If
                End If
                If drPerson.Length > 0 Then
                    cboContactPerson.Enabled = True
                    display_combo(drPerson(0).Item("cci_cntctp"), cboContactPerson)
                    txtEmail.Text = drPerson(0).Item("cci_cnteml")
                Else
                    cboContactPerson.Enabled = False
                    txtEmail.Text = ""
                End If
            Else
                cboContactPerson.Enabled = False
                txtEmail.Text = ""
            End If

            txtEmail.Enabled = True

            '*************************************************

            'aabbcc
            '***********Fill Sec Customer*************
            'If rs_CUBASINF_S.Tables("RESULT").Rows.Count > 0 And Split(cboSCStatus.Text, " - ")(0) = "ACT" And chkCloseOut.Checked = False And findFlag = False Then
            If rs_CUBASINF_S.Tables("RESULT").Rows.Count > 0 And findFlag = False Then
                SetComboStatus(cboSecCust, "Enable")
                fillcboSecCust()
            Else
                cboSecCust.Items.Clear()
                fillcboSecCust()
                SetComboStatus(cboSecCust, "Disable")
            End If
            '*****************************************
            '*********Display Add Detial***********

            Display_PrimaryCust()
            Display_CUSHPINF()
            Reset_ShipMark()
            fillcboShipMark("M")
            Me.Cursor = Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub clearDetail()
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            'For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
            '    rs_SCORDDTL.Tables("RESULT").Rows.Remove(rs_SCORDDTL.Tables("RESULT").Rows(i))
            'Next
            While rs_SCORDDTL.Tables("RESULT").Rows.Count > 0
                rs_SCORDDTL.Tables("RESULT").Rows.Remove(rs_SCORDDTL.Tables("RESULT").Rows(0))
            End While
        End If

        clearMore("ALL", 0)

        If rs_SCASSINF.Tables("RESULT").Rows.Count > 0 Then
            'For i As Integer = 0 To rs_SCASSINF.Tables("RESULT").Rows.Count - 1
            '    rs_SCASSINF.Tables("RESULT").Rows.Remove(rs_SCASSINF.Tables("RESULT").Rows(i))
            'Next
            While rs_SCASSINF.Tables("RESULT").Rows.Count > 0
                rs_SCASSINF.Tables("RESULT").Rows.Remove(rs_SCASSINF.Tables("RESULT").Rows(0))
            End While
        End If

        If rs_SCBOMINF.Tables("RESULT").Rows.Count > 0 Then
            'For i As Integer = 0 To rs_SCBOMINF.Tables("RESULT").Rows.Count - 1
            '    rs_SCBOMINF.Tables("RESULT").Rows.Remove(rs_SCBOMINF.Tables("RESULT").Rows(i))
            'Next
            While rs_SCBOMINF.Tables("RESULT").Rows.Count > 0
                rs_SCBOMINF.Tables("RESULT").Rows.Remove(rs_SCBOMINF.Tables("RESULT").Rows(0))
            End While
        End If

        MaxSeq = 0
        lblDtlSeq.Text = ""
    End Sub

    Private Sub clearMore(ByVal typ As String, ByVal seq As Integer)
        Select Case typ
            Case "ALL"
                If rs_SCDTLSHP.Tables("RESULT").Rows.Count > 0 Then
                    rs_SCDTLSHP.Tables("RESULT").Columns("sds_creusr").ReadOnly = False
                    rs_SCDTLSHP.Tables("RESULT").Columns("sds_status").ReadOnly = False
                    For i As Integer = 0 To rs_SCDTLSHP.Tables("RESULT").Rows.Count - 1
                        If rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_creusr") <> "~*ADD*~" Then
                            rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_creusr") = "~*DEL*~"
                            rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_status") = "Y"
                        ElseIf rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_creusr") = "~*ADD*~" Then
                            rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_creusr") = "~*NEW*~"
                            rs_SCDTLSHP.Tables("RESULT").Rows(i)("sds_status") = "Y"
                        End If
                    Next
                End If

                'If rs_SCDTLCTN.Tables("RESULT").Rows.Count > 0 Then
                '    rs_SCDTLCTN.Tables("RESULT").Columns("sdc_creusr").ReadOnly = False
                '    rs_SCDTLCTN.Tables("RESULT").Columns("sdc_status").ReadOnly = False
                '    For i As Integer = 0 To rs_SCDTLCTN.Tables("RESULT").Rows.Count - 1
                '        If rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_creusr") <> "~*ADD*~" Then
                '            rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_creusr") = "~*DEL*~"
                '            rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_status") = "Y"
                '        ElseIf rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_creusr") = "~*ADD*~" Then
                '            rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_creusr") = "~*NEW*~"
                '            rs_SCDTLCTN.Tables("RESULT").Rows(i)("sdc_status") = "Y"
                '        End If
                '    Next
                'End If
            Case "CTL"
                'If rs_SCDTLCTN.Tables("RESULT").Rows.Count > 0 Then
                '    Dim dr() As DataRow = rs_SCDTLCTN.Tables("RESULT").Select("sdc_seq = '" & seq & "'")
                '    If dr.Length > 0 Then
                '        rs_SCDTLCTN.Tables("RESULT").Columns("sdc_creusr").ReadOnly = False
                '        rs_SCDTLCTN.Tables("RESULT").Columns("sdc_status").ReadOnly = False
                '        For i As Integer = 0 To dr.Length - 1
                '            If dr(i).Item("sdc_creusr") <> "~*ADD*~" Then
                '                dr(i).Item("sdc_creusr") = "~*DEL*~"
                '                dr(i).Item("sdc_status") = "Y"
                '            ElseIf dr(i).Item("sdc_creusr") = "~*ADD*~" Then
                '                dr(i).Item("sdc_creusr") = "~*NEW*~"
                '                dr(i).Item("sdc_status") = "Y"
                '            End If
                '        Next
                '    End If
                'End If
            Case "SHP"
                If rs_SCDTLSHP.Tables("RESULT").Rows.Count > 0 Then
                    Dim dr() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & seq & "'")
                    If dr.Length > 0 Then
                        rs_SCDTLSHP.Tables("RESULT").Columns("sds_creusr").ReadOnly = False
                        rs_SCDTLSHP.Tables("RESULT").Columns("sds_status").ReadOnly = False
                        For i As Integer = 0 To dr.Length - 1
                            If dr(i).Item("sds_creusr") <> "~*ADD*~" Then
                                dr(i).Item("sds_creusr") = "~*DEL*~"
                                dr(i).Item("sds_status") = "Y"
                            ElseIf dr(i).Item("sds_creusr") = "~*ADD*~" Then
                                dr(i).Item("sds_creusr") = "~*NEW*~"
                                dr(i).Item("sds_status") = "Y"
                            End If
                        Next
                    End If
                End If
        End Select
    End Sub

    Private Sub clearShipMark()
        If rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_SCSHPMRK.Tables("RESULT").Rows.Count - 1
                rs_SCSHPMRK.Tables("RESULT").Rows.Remove(rs_SCSHPMRK.Tables("RESULT").Rows(0))
                rs_SCSHPMRK.AcceptChanges()
            Next
        End If
    End Sub

    Private Sub setDtlStatus(ByVal Mode As String)

        If Mode = "INIT" Then
            recordMove("INIT")
            txtItmno.Enabled = False
            txtItmStatus.Enabled = False
            txtItmDsc.Enabled = False
            txtOldItem.Enabled = False
            txtOldColor.Enabled = False
            cboColPckInfo.Enabled = False
            'cboSubCde.Enabled = False
            cboCustUM.Enabled = False
            txtRefDoc.Enabled = False
            txtRefdat.Enabled = False
            txtUM.Enabled = False

            txtItmPrc.Enabled = False
            txtSelprc.Enabled = False
            txtNetUntPrc.Enabled = False
            txtUntPrc.Enabled = False
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
            txtPeriod.Enabled = False   'Frankie Cheung 20100413 Add Period
            txtIMPeriod.Enabled = False   'Frankie Cheung 20100806 Add IM Period

            cmdMatBrkdwn.Enabled = False

            txtCustColCde.Enabled = False
            txtColDsc.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCustItmno.Enabled = False
            txtCustItmno.Enabled = True
            txtCustItmno.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtSecCusItm.Enabled = True
            txtSecCusItm.ReadOnly = True

            '*** Modify by johnson on 28 Jun 2002
            'txtSKUno.Enabled = False
            txtSKUNo.Enabled = True
            txtSKUNo.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtPckItr.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCustPODtl.Enabled = False
            txtCustPODtl.Enabled = True
            txtCustPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002


            '*** Modify by johnson on 28 Jun 2002
            'txtRespPODtl.Enabled = False
            txtRespPODtl.Enabled = True
            txtRespPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtZTNVBELN.Enabled = False
            txtZTNPOSNR.Enabled = False
            txtTentOrdno.Enabled = False
            txtTentOrdSeq.Enabled = False

            txtOrdQty.Enabled = False
            txtShipped.Enabled = False
            txtDiscount.Enabled = False
            If Val(txtMOQChg.Text) = 0 Then
                txtMOQChg.Enabled = False
            Else
                If cboSCStatus.Text.Substring(0, 3) <> "REL" And cboSCStatus.Text.Substring(0, 3) <> "CLO" Then
                    txtMOQChg.Enabled = True
                Else
                    txtMOQChg.Enabled = False
                End If
            End If
            txtRefClaim.Enabled = False
            txtMOA.Enabled = False
            txtMOQ.Enabled = False

            'cboHSTU.Enabled = False
            SetComboStatus(cboHSTU, "Disable")
            txtDuty.Enabled = False
            txtDept.Enabled = False


            optEAN.Enabled = False
            optUPC.Enabled = False

            OptOnePrcY.Enabled = False
            OptOnePrcN.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeMer.Enabled = False
            txtCdeMer.Enabled = True
            txtCdeMer.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002


            '*** Modify by johnson on 28 Jun 2002
            'txtCdeInr.Enabled = False
            txtCdeInr.Enabled = True
            txtCdeInr.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeCtn.Enabled = False
            txtCdeCtn.Enabled = True
            txtCdeCtn.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            cboRetailUSDCur.Enabled = False
            txtRetailUSD.Enabled = False
            cboRetailCADCur.Enabled = False
            txtRetailCAD.Enabled = False

            txtStartShip.Enabled = False
            txtEndShip.Enabled = False
            txtCanDat.Enabled = False

            txtPOStartShip.Enabled = False
            txtPOEndShip.Enabled = False
            txtPOCanDat.Enabled = False
            cmdPOCalDat.Enabled = False

            txtStartCarton.Enabled = False
            txtEndCarton.Enabled = False
            chkDelDtl.Enabled = False
            chkUpdatePO.Enabled = False
            chkChgFty.Enabled = False
            txtVenno.Enabled = False
            cboPrdVen.Enabled = False
            cboCusVen.Enabled = False
            cboTradeVen.Enabled = False
            cboExamVen.Enabled = False
            'cmdMoreCtn.Enabled = False
            cmdMoreShp.Enabled = False

            cmdAss.Enabled = False
            cmdBOM.Enabled = False
            cmdDtlSCRmk.Enabled = False
            txtDtlSCRmk.Enabled = False
            cmdDtlPORmk.Enabled = False
            txtDtlPORmk.Enabled = False
            cmdUpdItmPckInfo.Enabled = False
            cmdRplSeq.Enabled = False

            ' Added by Mark Lau 20081106
            cboCusStyNo.Enabled = True

            'Frankie Cheung 20110315
            cmdOrgScCst.Enabled = False

            imu_key.Enabled = True
            imu_key.ReadOnly = True

            cboSeason.Enabled = False
            '***********************************************************************************************
            '***************************************FIND RECORD**********************************************
            '***********************************************************************************************
        ElseIf Mode = "FIND" Then
            txtItmno.Enabled = True
            txtPJobNo.Enabled = True

            txtOldItem.Enabled = False
            txtOldColor.Enabled = False
            txtItmStatus.Enabled = False
            txtItmPrc.Enabled = False
            txtSelprc.Enabled = False
            txtNetUntPrc.Enabled = False
            txtUntPrc.Enabled = False
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
            txtPeriod.Enabled = False   'Frankie Cheung 20100413 Add Period
            txtIMPeriod.Enabled = False   'Frankie Cheung 20100806 Add IM Period

            txtUM.Enabled = False
            cmdMatBrkdwn.Enabled = False
            cmdAss.Enabled = False
            cmdBOM.Enabled = False
            cboColPckInfo.Enabled = False
            'cboSubCde.Enabled = False
            txtRefDoc.Enabled = False
            txtRefdat.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCustItmno.Enabled = False
            txtCustItmno.Enabled = True
            txtCustItmno.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtSecCusItm.Enabled = True
            txtSecCusItm.ReadOnly = True

            '*** Modify by johnson on 28 Jun 2002
            'txtSKUno.Enabled = False
            txtSKUNo.Enabled = True
            txtSKUNo.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtPckItr.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCustPODtl.Enabled = False
            txtCustPODtl.Enabled = True
            txtCustPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002


            '*** Modify by johnson on 28 Jun 2002
            'txtRespPODtl.Enabled = False
            txtRespPODtl.Enabled = True
            txtRespPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtZTNVBELN.Enabled = True
            txtZTNPOSNR.Enabled = True
            txtTentOrdno.Enabled = True
            txtTentOrdSeq.Enabled = False

            txtOrdQty.Enabled = False
            txtShipped.Enabled = False
            txtItmDsc.Enabled = False
            txtCustColCde.Enabled = False
            txtColDsc.Enabled = False
            txtDiscount.Enabled = False
            If Val(txtMOQChg.Text) = 0 Then
                txtMOQChg.Enabled = False
            Else
                If cboSCStatus.Text.Substring(0, 3) <> "REL" And cboSCStatus.Text.Substring(0, 3) <> "CLO" Then
                    txtMOQChg.Enabled = True
                Else
                    txtMOQChg.Enabled = False
                End If
            End If
            'cboHSTU.Enabled = False
            SetComboStatus(cboHSTU, "Disable")
            txtDuty.Enabled = False
            txtDept.Enabled = False
            txtRefClaim.Enabled = False
            txtMOA.Enabled = False
            txtMOQ.Enabled = False

            optEAN.Enabled = False
            optUPC.Enabled = False

            OptOnePrcY.Enabled = False
            OptOnePrcN.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeMer.Enabled = False
            txtCdeMer.Enabled = True
            txtCdeMer.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeInr.Enabled = False
            txtCdeInr.Enabled = True
            txtCdeInr.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeCtn.Enabled = False
            txtCdeCtn.Enabled = True
            txtCdeCtn.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            cboRetailUSDCur.Enabled = False
            txtRetailUSD.Enabled = False
            cboRetailCADCur.Enabled = False
            txtRetailCAD.Enabled = False

            txtStartShip.Enabled = False
            txtEndShip.Enabled = False
            txtCanDat.Enabled = False

            txtPOStartShip.Enabled = False
            txtPOEndShip.Enabled = False
            txtPOCanDat.Enabled = False
            cmdPOCalDat.Enabled = False

            txtStartCarton.Enabled = False

            txtEndCarton.Enabled = False
            chkUpdatePO.Enabled = False
            chkChgFty.Enabled = False
            txtVenno.Enabled = False
            cboPrdVen.Enabled = False
            cboCusVen.Enabled = False
            cboTradeVen.Enabled = False
            cboExamVen.Enabled = False
            'cmdMoreCtn.Enabled = False
            cmdMoreShp.Enabled = False

            cmdDtlSCRmk.Enabled = False
            txtDtlSCRmk.Enabled = False
            cmdDtlPORmk.Enabled = False
            txtDtlPORmk.Enabled = False
            cmdUpdItmPckInfo.Enabled = False
            cmdRplSeq.Enabled = False


            ' Added by Mark Lau 20081106
            cboCusStyNo.Enabled = False

            imu_key.Enabled = True
            imu_key.ReadOnly = True

            cboSeason.Enabled = False

            '***********************************************************************************************
            '***************************************ADD RECORD**********************************************
            '***********************************************************************************************
        ElseIf Mode = "ADD" Then

            txtItmStatus.Enabled = False
            txtOldItem.Enabled = False
            txtOldColor.Enabled = False
            txtItmPrc.Enabled = False
            txtSelprc.Enabled = False
            txtNetUntPrc.Enabled = False
            txtUntPrc.Enabled = False
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
            txtPeriod.Enabled = False        'Frankie Cheung 20100413 Add Period
            txtIMPeriod.Enabled = False      'Frankie Cheung 20100413 Add IM Period
            cmdMatBrkdwn.Enabled = True

            txtOldItem.Enabled = False
            txtOldColor.Enabled = False

            txtUM.Enabled = False
            'cmdAss.Enabled = False
            txtRefDoc.Enabled = False
            txtRefdat.Enabled = False
            txtShipped.Enabled = False
            txtMOA.Enabled = False
            txtMOQ.Enabled = False

            txtItmno.Enabled = True
            txtPJobNo.Enabled = True
            cboColPckInfo.Enabled = True

            txtCustItmno.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCustItmno.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtSecCusItm.Enabled = True
            txtSecCusItm.ReadOnly = False

            txtSKUNo.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtSKUNo.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtItmDsc.Enabled = True
            txtItmDsc.ReadOnly = False

            imu_key.Enabled = True
            imu_key.ReadOnly = True

            txtPckItr.Enabled = True
            txtPckItr.ReadOnly = False

            txtCustPODtl.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCustPODtl.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtRespPODtl.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtRespPODtl.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtZTNVBELN.Enabled = True
            txtZTNPOSNR.Enabled = True
            txtTentOrdno.Enabled = True
            txtTentOrdSeq.Enabled = False

            txtOrdQty.Enabled = True
            If authUsr = True Then
                txtDiscount.Enabled = True
            Else
                txtDiscount.Enabled = False
            End If
            'txtmoqchg.Enabled = True

            txtItmDsc.Enabled = True
            txtCustColCde.Enabled = True
            txtColDsc.Enabled = True
            txtColDsc.ReadOnly = False
            txtRefClaim.Enabled = True

            'cboHSTU.Enabled = True
            SetComboStatus(cboHSTU, "Enable")
            txtDuty.Enabled = True
            txtDept.Enabled = True

            'OptEAN.value = True
            optEAN.Enabled = True
            optUPC.Enabled = True

            OptOnePrcY.Enabled = True
            OptOnePrcN.Enabled = True

            txtCdeMer.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeMer.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            txtCdeInr.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeInr.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            txtCdeCtn.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeCtn.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            cboRetailUSDCur.Enabled = True
            txtRetailUSD.Enabled = True
            cboRetailCADCur.Enabled = True
            txtRetailCAD.Enabled = True

            txtStartCarton.Enabled = True
            txtEndCarton.Enabled = True
            chkDelDtl.Enabled = True
            chkUpdatePO.Enabled = False
            chkChgFty.Enabled = False
            txtVenno.Enabled = False
            cboPrdVen.Enabled = True
            cboCusVen.Enabled = True
            cboTradeVen.Enabled = True
            cboExamVen.Enabled = True
            'cmdMoreCtn.Enabled = True
            cmdMoreShp.Enabled = True

            cmdDtlSCRmk.Enabled = True
            txtDtlSCRmk.Enabled = True
            txtDtlSCRmk.ReadOnly = False
            cmdDtlPORmk.Enabled = True
            txtDtlPORmk.Enabled = True
            txtDtlPORmk.ReadOnly = False
            cmdUpdItmPckInfo.Enabled = False
            cmdRplSeq.Enabled = True

            ' Added by Mark Lau 20080611
            cboCustUM.Enabled = True

            cboCusStyNo.Enabled = False

            imu_key.Enabled = True
            imu_key.ReadOnly = True

            'cboSeason.Enabled = True
            cboSeason.Enabled = False
            '***********************************************************************************************
            '***************************************UPDATE RECORD*******************************************
            '***********************************************************************************************
        ElseIf Mode = "Updating" Then
            txtItmStatus.Enabled = False
            txtItmno.Enabled = False

            txtOldItem.Enabled = False
            txtOldColor.Enabled = False
            txtPJobNo.Enabled = True
            cboColPckInfo.Enabled = False
            txtRefDoc.Enabled = False
            txtRefdat.Enabled = False
            txtUM.Enabled = False
            txtItmPrc.Enabled = False
            txtSelprc.Enabled = False
            txtNetUntPrc.Enabled = False
            txtUntPrc.Enabled = False
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
            txtPeriod.Enabled = False        'Frankie Cheung 20100413 Add Period
            txtIMPeriod.Enabled = False      'Frankie Cheung 20100413 Add IM Period

            cmdMatBrkdwn.Enabled = True

            txtCustPODtl.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCustPODtl.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtShipped.Enabled = False
            txtMOA.Enabled = False
            txtMOQ.Enabled = False

            txtCustItmno.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCustItmno.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtSecCusItm.Enabled = True
            txtSecCusItm.ReadOnly = False

            txtSKUNo.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtSKUNo.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtItmDsc.Enabled = True
            txtItmDsc.ReadOnly = False

            imu_key.Enabled = True
            imu_key.ReadOnly = True

            txtPckItr.Enabled = True
            txtPckItr.ReadOnly = False
            txtRespPODtl.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtRespPODtl.ReadOnly = False
            '*** End modify by johnson on 28 Jun 2002

            txtZTNVBELN.Enabled = True
            txtZTNPOSNR.Enabled = True
            txtTentOrdno.Enabled = True
            txtTentOrdSeq.Enabled = False

            txtOrdQty.Enabled = True
            txtItmDsc.Enabled = True
            txtCustColCde.Enabled = True
            txtColDsc.Enabled = True
            txtColDsc.ReadOnly = False
            If authUsr = True Then
                txtDiscount.Enabled = True
            Else
                txtDiscount.Enabled = False
            End If
            'txtmoqchg.Enabled = True
            txtRefClaim.Enabled = True

            cboCustUM.Enabled = True

            'cboHSTU.Enabled = True
            SetComboStatus(cboHSTU, "Enable")
            txtDuty.Enabled = True
            txtDept.Enabled = True


            optEAN.Enabled = True
            optUPC.Enabled = True

            OptOnePrcY.Enabled = True
            OptOnePrcN.Enabled = True

            txtCdeMer.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeMer.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            txtCdeInr.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeInr.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            txtCdeCtn.Enabled = True
            '*** Modify by johnson on 28 Jun 2002
            txtCdeCtn.ReadOnly = False
            '*** End Modify by johnson on 28 Jun 2002

            cboRetailUSDCur.Enabled = True
            txtRetailUSD.Enabled = True
            cboRetailCADCur.Enabled = True
            txtRetailCAD.Enabled = True

            txtCanDat.Enabled = True
            txtPOCanDat.Enabled = True
            chkDelDtl.Enabled = True
            If Me.txtSCVerNo.Text <> "1" Then
                chkUpdatePO.Enabled = True
                chkChgFty.Enabled = True
            Else
                'txtMOQChg.Enabled = True
                chkUpdatePO.Enabled = False
                chkChgFty.Enabled = False
            End If
            txtVenno.Enabled = False
            cboPrdVen.Enabled = True
            cboCusVen.Enabled = True
            cboTradeVen.Enabled = True
            cboExamVen.Enabled = True
            'cmdMoreCtn.Enabled = True
            cmdMoreShp.Enabled = True
            'If gsCompany = "UCP" Then
            '    cboSubCde.Enabled = True
            'Else
            '    cboSubCde.Enabled = False
            'End If

            cmdDtlSCRmk.Enabled = True
            txtDtlSCRmk.Enabled = True
            txtDtlSCRmk.ReadOnly = False
            cmdDtlPORmk.Enabled = True
            txtDtlPORmk.Enabled = True
            txtDtlPORmk.ReadOnly = False
            cmdRplSeq.Enabled = True

            '**************Disable BOM Button*********************
            If rs_SCBOMINF.Tables("RESULT").Rows.Count > 0 Then
                Dim drBOM() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = '" & currentOrdSeq & "'")
                If drBOM.Length > 0 Then
                    cmdBOM.Enabled = True
                Else
                    cmdBOM.Enabled = False
                End If
            Else
                cmdBOM.Enabled = False
            End If
            '*****************************************************

            '**************Enable or Disable Ass Button*********************
            If Split(lblColPckType.Text, strColPck)(1) = "ASS" Then
                Dim drASS() As DataRow = rs_SCASSINF.Tables("RESULT").Select("sai_ordseq = '" & currentOrdSeq & "'")
                If drASS.Length > 0 Then
                    cmdAss.Enabled = True
                Else
                    cmdAss.Enabled = False
                End If
            Else
                cmdAss.Enabled = False
            End If
            '***************************************************************

            cmdUpdItmPckInfo.Enabled = True
            If Me.chkPC.Visible And Me.chkPC.Checked = True Then
                Me.txtUntPrc.ReadOnly = True
            Else
                Me.txtUntPrc.ReadOnly = False
            End If

            'cboSeason.Enabled = True
            cboSeason.Enabled = False

            cboCusStyNo.Enabled = True
        ElseIf Mode = "HIST" Then
            txtItmno.Enabled = False
            txtPJobNo.Enabled = False
            txtItmStatus.Enabled = False
            txtOldItem.Enabled = False
            txtOldColor.Enabled = False
            txtItmDsc.Enabled = False
            cboColPckInfo.Enabled = False
            'cboSubCde.Enabled = False
            txtRefDoc.Enabled = False
            txtRefdat.Enabled = False
            txtUM.Enabled = False
            txtShipped.Enabled = False
            txtMOA.Enabled = False
            txtMOQ.Enabled = False

            Dim drSCCPTBKD() As DataRow = rs_SCCPTBKD.Tables("RESULT").Select("scb_ordseq = '" & currentOrdSeq & "'")
            If drSCCPTBKD.Length > 0 Then
                cmdMatBrkdwn.Enabled = True
            Else
                cmdMatBrkdwn.Enabled = False
            End If

            txtItmPrc.Enabled = False
            txtSelprc.Enabled = False
            txtPeriod.Enabled = False        'Frankie Cheung 20100413 Add Period
            txtIMPeriod.Enabled = False      'Frankie Cheung 20100806 Add IM Period

            txtUntPrc.Enabled = False
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False

            ' Added by Mark Lau 20080826
            ' Rem by Mark Lau 20081106
            'cmdDVFtyprc.Enabled = True

            txtCustColCde.Enabled = False
            txtColDsc.Enabled = True
            txtColDsc.ReadOnly = True

            '*** Modify by johnson on 28 Jun 2002
            'txtCustItmno.Enabled = False
            txtCustItmno.Enabled = True
            txtCustItmno.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002
            txtSecCusItm.Enabled = True
            txtSecCusItm.ReadOnly = True

            '*** Modify by johnson on 28 Jun 2002
            'txtSKUno.Enabled = False
            txtSKUNo.Enabled = True
            txtSKUNo.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002


            txtPckItr.Enabled = True
            txtPckItr.ReadOnly = True
            txtItmDsc.Enabled = True
            txtItmDsc.ReadOnly = True

            '*** Modify by johnson on 28 Jun 2002
            'txtCustPODtl.Enabled = False
            txtCustPODtl.Enabled = True
            txtCustPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtRespPODtl.Enabled = False
            txtRespPODtl.Enabled = True
            txtRespPODtl.ReadOnly = True
            '*** End modify by johnson on 28 Jun 2002

            txtZTNVBELN.Enabled = False
            txtZTNPOSNR.Enabled = False
            txtTentOrdno.Enabled = False
            txtTentOrdSeq.Enabled = False

            txtOrdQty.Enabled = False
            txtDiscount.Enabled = False
            If Val(txtMOQChg.Text) = 0 Then
                txtMOQChg.Enabled = False
            Else
                If cboSCStatus.Text.Substring(0, 3) <> "REL" And cboSCStatus.Text.Substring(0, 3) <> "CLO" Then
                    txtMOQChg.Enabled = True
                Else
                    txtMOQChg.Enabled = False
                End If
            End If
            txtRefClaim.Enabled = False

            'cboHSTU.Enabled = False
            SetComboStatus(cboHSTU, "Disable")
            txtDuty.Enabled = False
            txtDept.Enabled = False


            optEAN.Enabled = False
            optUPC.Enabled = False

            OptOnePrcY.Enabled = False
            OptOnePrcN.Enabled = False

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeMer.Enabled = False
            txtCdeMer.Enabled = True
            txtCdeMer.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeInr.Enabled = False
            txtCdeInr.Enabled = True
            txtCdeInr.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            '*** Modify by johnson on 28 Jun 2002
            'txtCdeCtn.Enabled = False
            txtCdeCtn.Enabled = True
            txtCdeCtn.ReadOnly = True
            '*** End Modify by johnson on 28 Jun 2002

            cboRetailUSDCur.Enabled = False
            txtRetailUSD.Enabled = False
            cboRetailCADCur.Enabled = False
            txtRetailCAD.Enabled = False

            txtStartShip.Enabled = False
            txtEndShip.Enabled = False
            txtCanDat.Enabled = False

            txtPOStartShip.Enabled = False
            txtPOEndShip.Enabled = False
            txtPOCanDat.Enabled = False
            cmdPOCalDat.Enabled = False

            txtStartCarton.Enabled = False
            txtEndCarton.Enabled = False
            chkDelDtl.Enabled = False
            chkUpdatePO.Enabled = False
            chkChgFty.Enabled = False
            txtVenno.Enabled = False
            cboPrdVen.Enabled = False
            cboCusVen.Enabled = False
            cboTradeVen.Enabled = False
            cboExamVen.Enabled = False

            cmdDtlSCRmk.Enabled = False
            txtDtlSCRmk.Enabled = True
            txtDtlSCRmk.ReadOnly = True
            cmdDtlPORmk.Enabled = False
            txtDtlPORmk.Enabled = True
            txtDtlPORmk.ReadOnly = True
            cmdRplSeq.Enabled = False

            cboSeason.Enabled = False

            cboCusStyNo.Enabled = False
        ElseIf Mode = "HLD" Then
            setDtlStatus("Updating")
            'ChkDelDtl.Enabled = False
            txtUntPrc.Enabled = False


        ElseIf Mode = "SHIPPED" Then
            setDtlStatus("Updating")
            chkDelDtl.Enabled = False
            txtVenno.Enabled = False
            cboPrdVen.Enabled = False
            cboCusVen.Enabled = False
            cboTradeVen.Enabled = False
            cboExamVen.Enabled = False
            'txtUntPrc.Enabled = False

        ElseIf Mode = "UNAuth" Then
            txtUntPrc.Enabled = False
            txtPCPrc.Enabled = False
            chkPC.Enabled = False
        ElseIf Mode = "Auth" Then
            cmdSave.Enabled = True
            txtUntPrc.Enabled = True
            txtPCPrc.Enabled = True
            chkPC.Enabled = True
        ElseIf Mode = "NoCost" Then
            lblItmCst.Visible = False
            lblItmCstCur.Visible = False
            lblTtlCst.Visible = False
            'lblTtlCstCur.Visible = False
            lblFtyUnt.Visible = False
            lblBOMCst.Visible = False
            'lblBOMCstCur.Visible = False
            txtTtlCst.Visible = False
            txtItmCst.Visible = False
            txtBOMCst.Visible = False

            lblDVCap.Visible = False
            lblDVName.Visible = False
            'lblDVItmCst.Visible = False
            lblDVItmCstCur.Visible = False
            lblBOMCst.Visible = False
            'lblBOMCstCur.Visible = False
            lblTtlCst.Visible = False
            'lblTtlCstCur.Visible = False
            lblDVFtyUnt.Visible = False
            txtDVItmCst.Visible = False
            txtDVBOMCst.Visible = False
            txtDVTtlCst.Visible = False
        ElseIf Mode = "Cost" Then
            lblItmCst.Visible = True
            lblItmCstCur.Visible = True
            lblBOMCst.Visible = True
            'lblBOMCstCur.Visible = True
            lblTtlCst.Visible = True
            'lblTtlCstCur.Visible = True
            lblFtyUnt.Visible = True
            txtItmCst.Visible = True
            txtBOMCst.Visible = True
            txtTtlCst.Visible = True

            lblDVCap.Visible = True
            lblDVName.Visible = True
            'lblDVItmCst.Visible = True
            lblDVItmCstCur.Visible = True
            lblBOMCst.Visible = True
            'lblBOMCstCur.Visible = True
            lblTtlCst.Visible = True
            'lblTtlCstCur.Visible = True
            lblDVFtyUnt.Visible = True
            txtDVItmCst.Visible = True
            txtDVBOMCst.Visible = True
            txtDVTtlCst.Visible = True
        ElseIf Mode = "NoDVCost" Then
            lblItmCst.Visible = True
            lblItmCstCur.Visible = True
            lblBOMCst.Visible = True
            'lblBOMCstCur.Visible = True
            lblTtlCst.Visible = True
            'lblTtlCstCur.Visible = True
            lblFtyUnt.Visible = True
            txtItmCst.Visible = True
            txtBOMCst.Visible = True
            txtTtlCst.Visible = True
            lblBOMCst.Visible = True
            'lblBOMCstCur.Visible = True
            lblTtlCst.Visible = True
            'lblTtlCstCur.Visible = True

            'lblDVCap.Visible = False
            lblDVName.Visible = False
            'lblDVItmCst.Visible = False
            lblDVItmCstCur.Visible = False
            lblDVFtyUnt.Visible = False
            txtDVItmCst.Visible = False
            txtDVBOMCst.Visible = False
            txtDVTtlCst.Visible = False
        ElseIf Mode = "NoPrice" Then
            lblBasprc.Visible = False
            lblBasprcCur.Visible = False
            txtItmPrc.Visible = False
            lblSelprc.Visible = False
            lblSelprcCur.Visible = False
            txtUntPrc.Visible = False
            txtPCPrc.Visible = False
            lblPCPrc.Visible = False
            lblPCPrcCur.Visible = False
            lblNetprc.Visible = False
            lblNetprcCur.Visible = False
            txtNetUntPrc.Visible = False
            lblSubttl.Visible = False
            lblSubttlCur.Visible = False
            txtSelprc.Visible = False

            cmdOrgScCst.Visible = False
        ElseIf Mode = "Price" Then
            lblBasprc.Visible = True
            lblBasprcCur.Visible = True
            txtItmPrc.Visible = True
            lblSelprc.Visible = True
            lblSelprcCur.Visible = True
            txtUntPrc.Visible = True
            txtPCPrc.Visible = True
            lblPCPrc.Visible = True
            lblPCPrcCur.Visible = True
            lblNetprc.Visible = True
            lblNetprcCur.Visible = True
            txtNetUntPrc.Visible = True
            lblSubttl.Visible = True
            lblSubttlCur.Visible = True
            txtSelprc.Visible = True

            cmdOrgScCst.Visible = True
        ElseIf Mode = "APPROVED" Then
            'txtOrdQty.Enabled = False
            txtDiscount.Enabled = False
            ' txtMOQChg.Enabled = False
            chkDelDtl.Enabled = False

        ElseIf Mode = "Replace" Then
            'txtTtlCst.Enabled = True
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = True
            enable_txtBOMCst()  'txtBOMCst.Enabled = True
        ElseIf Mode = "Non-Replace" Then
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
        End If

        imu_key.Enabled = True
        imu_key.ReadOnly = True

        'recordStatus = False
    End Sub

    Private Sub recordMove(ByVal typ As String)
        Dim Shp As Boolean
        Select Case typ

            Case "BACK"
                If cmdDtlBack.Enabled And cmdDtlBack.Visible Then cmdDtlBack.Focus()
                updateDetailRS()
                'rs_SCORDDTL.MovePrevious()
                ''-- Cater amendment if sorting sequence is not in sequence order
                'If rs_SCORDDTL.BOF Then rs_SCORDDTL.MoveFirst()
                '--------------
                currentRow = currentRow - 1
                If currentRow < 0 Then
                    currentRow = 0
                    currentOrdSeq = 1
                End If
                currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
            Case "NEXT"
                If cmdDtlNext.Enabled And cmdDtlNext.Visible Then cmdDtlNext.Focus()
                updateDetailRS()
                'rs_SCORDDTL.MoveNext()
                ''-- Cater amendment if sorting sequence is not in sequence order
                'If rs_SCORDDTL.EOF Then rs_SCORDDTL.MoveLast()
                ''--------------
                currentRow = currentRow + 1
                If currentRow > rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
                    currentRow = rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                End If
                currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
                'Case "INIT"
            Case "TAB"
                updateDetailRS()
        End Select

        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            If rs_SCORDDTL.Tables("RESULT").Rows.Count = 1 Then
                cmdDtlBack.Enabled = False
                cmdDtlNext.Enabled = False
            ElseIf currentRow = 0 Then
                cmdDtlBack.Enabled = False
                cmdDtlNext.Enabled = True
            ElseIf currentRow > 0 And currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
                cmdDtlBack.Enabled = True
                cmdDtlNext.Enabled = True
            ElseIf currentRow = rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
                cmdDtlBack.Enabled = True
                cmdDtlNext.Enabled = False
            End If

            If typ <> "INIT" And typ <> "DEL" Then
                setDtlStatus("INIT")
                Display_Dtl("SCORDDTL")
                'bbccdd
                If historyFlag = True Or (Split(cboSCStatus.Text, " - ")(0) <> "ACT" And Split(cboSCStatus.Text, " - ")(0) <> "HLD") Then
                    setDtlStatus("HIST")
                    If cmdDtlBack.Enabled = False And cmdDtlNext.Enabled = True Then
                        If cmdDtlNext.Enabled And cmdDtlNext.Visible Then cmdDtlNext.Focus()
                    ElseIf cmdDtlBack.Enabled = True And cmdDtlNext.Enabled = False Then
                        If cmdDtlBack.Enabled And cmdDtlBack.Visible Then cmdDtlBack.Focus()
                    End If
                ElseIf rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    setDtlStatus("ADD")
                    '**********Check Replacement******************
                    'If chkReplacement.value = 1 And gsFlgCst = "1" And Authusr = True Then
                    If gsFlgCst = "1" And gsFlgCstExt = "1" And authUsr = True Then
                        setDtlStatus("Replace")
                    Else
                        setDtlStatus("Non-Replace")
                    End If
                    '*********************************************
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                ElseIf Split(cboSCStatus.Text, " - ")(0) = "HLD" Then
                    Call setDtlStatus("HLD")
                    If txtItmDsc.Enabled And txtItmDsc.Visible Then txtItmDsc.Focus()
                ElseIf rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*DEL*~" Or _
                       rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*NEW*~" Then
                    setDtlStatus("INIT")
                    chkDelDtl.Enabled = True
                Else

                    setDtlStatus("Updating")
                    '**********Check Replacement******************
                    'If chkReplacement.value = 1 And gsFlgCst = "1" And Authusr = True Then
                    If gsFlgCst = "1" And authUsr = True And gsFlgCstExt = "1" Then
                        setDtlStatus("Replace")
                    Else
                        setDtlStatus("Non-Replace")
                    End If
                    '*********************************************
                    If txtItmDsc.Enabled And txtItmDsc.Visible Then txtItmDsc.Focus()
                End If


                If (rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpqty") <> 0 And txtSCVerNo.Text <> 1) And _
                   (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") Then
                    setDtlStatus("SHIPPED")
                    If txtItmDsc.Enabled And txtItmDsc.Visible Then txtItmDsc.Focus()
                End If

                If IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount")) <> 0 Then
                    assItmCount = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount")
                End If

                checkMore()
            End If

            '**************Check Auth User************************
            If authUsr = True And (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And _
               (typ = "BACK" Or typ = "NEXT" Or typ = "DEL" Or typ = "LOAD") And chkDelDtl.Checked = False And _
               txtItmno.Text <> "" And cboColPckInfo.Text <> "" Then
                setDtlStatus("Auth")
            Else
                setDtlStatus("UNAuth")
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_apprve") = "Y" Then
                    setDtlStatus("APPROVED")
                End If
            End If

            If VendorType = "E" Then
                If gsFlgCstExt = "1" Then
                    'setDtlStatus("Cost")
                    setDtlStatus("NoDVCost")
                Else
                    setDtlStatus("NoCost")
                End If
            End If

            If VendorType = "I" Then
                If gsFlgCst = "1" Then
                    setDtlStatus("Cost")
                Else
                    setDtlStatus("NoCost")
                End If
            End If

            If Trim(txtSCVerNo.Text) = "1" And (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") Or _
               (rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Or _
               rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*DEL*~" Or _
               rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*NEW*~") Then
                chkDelDtl.Enabled = True
            Else
                chkDelDtl.Enabled = False
            End If

        Else
            cmdDtlBack.Enabled = False
            cmdDtlNext.Enabled = False
        End If


        recordStatus_dtl = False
    End Sub

    Private Sub updateDetailRS()
        Dim colcde As String
        Dim um As String
        Dim inner As String
        Dim master As String
        Dim CFT As String
        Dim CBM As String
        Dim FtyPrcTrm As String
        Dim HKPrcTrm As String
        Dim TranTrm As String

        If rs_SCORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub
        End If
        '----
        If txtPC.Text = "" Then txtPC.Text = 0
        If txtOrdQty.Text = "" Then txtOrdQty.Text = 0
        If txtUntPrc.Text = "" Then txtUntPrc.Text = 0
        If txtMOQChg.Text = "" Then txtMOQChg.Text = 0
        '----

        If recordStatus_dtl = True And chkDelDtl.Checked = False Then

            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_apprve") <> "Y" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_apprve") = "N"
            End If

            Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text, txtMOQChg.Text)
            Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)

            If Trim(cboColPckInfo.Text) <> "" Then
                colcde = Split(cboColPckInfo.Text, " / ")(0)
                um = Split(cboColPckInfo.Text, " / ")(1)
                inner = Split(cboColPckInfo.Text, " / ")(2)
                master = Split(cboColPckInfo.Text, " / ")(3)
                CFT = Split(cboColPckInfo.Text, " / ")(4)
                CBM = Split(cboColPckInfo.Text, " / ")(5)
                FtyPrcTrm = Split(cboColPckInfo.Text, " / ")(6)
                HKPrcTrm = Split(cboColPckInfo.Text, " / ")(7)
                TranTrm = Split(cboColPckInfo.Text, " / ")(8)
            Else
                colcde = ""
                um = ""
                inner = ""
                master = ""
                CFT = ""
                CBM = ""
                FtyPrcTrm = ""
                HKPrcTrm = ""
                TranTrm = ""
            End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv") = Split(txtVenno.Text, " - ")(0)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno") = Split(cboPrdVen.Text, " - ")(0)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pvname") = cboPrdVen.Text
            'If Trim(cboCusVen.Text) <> "" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusven") = Split(cboCusVen.Text, " - ")(0)
            'End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusven") = Split(cboCusVen.Text, " - ")(0)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cvname") = cboCusVen.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tradeven") = Split(cboTradeVen.Text, " - ")(0)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tvname") = cboTradeVen.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_examven") = Split(cboExamVen.Text, " - ")(0)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_evname") = cboExamVen.Text

            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount") = assItmCount
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgvenno") = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno")
                If Tier_typ = True And CUSMOQChgFlag = True And chkCloseOut.Checked = False And chkReplacement.Checked = False Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusmoqchg").Value = "Y"
                Else
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusmoqchg") = "N"
                End If
                If VENMOQChgFlag = True Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venmoqchg") = "Y"
                Else
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venmoqchg") = "N"
                End If
            End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_colcde") = colcde
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckunt") = um
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrctn") = IIf(inner.Length = 0, "0", inner)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrctn") = IIf(master.Length = 0, "0", master)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cft") = IIf(CFT.Length = 0, 0, CFT)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cbm") = IIf(CBM.Length = 0, 0, CBM)



            lblDtlSeq.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq")
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmtyp") = Split(lblColPckType.Text, strColPck)(1)

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("ibi_itmsts") = txtItmStatus.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmno") = txtItmno.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmdsc") = txtItmDsc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_colpck") = cboColPckInfo.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscol") = txtCustColCde.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_coldsc") = txtColDsc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutno") = txtRefDoc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_refdat") = txtRefdat.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusitm") = txtCustItmno.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cussku") = txtSKUNo.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuspo") = txtCustPODtl.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_resppo") = txtRespPODtl.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordqty") = txtOrdQty.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckunt") = txtUM.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_discnt") = txtDiscount.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckitr") = txtPckItr.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_clmno") = txtRefClaim.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moq") = IIf(Trim(txtMOQ.Text) = "", 0, txtMOQ.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moa") = IIf(Trim(txtMOA.Text) = "", 0, txtMOA.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cussub") = strCusSub
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pjobno") = txtPJobNo.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_seccusitm") = txtSecCusItm.Text

            'Mark Lau 20070206
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorposnr") = ""
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorposnr") = ""

            'Mark Lau 20080611
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_custum") = IIf(cboCustUM.Text = "", "", cboCustUM.Text)

            'Mark Lau 20070622
            If chkPC.Checked = True Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_contopc") = "Y"
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pcprc") = CDbl(Me.txtPCPrc.Text)
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_contopc") = ""
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pcprc") = 0
            End If

            'Mark Lau 20081107
            'rs_SCORDDTL("sod_cusstyno").Value = IIf(txtCusstyno.Text = "", "", txtCusstyno.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusstyno") = IIf(cboCusStyNo.Text = "", "", cboCusStyNo.Text)

            ' Added by Mark Lau 20090205
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqunttyp") = txtMOQUnttyp.Text


            If txtConftr.Text = "" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr") = 1
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr") = txtConftr.Text
            End If

            If txtZTNVBELN.Text = "" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnvbeln") = ""
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnvbeln") = txtZTNVBELN.Text
            End If

            If txtZTNPOSNR.Text = "" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnposnr") = ""
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnposnr") = txtZTNPOSNR.Text
            End If

            If chkUpdatePO.Checked = True Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_updpo") = "Y"
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_updpo") = "N"
            End If

            If chkChgFty.Checked = True Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_chgfty") = "Y"
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_chgfty") = "N"
            End If

            If OptOnePrcY.Checked = True Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_oneprc") = "Y"
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_oneprc") = "N"
            End If

            '***********Vendor Price and Currency***********************

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde") = lblItmCstCur.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc") = txtTtlCst.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst") = txtItmCst.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst") = txtBOMCst.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt") = lblFtyUnt.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venitm") = lblVenItm.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckseq") = IIf(strPckSeq = "", "0", strPckSeq)

            'rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("imu_bcurcde") = lblBasprcCur.Text
            'rs_SCORDDTL("imu_basprc").value = txtItmBasprc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmprc") = IIf(txtItmPrc.Text.Length = 0, 0, txtItmPrc.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_basprc") = IIf(txtItmBasPrc.Text.Length = 0, 0, txtItmBasPrc.Text)

            'aabbcc
            ''Frankie Cheung 20100413 Add CIH Period
            'If Trim(txtPeriod.Text) <> "" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat") = txtPeriod.Text & "-01"
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat") = "1900-01-01"
            'End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat") = IIf(txtCIHPrd.Text = "", "1900-01-01", txtCIHPrd.Text & "-01")

            '2013-06-25 IM Period NOT USED ANYMORE
            'If Trim(txtIMPeriod.Text) <> "" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat") = txtIMPeriod.Text & "-01"
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat") = "1900-01-01"
            'End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat") = "1900-01-01"

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hrmcde") = cboHSTU.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_curcde") = lblSelprcCur.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_untprc") = txtUntPrc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_netuntprc") = txtNetUntPrc.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgunt") = IIf(strOrgSelPrc.Length = 0, 0, strOrgSelPrc)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgmoqchg") = OrgMOQChg

            '--- Remove Approve Flag for amend lower MOQ charge !!
            If txtMOQChg.Text < IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqchg")), 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqchg")) Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_apprve") = "N"
            End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqchg") = txtMOQChg.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_selprc") = txtSelprc.Text

            If txtDuty.Text.Length = 0 Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dtyrat") = 0
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dtyrat") = Format(CDbl(txtDuty.Text), "0.###")
            End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dept") = txtDept.Text

            If optEAN.Checked = True Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_typcode") = "E"
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_typcode") = "U"
            End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code1") = txtCdeMer.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code2") = txtCdeInr.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code3") = txtCdeCtn.Text

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cususdcur") = cboRetailUSDCur.Text
            If IsNumeric(txtRetailUSD.Text) = False Then
                txtRetailUSD.Text = 0
            End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cususd") = txtRetailUSD.Text

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscadcur") = cboRetailCADCur.Text
            If IsNumeric(txtRetailCAD.Text) = False Then
                txtRetailCAD.Text = 0
            End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscad") = txtRetailCAD.Text

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdin") = txtInnerLin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwin") = txtInnerWin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhin") = txtInnerHin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdin") = txtMasterLin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwin") = txtMasterWin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhin") = txtMasterHin
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdcm") = txtInnerLcm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwcm") = txtInnerWcm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhcm") = txtInnerHcm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdcm") = txtMasterLcm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwcm") = txtMasterWcm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhcm") = txtMasterHcm

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpstr") = Format(CDate(txtStartShip.Text), "MM/dd/yyyy")
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpend") = Format(CDate(txtEndShip.Text), "MM/dd/yyyy")
            'If txtCanDat.Text <> "  /  /" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat") = Format(CDate(txtCanDat.Text))
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat") = "  /  /"
            'End If

            If txtCanDat.Text <> "  /  /" And txtCanDat.Text <> "" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat") = Format(CDate(txtCanDat.Text))
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat") = ""
            End If

            'If txtPOStartShip.Text <> "  /  /" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr") = Format(CDate(txtPOStartShip.Text), "MM/dd/yyyy")
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr") = "01/01/1900"
            'End If
            'If txtPOEndShip.Text <> "  /  /" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend") = Format(CDate(txtPOEndShip.Text), "MM/dd/yyyy")
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend") = "01/01/1900"
            'End If
            'If txtPOCanDat.Text <> "  /  /" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan") = Format(CDate(txtPOCanDat.Text))
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan") = "01/01/1900"
            'End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr") = IIf(txtPOStartShip.Text = "  /  /", "", txtPOStartShip.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend") = IIf(txtPOEndShip.Text = "  /  /", "", txtPOEndShip.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan") = IIf(txtPOCanDat.Text = "  /  /", "", txtPOCanDat.Text)

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ctnstr") = txtStartCarton.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ctnend") = txtEndCarton.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ttlctn") = IIf(lblTotalCtn.Text.Length = 0, 0, lblTotalCtn.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_rmk") = txtDtlSCRmk.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pormk") = txtDtlPORmk.Text
            '***************Fill Vendor Information****************************
            'Call fillVenMrk(txtitmno.Text, rs_SCORDDTL("sod_pckunt").value, rs_SCORDDTL("sod_inrctn").value, rs_SCORDDTL("sod_mtrctn").value)
            '******************************************************************
            'rs_SCORDDTL("sod_subcde").value = Split(lblSubCode.Caption, "Sub-Code : ")(1)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_subcde") = strSubCde

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_alsitmno") = txtOldItem.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_alscolcde") = txtOldColor.Text

            '' Added by Mark Lau 20080825
            'If strDV <> "" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv") = strDV
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv") = ""
            'End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde") = lblDVItmCstCur.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftycst") = IIf(txtDVItmCst.Text = "", 0, txtDVItmCst.Text) 'IIf(strDVFtyCst = "", 0, strDVFtyCst)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyprc") = IIf(txtDVTtlCst.Text = "", 0, txtDVTtlCst.Text) 'IIf(strDVFtyPrc = "", 0, strDVFtyPrc)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvbomcst") = IIf(txtDVBOMCst.Text = "", 0, txtDVBOMCst.Text) 'IIf(strDVBOMCst = "", 0, strDVBOMCst)

            'rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur") = lblDVItmCstCur.Text
            'rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst") = IIf(txtDVItmCst.Text = "", 0, txtDVItmCst.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur") = lblDVItmCstCur.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst") = IIf(txtFtyCst.Text = "", 0, txtFtyCst.Text)

            'If strDVfcurcde <> "" Then
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde") = strDVfcurcde 'Split(Split(strCapDVFtyPrc, "TTL Cst  ")(1), " :")(0)
            'Else
            '    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde") = ""
            'End If

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt") = lblDVFtyUnt.Text

            If txtPrcGrp.Text = "STANDARD" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no") = ""
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") = ""
            Else
                If Split(txtPrcGrp.Text, " / ").Length = 1 Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no") = Split(txtPrcGrp.Text, " / ")(0)
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") = ""
                Else
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no") = Split(txtPrcGrp.Text, " / ")(0)
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") = Split(txtPrcGrp.Text, " / ")(1)
                End If
            End If
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprctrm") = FtyPrcTrm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hkprctrm") = HKPrcTrm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_trantrm") = TranTrm
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effcpo") = txtEffectiveCPO.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat") = IIf(txtEffDat.Text = "", "1900-01-01", txtEffDat.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat") = IIf(txtExpDat.Text = "", "1900-01-01", txtExpDat.Text)
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_prcgrp") = txtPrcGrp.Text

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_year") = txtYear.Text
            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_season") = cboSeason.Text

            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordno") = txtTentOrdno.Text
            If txtTentOrdSeq.Text = "" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordseq") = 0
            Else
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordseq") = txtTentOrdSeq.Text
            End If

            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" And _
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*DEL*~" And _
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*NEW*~" Then
                rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*UPD*~"
            End If

            'rs_SCORDDTL.Update()
            recordStatus_dtl = False

            '' -- Enable ReadOnly for all SCORDDTL Columns --
            'For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
            '    rs_SCORDDTL.Tables("RESULT").Columns(i).ReadOnly = True
            'Next
        End If
    End Sub

    Private Sub Cal_DtlPrcNetSelPrc(ByVal basprc As Double, ByVal Discount As Double, ByVal fml As String, ByVal ordqty As Long, ByVal MOQChg As Double)
        Dim netselprc As Double
        'netselprc = (basprc * (1 - val(Discount) / 100)) * (1 + val(MOQChg) / 100)
        netselprc = basprc * (1 + Val(MOQChg) / 100)

        txtNetUntPrc.Text = Format(roundup(netselprc), "######0.0000")
        txtNetUntPrc.Refresh()
    End Sub

    Private Sub Cal_DtlPrcSubTTl(ByVal basprc As Double, ByVal Discount As Double, ByVal fml As String, ByVal ordqty As Long)
        Dim selprc As Double
        'selprc = basprc * (1 - val(Discount) / 100) * (ordqty)
        selprc = basprc * (ordqty)

        'txtSelprc.Text = Format(roundup2(selprc), "######0.00")
        'Marco fix .0045 to .0049 rounding problem 20100909
        txtSelprc.Text = Format(selprc, "######0.00")

        txtSelprc.Refresh()
    End Sub

    Private Function roundup(ByVal Value As Double) As Double
        Dim tmp As String
        Dim tmpValue As Double

        tmpValue = Math.Round(Value, 5)
        tmp = CStr(Value)

        If InStr(tmp, ".") > 0 Then
            If tmp.Substring(tmp.Length - (tmp.Length - InStr(tmp, ".")), tmp.Length - InStr(tmp, ".")).Length > 4 Then
                Return (Math.Round(Math.Ceiling(Value * 10000)) / 10000)
            Else
                Return tmpValue
            End If
        Else
            Return tmpValue
        End If
    End Function

    Private Function roundup2(ByVal Value As Double) As Double
        Dim tmp As String
        Dim tmpValue As Double

        tmpValue = Math.Round(Value, 3)
        tmp = CStr(Value)

        If InStr(tmp, ".") > 0 Then
            If tmp.Substring(tmp.Length - (tmp.Length - InStr(tmp, ".")), tmp.Length - InStr(tmp, ".")).Length > 2 Then
                Return (Math.Round(Math.Ceiling(Value * 100)) / 100)
            Else
                Return tmpValue
            End If
        Else
            Return tmpValue
        End If
    End Function

    Private Sub Display_Dtl(ByVal typ As String)
        Dim sTemp As String
        Select Case typ
            Case "CUITMPRC"
                If chkReplacement.Checked = True Then
                    txtZTNVBELN.Visible = True
                    txtZTNPOSNR.Visible = True
                    txtTentOrdno.Visible = False
                    txtTentOrdSeq.Visible = False
                    txtZTNVBELN.BringToFront()
                    txtZTNPOSNR.BringToFront()
                Else
                    txtZTNVBELN.Visible = False
                    txtZTNPOSNR.Visible = False
                    txtTentOrdno.Visible = True
                    txtTentOrdSeq.Visible = True
                    txtTentOrdno.BringToFront()
                    txtTentOrdSeq.BringToFront()
                End If

                ' From CIH
                If rs_CUITMPRC.Tables("RESULT").Rows.Count = 0 Then
                    Exit Sub
                End If
                '--- Reassign the MOQ Charge ----
                If rs_CUITMPRC.Tables("RESULT").Rows(0)("cis_tirtyp") = 1 Then
                    Tier_typ = True
                Else
                    Tier_typ = False
                End If

                txtOrdQty.Enabled = True
                If authUsr = True Then
                    txtDiscount.Enabled = True
                Else
                    txtDiscount.Enabled = False
                End If

                If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_latest") = "N" Then
                    MsgBox("CIH price is not the most recent record", MsgBoxStyle.Information, "SCM00001 - CIH Warning")
                End If

                txtItmStatus.Text = IIf(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_itmsts") = "N/A", rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("h_ibi_itmsts"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_itmsts"))

                txtItmDsc.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_itmdsc")

                txtCustColCde.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cuscol")
                txtColDsc.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_coldsc")
                txtPckItr.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_pckitr")
                txtRefDoc.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_refdoc")
                txtRefdat.Text = Format(CDate(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_docdat")), "MM/dd/yyyy")
                txtCustItmno.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cusitm")
                display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_season"), cboSeason)
                txtYear.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_year")
                'cboSeason.Enabled = False
                If cboSeason.Text <> rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_season") Then
                    MsgBox("Season cannot be found in system", , "SCM00001 - Loading Error")
                    cboSeason.Items.Add(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_season"))
                    display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_season"), cboSeason)
                End If
                txtSKUNo.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cussku")
                '*************Carlos Lui added on 20120920**************
                If bIsCopy = False Then
                    '*************Carlos Lui added on 20120920**************
                    txtOrdQty.Text = ""
                    txtPC.Text = ""
                    '*************Carlos Lui added on 20120920**************
                End If
                '*************Carlos Lui added on 20120920**************
                txtUM.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde")

                'Frankie Cheung 20100413 Add Period
                'txtPeriod.Text = CStr(year(rs_CUITMPRC("cis_qutdat"))) + "-" + Right("00" + CStr(month(rs_CUITMPRC("cis_qutdat"))), 2)

                txtTentOrdno.Text = ""
                txtTentOrdSeq.Text = ""

                ' Added by Mark Lau 20081107
                'txtCusstyno.Text = rs_CUITMPRC("cis_cusstyno").Value
                GetCusSty(Trim(txtItmno.Text))
                If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cusstyno") <> "" Then
                    cboCusStyNo.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cusstyno")
                End If


                'Added by Mark Lau 20070621
                If isABUAssortment(txtItmno.Text) = True Then
                    txtConftr.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_conftr")
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cocde") = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_contopc")
                    If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_contopc") = "Y" Then
                        If authUsr = False Then
                            chkPC.Enabled = True
                            chkPC.Checked = True
                            chkPC.Enabled = False
                        Else
                            chkPC.Checked = True
                        End If
                    Else
                        If authUsr = False Then
                            chkPC.Enabled = True
                            chkPC.Checked = False
                            chkPC.Enabled = False
                        Else
                            chkPC.Checked = False
                        End If
                    End If
                    ABUASSORT("SHOW")
                Else
                    chkPC.Checked = False
                    ABUASSORT("HIDE")
                End If

                '***Default set as N****
                OptOnePrcN.Checked = True
                '***********************

                '*** BOM Button Default set as false ***
                'cmdBOM.Enabled = False
                '***************************************

                lblColPckType.Text = strColPck & IIf(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_typ") = "N/A", rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("h_ibi_typ"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_typ"))

                '**************Enable or Disable Ass Button*********************
                If Trim(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_typ")) = "ASS" Then
                    cmdAss.Enabled = True
                Else
                    cmdAss.Enabled = False
                End If
                '***************************************************************

                '**************Enable or Disable BOM Button*********************
                Dim drBOM() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = '" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "'")
                If drBOM.Length > 0 Then
                    cmdBOM.Enabled = True
                Else
                    cmdBOM.Enabled = False
                End If
                '***************************************************************

                Dim drCust_P As DataRow() = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")
                '****************Cal Item Basic Price*************************************************
                If rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_itmsts") = "N/A" Then
                    SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("h_imu_bcurcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("h_imu_basprc"), "IM")
                Else
                    If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_minprc") > 0 And rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_minprc") <> rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_basprc") Then
                        ' Determine Basic Price
                        SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_basprc"), "IM")
                        txtItmBasPrc.Text = txtItmPrc.Text
                        ' Determine Mininum Price
                        lblBasprc.Text = "Min MU Prc."
                        SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_minprc"), "IM")
                    Else
                        lblBasprc.Text = "Basic Price"
                        SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_basprc"), "IM")
                        txtItmBasPrc.Text = txtItmPrc.Text
                    End If
                    'SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_basprc"), "IM")
                End If
                '*************************************************************************************

                '***************Cal CUITMSUM Selprc and untprc**************************
                SalRate(drCust_P(0).Item("cpi_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_curcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_selprc"), "SC")
                'SalRate(drCust_P(0).Item("cpi_curcde"), "USD", rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_selprc"), "SC")
                '***********************************************************************

                cboHSTU.Text = ""
                cboHSTU.Items.Clear()
                cboHSTU.Items.Add(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_hrmcde"))

                If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_hrmcde") <> "" Then
                    display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_hrmcde"), cboHSTU)
                Else
                    cboHSTU.SelectedIndex = -1
                End If

                txtDuty.Text = Format(CDbl(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_dtyrat")), "0.###")
                txtDept.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_dept")

                If rs_CUITMPRC.Tables("RESULT").Rows(0)("cis_typcode") = "E" Then
                    optEAN.Checked = True
                Else
                    optUPC.Checked = True
                End If

                txtCdeMer.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_code1")
                txtCdeInr.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_code2")
                txtCdeCtn.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_code3")

                display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cususdcur"), cboRetailUSDCur)
                txtRetailUSD.Text = Format(CDbl(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cususd")), "0.####")
                display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cuscadcur"), cboRetailCADCur)
                txtRetailCAD.Text = Format(CDbl(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cuscad")), "0.####")

                txtInnerLin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrdin")
                txtInnerWin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrwin")
                txtInnerHin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrhin")
                txtMasterLin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrdin")
                txtMasterWin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrwin")
                txtMasterHin = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrhin")
                txtInnerLcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrdcm")
                txtInnerWcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrwcm")
                txtInnerHcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrhcm")
                txtMasterLcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrdcm")
                txtMasterWcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrwcm")
                txtMasterHcm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrhcm")

                ' Input Alias Old Item / Color when necessary
                If isNewItemFormat(Me.txtItmno.Text) Then
                    Me.txtOldItem.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_alsitmno")
                    Me.txtOldColor.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ibi_alscolcde")
                Else
                    Me.txtOldItem.Text = ""
                    Me.txtOldColor.Text = ""
                End If
                '--------------------

                txtStartCarton.Text = 0
                txtEndCarton.Text = 0
                lblTotalCtn.Text = ""
                txtDtlSCRmk.Text = ""
                txtDtlPORmk.Text = ""

                txtEffectiveCPO.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_effcpo")
                txtEffDat.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_effdat"), "MM/dd/yyyy")
                txtExpDat.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_expdat"), "MM/dd/yyyy")
                txtCIHPrd.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_qutdat"), "yyyy-MM")
                If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus1no") <> "" Then
                    txtPrcGrp.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus1no")
                    If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus2no") <> "" Then
                        txtPrcGrp.Text = txtPrcGrp.Text & " / " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus2no")
                    End If
                Else
                    txtPrcGrp.Text = "STANDARD"
                End If

                txtMOQ.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_moq")
                txtMOQUnttyp.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_moqunttyp")
                txtMOA.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_moa"), "#0.0000")



                '***********Carlos Lui added on 20120706**********

                sTemp = ""

                If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus1no") <> "" Then
                    sTemp = sTemp & "Pri Customer:   " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus1no")
                    If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus2no") <> "" Then
                        sTemp = sTemp & "," & Environment.NewLine & "Sec Customer:   " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus2no")
                    End If
                Else
                    sTemp = sTemp & "Customers:      " & "Standard"
                End If

                imu_key.Text = sTemp & Environment.NewLine & _
                               "HK Price Term:  " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_hkprctrm") & Environment.NewLine & _
                               "Fty Price Term: " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprctrm") & Environment.NewLine & _
                               "Transport Term: " & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_trantrm") & Environment.NewLine & _
                               "Effect Date:    " & Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_effdat"), "MM/dd/yyyy") & Environment.NewLine & _
                               "Expiry Date:    " & Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_expdat"), "MM/dd/yyyy")

                If Trim(imu_key.Text) = "" Then
                    sImu_cus1no = ""
                    sImu_cus2no = ""
                    sImu_hkprctrm = ""
                    sImu_ftyprctrm = ""
                    sImu_trantrm = ""
                    dImu_effdat = "01/01/1900"
                    dImu_expdat = "01/01/1900"
                Else
                    sImu_cus1no = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus1no")
                    sImu_cus2no = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_cus2no")
                    sImu_hkprctrm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_hkprctrm")
                    sImu_ftyprctrm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprctrm")
                    sImu_trantrm = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_trantrm")
                    dImu_effdat = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_effdat"), "MM/dd/yyyy")
                    dImu_expdat = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_expdat"), "MM/dd/yyyy")
                End If
                '***********Carlos Lui added on 20120706**********

                '***************Fill Vendor Information****************************

                ' fillVenMrk(txtItmno.Text, rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrqty"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrqty"))
                ' fillCusVen(txtItmno.Text)
                fillVendorPrices("CUITMPRC")
                '******************************************************************

                'Frankie Cheung 20100413 Add Period
                Dim tempM As String = "00" + CStr(Month(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_qutdat")))
                txtPeriod.Text = CStr(Year(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_qutdat"))) & "-" & tempM.Substring(tempM.Length - 2, 2)

                chkDelDtl.Checked = False

                recordStatus_dtl = True

                '**************************************************************************
                '*********************END CUITMSUM*****************************************
                '**************************************************************************

            Case "SCORDDTL"
                '**************************************************************************
                '*********************SCORDDTL*********************************************
                '**************************************************************************

                Try
                    If chkReplacement.Checked = True Then
                        txtZTNVBELN.Visible = True
                        txtZTNPOSNR.Visible = True
                        txtTentOrdno.Visible = False
                        txtTentOrdSeq.Visible = False
                        txtZTNVBELN.BringToFront()
                        txtZTNPOSNR.BringToFront()
                    Else
                        txtZTNVBELN.Visible = False
                        txtZTNPOSNR.Visible = False
                        txtTentOrdno.Visible = True
                        txtTentOrdSeq.Visible = True
                        txtTentOrdno.BringToFront()
                        txtTentOrdSeq.BringToFront()
                    End If

                    'Mark Lau 20070206
                    Me.txtZTNVBELN.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnvbeln").ToString
                    Me.txtZTNPOSNR.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ztnposnr").ToString

                    Me.txtZORVBELN.Text = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorvbeln")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorvbeln"))
                    Me.txtZORPOSNR.Text = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorposnr")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_zorposnr"))

                    Me.txtZORVBELN.Enabled = True
                    Me.txtZORVBELN.ReadOnly = True
                    Me.txtZORPOSNR.Enabled = True
                    Me.txtZORPOSNR.ReadOnly = True

                    'Mark Lau 20080611
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_custum").ToString <> "" Then
                        Me.cboCustUM.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_custum")
                    Else
                        Me.cboCustUM.SelectedIndex = 0
                    End If

                    'Added by Mark Lau 20070622
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_contopc").ToString = "Y" Then
                        If authUsr = False Then
                            chkPC.Enabled = True
                            chkPC.Checked = True
                            chkPC.Enabled = False
                        Else
                            chkPC.Checked = True
                        End If
                    Else
                        If authUsr = False Then
                            chkPC.Enabled = True
                            chkPC.Checked = False
                            chkPC.Enabled = False
                        Else
                            chkPC.Checked = False
                        End If
                    End If

                    '' Added by Mark Lau 20090205
                    'txtMOQUnttyp.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqunttyp").ToString

                    'If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr").ToString <> "" Then
                    '    txtConftr.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr")
                    'Else
                    '    txtConftr.Text = ""
                    'End If

                    If isABUAssortment(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmno").ToString) = True Then
                        ABUASSORT("SHOW")
                    Else
                        ABUASSORT("HIDE")
                    End If

                    lblDtlSeq.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq").ToString
                    assItmCount = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount").ToString)
                    txtItmno.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmno").ToString
                    txtItmStatus.Text = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("ibi_itmsts").ToString = "N/A", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("h_ibi_itmsts"), rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("ibi_itmsts").ToString)
                    txtItmDsc.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmdsc").ToString
                    txtPckItr.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckitr").ToString
                    txtJobNo.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("pod_jobord").ToString
                    txtRunNo.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_runno").ToString
                    txtPJobNo.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pjobno").ToString
                    txtSecCusItm.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_seccusitm").ToString
                    strCusSub = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cussub").ToString

                    cboColPckInfo.Items.Clear()
                    cboColPckInfo.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_colpck"))
                    display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_colpck"), cboColPckInfo)

                    txtCustColCde.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscol").ToString

                    txtColDsc.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_coldsc").ToString
                    txtRefDoc.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutno").ToString
                    txtRefdat.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_refdat")), "MM/dd/yyyy")
                    txtCustItmno.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusitm").ToString
                    txtSKUNo.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cussku").ToString
                    txtCustPODtl.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuspo").ToString
                    txtRespPODtl.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_resppo").ToString
                    txtUM.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckunt").ToString

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordno").ToString = "" Then
                        txtTentOrdno.Text = ""
                        txtTentOrdSeq.Text = ""
                    Else
                        txtTentOrdno.Enabled = False
                        txtTentOrdno.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordno").ToString
                        txtTentOrdSeq.Enabled = False
                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordseq").ToString = "0" Then
                            txtTentOrdSeq.Text = ""
                        Else
                            txtTentOrdSeq.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tordseq").ToString
                        End If
                    End If

                    txtYear.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_year").ToString
                    display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_season").ToString, cboSeason)
                    If cboSeason.Text <> rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_season").ToString Then
                        MsgBox("Season cannot be found in system", , "SCM00001 - Loading Error")
                        cboSeason.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_season").ToString)
                        display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_season").ToString, cboSeason)
                    End If


                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_oneprc").ToString = "Y" Then
                        OptOnePrcY.Checked = True
                    Else
                        OptOnePrcN.Checked = True
                    End If

                    lblColPckType.Text = strColPck & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmtyp")

                    '**************Enable or Disable BOM Button*********************
                    ' *** Rewritten by David Yue 2012-10-08
                    'rs_SCBOMINF.Filter = "sbi_ordseq = " & "'" & rs_SCORDDTL("sod_ordseq").Value & "'"
                    'If rs_SCBOMINF.recordCount > 0 Then
                    '    cmdBOM.Enabled = True
                    'Else
                    '    cmdBOM.Enabled = False
                    'End If
                    Dim drBOM() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = '" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "'")
                    If drBOM.Length > 0 Then
                        cmdBOM.Enabled = True
                    Else
                        cmdBOM.Enabled = False
                    End If
                    '***************************************************************

                    '**************Enable or Disable Ass Button*********************
                    If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmtyp").ToString) = "ASS" Then
                        cmdAss.Enabled = True
                    Else
                        cmdAss.Enabled = False
                    End If
                    '***************************************************************

                    '**************Enable or Disable Original SC Cost Button*********************
                    If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                        cmdOrgScCst.Enabled = True
                    Else
                        cmdOrgScCst.Enabled = False
                    End If
                    '***************************************************************

                    cboHSTU.Text = ""
                    cboHSTU.Items.Clear()
                    cboHSTU.Items.Add(IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hrmcde")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hrmcde")))
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hrmcde").ToString <> "" Then
                        display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hrmcde"), cboHSTU)
                    Else
                        cboHSTU.SelectedIndex = -1
                    End If

                    txtDuty.Text = Format(CDbl(IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dtyrat").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dtyrat"))), "0.###")
                    txtDept.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dept").ToString
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_typcode").ToString = "E" Then
                        optEAN.Checked = True
                    Else
                        optUPC.Checked = True
                    End If

                    txtCdeMer.Text = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code1")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code1"))
                    txtCdeInr.Text = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code2")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code2"))
                    txtCdeCtn.Text = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code3")), "", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_code3"))

                    'display_combo(rs_SCORDDTL.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("sod_cususdcur").ToString, cboRetailUSDCur)
                    'display_combo(rs_SCORDDTL.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("sod_cuscadcur").ToString, cboRetailCADCur)
                    display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cususdcur").ToString, cboRetailUSDCur)
                    display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscadcur").ToString, cboRetailCADCur)

                    'txtRetailUSD.Text = Format(CDbl(rs_SCORDDTL.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("sod_cususd")), "0.####")
                    'txtRetailCAD.Text = Format(CDbl(rs_SCORDDTL.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("sod_cuscad")), "0.####")

                    txtRetailUSD.Text = Format(CDbl(IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cususd").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cususd"))), "0.####")
                    txtRetailCAD.Text = Format(CDbl(IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscad").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cuscad"))), "0.####")

                    txtInnerLin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdin"))
                    txtInnerWin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwin"))
                    txtInnerHin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhin"))
                    txtMasterLin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdin"))
                    txtMasterWin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwin"))
                    txtMasterHin = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhin").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhin"))
                    txtInnerLcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrdcm"))
                    txtInnerWcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrwcm"))
                    txtInnerHcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrhcm"))
                    txtMasterLcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrdcm"))
                    txtMasterWcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrwcm"))
                    txtMasterHcm = IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhcm").ToString = "", 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrhcm"))

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpstr").ToString = "" Then
                        txtStartShip.Text = "  /  /"
                    Else
                        txtStartShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpstr")), "MM/dd/yyyy")
                    End If

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpend").ToString = "" Then
                        txtEndShip.Text = "  /  /"
                    Else
                        txtEndShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpend")), "MM/dd/yyyy")
                    End If


                    'If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat").ToString) = "/  /" Then
                    '    txtCanDat.Text = "  /  /"
                    'Else
                    '    txtCanDat.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat")), "MM/dd/yyyy")
                    'End If

                    'If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr").ToString) = "/  /" Then
                    '    txtPOStartShip.Text = "  /  /"
                    'ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                    '    txtPOStartShip.Text = "  /  /"
                    'Else
                    '    txtPOStartShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr")), "MM/dd/yyyy")
                    'End If

                    'If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend").ToString) = "/  /" Then
                    '    txtPOEndShip.Text = "  /  /"
                    'ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                    '    txtPOEndShip.Text = "  /  /"
                    'Else
                    '    txtPOEndShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend")), "MM/dd/yyyy")
                    'End If

                    'If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan").ToString) = "/  /" Then
                    '    txtPOCanDat.Text = "  /  /"
                    'ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                    '    txtPOCanDat.Text = "  /  /"
                    'Else
                    '    txtPOCanDat.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan")), "MM/dd/yyyy")
                    'End If

                    If (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat").ToString) = "/  /") Or _
                       (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat").ToString) = "") Then
                        txtCanDat.Text = ""
                    Else
                        txtCanDat.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_candat")), "MM/dd/yyyy")
                    End If

                    If (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr").ToString) = "/  /") Or _
                       (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr").ToString) = "") Then
                        txtPOStartShip.Text = ""
                    ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                        txtPOStartShip.Text = ""
                    Else
                        txtPOStartShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posstr")), "MM/dd/yyyy")
                    End If

                    If (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend").ToString) = "/  /") Or _
                       (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend").ToString) = "") Then
                        txtPOEndShip.Text = ""
                    ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                        txtPOEndShip.Text = ""
                    Else
                        txtPOEndShip.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_posend")), "MM/dd/yyyy")
                    End If

                    If (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan").ToString) = "/  /") Or _
                       (Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan").ToString) = "") Then
                        txtPOCanDat.Text = ""
                    ElseIf Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan")), "MM/dd/yyyy") = CDate("01/01/1900") Then
                        txtPOCanDat.Text = ""
                    Else
                        txtPOCanDat.Text = Format(CDate(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_poscan")), "MM/dd/yyyy")
                    End If

                    txtStartCarton.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ctnstr").ToString
                    txtEndCarton.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ctnend").ToString
                    txtRefClaim.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_clmno").ToString
                    txtDtlSCRmk.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_rmk").ToString
                    txtDtlPORmk.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pormk").ToString
                    If IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tirtyp")), "0", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tirtyp")) = "0" Then
                        Tier_typ = False
                    Else
                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tirtyp") = "1" Then
                            Tier_typ = True
                        Else
                            Tier_typ = False
                        End If
                    End If

                    If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And chkCloseOut.Checked = False Then
                        '***************Fill Vendor Information****************************
                        '***********Carlos Lui added on 20120706**********

                        sTemp = ""

                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no").ToString <> "" Then
                            sTemp = sTemp & "Pri Customer:   " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") <> "" Then
                                sTemp = sTemp & "," & vbCrLf & "Sec Customer:   " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                            End If
                        Else
                            sTemp = sTemp & "Customers:      " & "Standard"
                        End If

                        'imu_key.Text = sTemp & Environment.NewLine & _
                        '               "HK Price Term:  " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hkprctrm") & Environment.NewLine & _
                        '               "Fty Price Term: " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprctrm") & Environment.NewLine & _
                        '               "Transport Term: " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_trantrm") & Environment.NewLine & _
                        '               "Effect Date:    " & Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy") & Environment.NewLine & _
                        '               "Expiry Date:    " & Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")

                        'If Trim(imu_key.Text) = "" Then
                        '    sImu_cus1no = ""
                        '    sImu_cus2no = ""
                        '    sImu_hkprctrm = ""
                        '    sImu_ftyprctrm = ""
                        '    sImu_trantrm = ""
                        '    dImu_effdat = "01/01/1900"
                        '    dImu_expdat = "01/01/1900"
                        'Else
                        '    sImu_cus1no = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                        '    sImu_cus2no = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                        '    sImu_hkprctrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hkprctrm")
                        '    sImu_ftyprctrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprctrm")
                        '    sImu_trantrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_trantrm")
                        '    dImu_effdat = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy")
                        '    dImu_expdat = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")
                        'End If

                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no").ToString <> "" Then
                            txtPrcGrp.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") <> "" Then
                                txtPrcGrp.Text = txtPrcGrp.Text & " / " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                            End If
                        Else
                            txtPrcGrp.Text = "STANDARD"
                        End If

                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat").ToString = "" Then
                            txtEffDat.Text = ""
                        Else
                            txtEffDat.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy")
                        End If

                        txtEffectiveCPO.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effcpo")
                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat").ToString = "" Then
                            txtExpDat.Text = ""
                        Else
                            txtExpDat.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")
                        End If

                        txtCIHPrd.Text = "" 'rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")

                        'fillVenMrk(txtItmno.Text, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pckunt"), rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_inrctn"), rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_mtrctn"))
                        If cboPrdVen.FindString(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno").ToString) = -1 Then
                            cboPrdVen.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno").ToString & " - " & "Not exist in Item Master")
                            display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno"), cboPrdVen)
                        Else
                            display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno"), cboPrdVen)
                        End If
                        '******************************************************************
                        ' fillCusVen(txtItmno.Text)

                        fillVendorList(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmno"))
                        fillVendorPrices("SCORDDTL")

                    Else
                        Dim vn As DataSet
                        gspStr = "sp_select_VNBASINF '','" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv") & "'"
                        rtnLong = execute_SQLStatement(gspStr, vn, rtnStr)

                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SCM00001 #021 sp_select_VNBASINF : " & rtnStr)
                            Exit Sub
                        Else
                            If vn.Tables("RESULT").Rows.Count > 0 Then
                                txtVenno.Text = vn.Tables("RESULT").Rows(0)("vbi_venno") & " - " & vn.Tables("RESULT").Rows(0)("vbi_vensna")
                            Else
                                txtVenno.Text = ""
                            End If
                        End If

                        cboPrdVen.Items.Clear()
                        cboPrdVen.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pvname"))
                        cboPrdVen.SelectedIndex = 0
                        cboCusVen.Items.Clear()
                        cboCusVen.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cvname"))
                        cboCusVen.SelectedIndex = 0
                        cboTradeVen.Items.Clear()
                        cboTradeVen.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tvname"))
                        cboTradeVen.SelectedIndex = 0
                        cboExamVen.Items.Clear()
                        cboExamVen.Items.Add(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_evname"))
                        cboExamVen.SelectedIndex = 0

                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no") <> "" Then
                            txtPrcGrp.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") <> "" Then
                                txtPrcGrp.Text = txtPrcGrp.Text & " / " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                            End If
                        Else
                            txtPrcGrp.Text = "STANDARD"
                        End If
                        txtEffDat.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy")
                        txtExpDat.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")

                        If vn.Tables("RESULT").Rows.Count > 0 Then
                            If vn.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
                                lblDVItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                                txtDVItmCst.Text = "9999.0000"
                                txtDVBOMCst.Text = "9999.0000"
                                txtDVTtlCst.Text = "9999.0000"
                                lblDVFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")

                                lblFtyCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur")
                                txtFtyCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst")

                                lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                                txtItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst")
                                txtBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst")
                                txtTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc")
                                lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")

                                If gsFlgCstExt = "1" Then
                                    'setDtlStatus("Cost")
                                    setDtlStatus("NoDVCost")
                                Else
                                    setDtlStatus("NoCost")
                                End If
                            Else
                                lblDVItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                                txtDVItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftycst")
                                txtDVBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvbomcst")
                                txtDVTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyprc")
                                lblDVFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")

                                lblFtyCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur")
                                txtFtyCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst")

                                lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                                txtItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst")
                                txtBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst")
                                txtTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc")
                                lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")

                                If gsFlgCstExt = "1" Then
                                    setDtlStatus("Cost")
                                Else
                                    setDtlStatus("NoCost")
                                End If
                            End If
                        Else
                            lblDVItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                            txtDVItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftycst")
                            txtDVBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvbomcst")
                            txtDVTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyprc")
                            lblDVFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")

                            lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                            txtItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst")
                            txtBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst")
                            txtTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc")
                            lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")

                            If gsFlgCstExt = "1" Then
                                setDtlStatus("Cost")
                            Else
                                setDtlStatus("NoCost")
                            End If
                        End If
                    End If


                    'lblSubCode.Caption = "Sub-Code : " & rs_SCORDDTL("sod_subcde").value
                    If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_subcde").ToString) <> "" Then
                        strSubCde = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_subcde")
                    Else
                        strSubCde = ""
                    End If

                    lblVenItm.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venitm")

                    ''lblTtlCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                    'lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                    ''lblBOMCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                    'lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")
                    'txtItmCst.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst"), "#0.0000")
                    'txtBOMCst.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst"), "#0.0000")
                    'txtTtlCst.Text = Format(Int(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc") * 10000 + 0.00000001) / 10000, "#0.0000")


                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr").ToString <> "" Then
                        txtConftr.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr")
                    Else
                        txtConftr.Text = ""
                    End If

                    txtMOQ.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moq")
                    txtMOQUnttyp.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqunttyp").ToString
                    txtMOA.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moa"), "#0.0000")
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_updpo") = "Y" Then
                        chkUpdatePO.Checked = True
                    Else
                        chkUpdatePO.Checked = False
                    End If

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_chgfty") = "Y" Then
                        chkChgFty.Checked = True
                    Else
                        chkChgFty.Checked = False
                    End If

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*DEL*~" Or _
                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*NEW*~" Then
                        chkDelDtl.Checked = True
                    Else
                        chkDelDtl.Checked = False
                    End If

                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmprc") = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_basprc") Then
                        lblBasprc.Text = "Basic Price"
                    Else
                        lblBasprc.Text = "Min MU Price"
                    End If
                    txtItmPrc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmprc"), "######0.0000")
                    txtItmBasPrc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_basprc"), "######0.0000")

                    txtPC.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordqty") * rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_conftr")
                    txtOrdQty.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordqty")
                    txtDiscount.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_discnt")
                    txtMOQChg.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_moqchg")
                    OrgMOQChg = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgmoqchg")
                    If Val(txtMOQChg.Text) > 0 And cboSCStatus.Text.Substring(0, 3) <> "REL" And cboSCStatus.Text.Substring(0, 3) <> "CLO" Then
                        txtMOQChg.Enabled = True
                    Else
                        txtMOQChg.Enabled = False
                    End If
                    txtShipped.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_shpqty")
                    txtUntPrc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_untprc"), "######0.0000")
                    txtPCPrc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_pcprc"), "######0.0000")  'Lester Wu 2007-06-28
                    txtNetUntPrc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_netuntprc"), "######0.0000")

                    txtSelprc.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_selprc"), "######0.00")
                    strOrgSelPrc = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgunt"), "0.0000")
                    If chkPC.Checked = True And IsNumeric(Me.txtConftr.Text) Then
                        strorgpcprc = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgunt") / CInt(Me.txtConftr.Text), "#0.0000")
                    Else
                        strorgpcprc = ""
                    End If
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_apprve") = "Y" Then
                        lblApproved.Visible = True
                    Else
                        lblApproved.Visible = False
                    End If
                    lblTotalCtn.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ttlctn")
                    'Lester Wu 2006-09-23
                    Me.txtOldItem.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_alsitmno")
                    Me.txtOldColor.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_alscolcde")


                    ' Added by Mark Lau 20080825
                    'ClearDVTtlCst()
                    'strDV = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv")
                    'strDVItmCst = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftycst")
                    'strDVTtlCst = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyprc")
                    'strDVBOMCst = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvbomcst")
                    'strDVfcurcde = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                    'strDVftyunt = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")

                    'strDVTtlCstCur = strDVfcurcde
                    'strDVItmCstCur = strDVfcurcde
                    'strDVBOMCstCur = strDVfcurcde  

                    ''Frankie Cheung 20100414 Add CIH Period
                    'If CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat"))) <> "1900" Then
                    '    Dim tempMth As String = "00" & CStr(Month(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat")))
                    '    txtPeriod.Text = CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat"))) & "-" & tempMth.Substring(tempMth.Length - 2, 2)
                    'Else
                    '    txtPeriod.Text = ""
                    'End If

                    If CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat"))) <> "1900" Then
                        Dim tempMth As String = "00" & CStr(Month(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat")))
                        txtCIHPrd.Text = CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_qutdat"))) & "-" & tempMth.Substring(tempMth.Length - 2, 2)
                    Else
                        txtCIHPrd.Text = ""
                    End If

                    ''Frankie Cheung 20100809 Add IM Period
                    'If CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat"))) <> "1900" Then
                    '    txtIMPeriod.Text = CStr(Year(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat"))) + "-" + Microsoft.VisualBasic.Right("00" + CStr(Month(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdat"))), 2)
                    'Else
                    '    txtIMPeriod.Text = ""
                    'End If


                    'SetDVTtlCst()

                    ' Added by Mark Lau 20081107
                    'txtCusstyno.Text = rs_SCORDDTL("sod_cusstyno").Value
                    GetCusSty(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmno"))
                    If Trim(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusstyno")) <> "" Then
                        cboCusStyNo.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusstyno")
                    End If

                    '***********Carlos Lui added 20120706**********

                    'sTemp = ""

                    'If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no") <> "" Then
                    '    sTemp = sTemp & "Pri Customer:   " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                    '    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no") <> "" Then
                    '        sTemp = sTemp & "," & vbCrLf & "Sec Customer:   " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                    '    End If
                    'Else
                    '    sTemp = sTemp & "Customers:      " & "Standard"
                    'End If

                    'imu_key.Text = sTemp & Environment.NewLine & _
                    '               "HK Price Term:  " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hkprctrm") & Environment.NewLine & _
                    '               "Fty Price Term: " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprctrm") & Environment.NewLine & _
                    '               "Transport Term: " & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_trantrm") & Environment.NewLine & _
                    '               "Effect Date:    " & Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy") & Environment.NewLine & _
                    '               "Expiry Date:    " & Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")

                    'If Trim(imu_key.Text) = "" Then
                    '    sImu_cus1no = ""
                    '    sImu_cus2no = ""
                    '    sImu_hkprctrm = ""
                    '    sImu_ftyprctrm = ""
                    '    sImu_trantrm = ""
                    '    dImu_effdat = "01/01/1900"
                    '    dImu_expdat = "01/01/1900"
                    'Else
                    '    sImu_cus1no = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus1no")
                    '    sImu_cus2no = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cus2no")
                    '    sImu_hkprctrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_hkprctrm")
                    '    sImu_ftyprctrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprctrm")
                    '    sImu_trantrm = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_trantrm")
                    '    dImu_effdat = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_effdat"), "MM/dd/yyyy")
                    '    dImu_expdat = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_expdat"), "MM/dd/yyyy")
                    'End If
                    '***********Carlos Lui added 20120706**********
                Catch ex As Exception
                    If chkDelDtl.Checked = False Then
                        MsgBox("An Error has occured during Display_Dtl" & Environment.NewLine & ex.ToString, MsgBoxStyle.Critical, "SCM00001 - Display Detail")
                    End If
                End Try
                'recordStatus_dtl = False
                '**************************************************************************
                '*********************END SCORDDTL*****************************************
                '**************************************************************************

            Case "INIT"

                txtItmStatus.Text = ""
                txtItmDsc.Text = ""
                txtNetUntPrc.Text = ""
                cboColPckInfo.Items.Clear()

                txtCustColCde.Text = ""
                txtColDsc.Text = ""
                txtRefDoc.Text = ""
                txtRefdat.Text = Format(Date.Now, "MM/dd/yyyy")
                txtCustItmno.Text = ""
                txtSKUNo.Text = ""
                txtYear.Text = ""
                cboSeason.Text = ""
                txtCustPODtl.Text = ""
                txtRespPODtl.Text = ""
                txtOrdQty.Text = ""
                txtPC.Text = ""
                txtShipped.Text = ""
                txtJobNo.Text = ""
                txtRunNo.Text = ""
                txtPJobNo.Text = ""
                txtSecCusItm.Text = ""
                strCusSub = ""

                txtZTNVBELN.Enabled = False
                txtZTNVBELN.Text = ""
                txtZTNPOSNR.Enabled = False
                txtZTNPOSNR.Text = ""
                txtTentOrdno.Enabled = False
                txtTentOrdno.Text = ""
                txtTentOrdSeq.Enabled = False
                txtTentOrdSeq.Text = ""

                txtUM.Text = ""
                txtDiscount.Text = 0
                assItmCount = 0
                txtPckItr.Text = ""
                lblColPckType.Text = strColPck
                txtItmPrc.Text = ""
                txtItmBasPrc.Text = ""
                txtSelprc.Text = ""
                txtUntPrc.Text = ""
                strOrgSelPrc = ""
                strorgpcprc = ""
                cboHSTU.Text = ""
                txtDuty.Text = ""
                txtDept.Text = ""
                optEAN.Checked = True
                txtEffectiveCPO.Text = ""
                txtEffDat.Text = ""
                txtExpDat.Text = ""
                txtCIHPrd.Text = ""
                txtPrcGrp.Text = ""

                txtCdeMer.Text = ""
                txtCdeInr.Text = ""
                txtCdeCtn.Text = ""

                'cboRetailUSDCur.Items.Clear()
                cboRetailUSDCur.SelectedIndex = -1
                txtRetailUSD.Text = ""
                'cboRetailCADCur.Items.Clear()
                cboRetailCADCur.SelectedIndex = -1
                txtRetailCAD.Text = ""

                txtInnerLin = 0
                txtInnerWin = 0
                txtInnerHin = 0
                txtMasterLin = 0
                txtMasterWin = 0
                txtMasterHin = 0
                txtInnerLcm = 0
                txtInnerWcm = 0
                txtInnerHcm = 0
                txtMasterLcm = 0
                txtMasterWcm = 0
                txtMasterHcm = 0

                txtStartShip.Text = Format(Date.Now, "MM/dd/yyyy")
                txtEndShip.Text = Format(Date.Now, "MM/dd/yyyy")
                txtCanDat.Text = Format(Date.Now, "MM/dd/yyyy")

                txtPOStartShip.Text = "  /  /"
                txtPOEndShip.Text = "  /  /"
                txtPOCanDat.Text = "  /  /"

                txtDtlPORmk.Text = ""

                txtStartCarton.Text = 0
                txtEndCarton.Text = 0
                cmdAss.Enabled = False
                cmdBOM.Enabled = False
                txtVenno.Text = ""
                cboPrdVen.Items.Clear()
                cboCusVen.Items.Clear()
                cboTradeVen.Items.Clear()
                cboExamVen.Items.Clear()
                'Lester wu 2006-09-23
                'lblSubCode.Caption = "Sub-Code : "
                lblVenItm.Text = ""
                'lblTtlCstCur.Text = ""
                lblItmCstCur.Text = ""
                'lblBOMCstCur.Text = ""
                lblFtyUnt.Text = ""
                txtTtlCst.Text = 0
                txtItmCst.Text = 0
                lblTotalCtn.Text = ""
                txtDtlSCRmk.Text = ""
                txtDtlPORmk.Text = ""
                txtRefClaim.Text = ""
                chkDelDtl.Enabled = False
                chkDelDtl.Checked = False
                chkDelDtl.Enabled = True
                chkUpdatePO.Checked = True
                chkUpdatePO.Enabled = False
                chkChgFty.Checked = False
                chkChgFty.Enabled = False
                txtOldColor.Text = ""
                txtOldItem.Text = ""
                'Added by Mark Lau 20070621
                txtConftr.Enabled = False
                chkPC.Enabled = False
                ' Added by Mark Lau 20080611
                cboCustUM.Enabled = False
                LoadCustUM()

                ' Added by Mark Lau 20080825
                ' Rem by Mark Lau 20081106
                'cmdDVFtyprc.Enabled = False
                ClearDVTtlCst()
                SetDVTtlCst()

                cboCusStyNo.Items.Clear()
                cboCusStyNo.Enabled = False

                ' Added by Mark Lau 20090205
                txtMOQUnttyp.Text = ""

                txtZTNVBELN.Text = ""
                txtZTNPOSNR.Text = ""

                txtZORVBELN.Text = ""
                txtZORPOSNR.Text = ""

                txtZORVBELN.Enabled = True
                txtZORVBELN.ReadOnly = True
                txtZORPOSNR.Enabled = True
                txtZORPOSNR.ReadOnly = True

                'Call ASS_Check(rs_SCORDDTL("sod_ordseq").value, "DEL")
                recordStatus_dtl = False

                '**************************ADD MODE************************************
            Case "ADD"
                'txtItmStatus.Text = ""
                txtCustColCde.Text = ""
                txtColDsc.Text = ""
                txtJobNo.Text = ""
                txtRunNo.Text = ""
                txtPJobNo.Text = ""
                txtYear.Text = ""
                cboSeason.Text = ""
                txtCustItmno.Text = ""
                txtSecCusItm.Text = ""
                strCusSub = ""

                txtTentOrdno.Text = ""
                txtTentOrdSeq.Text = ""

                txtOrdQty.Text = ""
                txtPC.Text = ""
                txtShipped.Text = 0
                txtUM.Text = ""
                txtDiscount.Text = 0
                txtPckItr.Text = ""
                lblColPckType.Text = strColPck
                'lblMasterPrice.Caption = "Master Price : "
                txtItmPrc.Text = ""
                txtItmBasPrc.Text = ""
                'lblSelPrice.Caption = "Selling Price : "
                txtSelprc.Text = ""
                txtUntPrc.Text = ""
                strOrgSelPrc = ""
                strorgpcprc = ""
                optEAN.Checked = True

                txtEffectiveCPO.Text = ""
                txtEffDat.Text = ""
                txtExpDat.Text = ""
                txtCIHPrd.Text = ""
                txtPrcGrp.Text = ""

                txtCdeMer.Text = ""
                txtCdeInr.Text = ""
                txtCdeCtn.Text = ""

                cboHSTU.Items.Clear()
                txtDuty.Text = ""
                txtDept.Text = ""
                txtRefDoc.Text = ""

                txtMOQ.Text = ""
                txtMOA.Text = ""
                txtMOQUnttyp.Text = ""
                txtMOQChg.Text = ""

                cboRetailUSDCur.SelectedIndex = -1
                txtRetailUSD.Text = ""
                cboRetailCADCur.SelectedIndex = -1
                txtRetailCAD.Text = ""

                txtInnerLin = 0
                txtInnerWin = 0
                txtInnerHin = 0
                txtMasterLin = 0
                txtMasterWin = 0
                txtMasterHin = 0
                txtInnerLcm = 0
                txtInnerWcm = 0
                txtInnerHcm = 0
                txtMasterLcm = 0
                txtMasterWcm = 0
                txtMasterHcm = 0

                txtStartShip.Text = txtStartShipDat.Text
                txtEndShip.Text = txtEndShipDat.Text
                txtCanDat.Text = txtCancelDat.Text

                txtPOStartShip.Text = "  /  /"
                txtPOEndShip.Text = "  /  /"
                txtPOCanDat.Text = "  /  /"

                txtDtlPORmk.Text = ""

                txtStartCarton.Text = 0
                txtEndCarton.Text = 0
                cmdAss.Enabled = False
                cmdBOM.Enabled = False

                txtVenno.Text = ""
                cboPrdVen.Items.Clear()
                cboCusVen.Items.Clear()
                cboTradeVen.Items.Clear()
                cboExamVen.Items.Clear()
                'Lester Wu 2006-09-23
                Me.txtOldItem.Text = ""
                Me.txtOldColor.Text = ""

                lblVenItm.Text = ""
                'lblTtlCstCur.Text = ""
                lblItmCstCur.Text = ""
                'lblBOMCstCur.Text = ""
                lblFtyUnt.Text = ""
                lblTotalCtn.Text = ""
                txtTtlCst.Text = 0
                txtBOMCst.Text = 0
                txtItmCst.Text = 0

                lblDVItmCstCur.Text = ""
                txtDVItmCst.Text = 0
                txtDVBOMCst.Text = 0
                txtDVTtlCst.Text = 0
                lblDVFtyUnt.Text = ""

                txtRefClaim.Text = ""


                chkDelDtl.Enabled = False
                chkDelDtl.Checked = False
                chkDelDtl.Enabled = True
                chkUpdatePO.Checked = True
                chkUpdatePO.Enabled = False
                chkChgFty.Checked = False
                chkChgFty.Enabled = False


                ' Added by Mark Lau 20080825
                ' Rem by Mark Lau 20081106
                'cmdDVFtyprc.Enabled = False
                'ClearDVTtlCst()
                'SetDVTtlCst()

                'Added by Mark Lau 20070621
                txtConftr.Text = ""
                chkPC.Checked = False
                ABUASSORT("HIDE")

                ' Added by Mark Lau 20080611
                LoadCustUM()

                'Lester Wu 2006-09-24

                recordStatus_dtl = False

                ' Mark Lau 20081107
                'txtCusstyno.Text = ""
                cboCusStyNo.Items.Clear()
                cboCusStyNo.Enabled = False

                ' Added by Mark Lau 20090205
                txtMOQUnttyp.Text = ""

                txtPeriod.Text = ""         ' Frankie Cheung 20100420 Add Period
                txtIMPeriod.Text = ""       ' Frankie Cheung 20100806 Add IM Period

                txtZTNVBELN.Text = ""
                txtZTNPOSNR.Text = ""

                txtZORVBELN.Text = ""
                txtZORPOSNR.Text = ""

                txtZORVBELN.Enabled = True
                txtZORVBELN.ReadOnly = True
                txtZORPOSNR.Enabled = True
                txtZORPOSNR.ReadOnly = True
        End Select

        If txtSCVerNo.Text = "1" Then
            lblDtlPORmk.Text = "Additional" & Environment.NewLine & "PO Remark"
            cmdDtlPORmk.Location = New Point(cmdDtlPORmk.Location.X, 440)
        Else
            lblDtlPORmk.Text = "PO Remark"
            cmdDtlPORmk.Location = New Point(cmdDtlPORmk.Location.X, 427)
        End If

        Me.Cursor = Windows.Forms.Cursors.Default

    End Sub

    Private Function isNewItemFormat(ByVal strItem As String) As Boolean
        If Len(strItem) < 11 Then Return False
        If InStr(strItem, "-") > 0 Then Return False
        If InStr(strItem, "/") > 0 Then Return False
        If Not (UCase(Mid(strItem, 3, 1)) = "A" Or UCase(Mid(strItem, 3, 1)) = "B" Or UCase(Mid(strItem, 3, 1)) = "U" Or _
                UCase(Mid(strItem, 3, 1)) = "C" Or UCase(Mid(strItem, 3, 1)) = "D" Or UCase(Mid(strItem, 3, 1)) = "T" Or _
                UCase(Mid(strItem, 3, 1)) = "X" Or UCase(Mid(strItem, 3, 1)) = "V") Then Return False
        Return True
    End Function

    Private Sub GetCusSty(ByVal strItm As String)
        Dim rs As DataSet
        'gspStr = "sp_select_IMCUSSTY_QU '','" & strItm & "','" & cboPriCust.Text.Substring(0, InStr(cboPriCust.Text, " - ") - 1) & "'"
        gspStr = "sp_select_IMCUSSTY_QU '','" & strItm & "','" & Split(cboPriCust.Text, " - ")(0) & "'"
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #022 sp_select_IMCUSSTY_QU : " & rtnStr)
            Exit Sub
        Else
            If rs.Tables("RESULT").Rows.Count > 0 Then
                cboCusStyNo.Items.Clear()
                cboCusStyNo.Items.Add("")
                For i As Integer = 0 To rs.Tables("RESULT").Rows.Count - 1
                    cboCusStyNo.Items.Add(rs.Tables("RESULT").Rows(i)("ics_cusstyno"))
                Next
                cboCusStyNo.Enabled = True
                cboCusStyNo.SelectedIndex = 0
            Else
                cboCusStyNo.Items.Clear()
                cboCusStyNo.Enabled = False
            End If
        End If
    End Sub

    Public Function isABUAssortment(ByVal itmNo As String) As Boolean
        Dim rs As DataSet

        gspStr = "sp_select_CHECK_ASST_FOR_PC '','" & itmNo & "'"
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #023 sp_select_CHECK_ASST_FOR_PC : " & rtnStr)
            Return False
        Else
            If rs.Tables("RESULT").Rows.Count > 0 Then
                Return True
            Else
                Return False
            End If
        End If
    End Function

    Private Sub SalRate(ByVal Custcurcde As String, ByVal CurCde As String, ByVal prc As Double, ByVal typ As String)
        Dim SelRat As Double

        ' Added by Mark Lau 20090826
        Dim strDate As String = ""
        Dim dblRate As Double

        Select Case typ
            Case "IM"
                ' Added by Mark Lau 20090826
                ' IM Bas Prc, the rate will be recorded
                If CDbl(strCurExRat) = 0 Then
                    dblRate = GetSelRat(CurCde, Custcurcde, strDate)
                    strCurExRat = CStr(dblRate)
                    strCurExEffDat = Format(CDate(strDate), "yyyy-MM-dd")
                Else
                    If Custcurcde = CurCde Then
                        dblRate = 1
                    Else
                        'dblRate = CDbl(strCurExRat)
                        dblRate = GetSelRat(CurCde, Custcurcde, strDate)
                        strCurExRat = CStr(dblRate)
                        strCurExEffDat = Format(CDate(strDate), "yyyy-MM-dd")
                    End If
                End If

                SelRat = dblRate

                txtItmPrc.Text = Format(roundup(prc * SelRat), "######0.0000")



            Case "SC"
                ' Added by Mark Lau 20090826
                ' CIH Bas Prc, the rate will not be recorded
                dblRate = GetSelRat(CurCde, Custcurcde, strDate)
                SelRat = dblRate


                If Custcurcde = CurCde Then
                    If txtOrdQty.Text = "" Then
                        txtSelprc.Text = Format(0, "######0.00")
                    Else
                        'Marco fix .0045 to .0049 rounding problem 20100909
                        'txtSelprc.Text = Format(roundup2(prc), "######0.00")
                        txtSelprc.Text = Format(prc, "######0.00")
                    End If
                    txtUntPrc.Text = Format(roundup(prc), "######0.0000")
                    txtNetUntPrc.Text = txtUntPrc.Text
                    strOrgSelPrc = Format(roundup(prc), "#0.0000")
                    If chkPC.Checked = True And IsNumeric(Me.txtConftr.Text) Then
                        strorgpcprc = Format(roundup(prc / CInt(Me.txtConftr.Text)), "#0.0000")
                        Me.txtPCPrc.Text = strorgpcprc
                    Else
                        strorgpcprc = ""
                        Me.txtPCPrc.Text = ""
                    End If
                Else
                    ' Added by Mark Lau 20090826
                    If txtOrdQty.Text = "" Then
                        txtSelprc.Text = Format(0 * SelRat, "######0.00")
                    Else
                        'Marco fix .0045 to .0049 rounding problem 20100909
                        'txtSelprc.Text = Format(roundup2(prc * SelRat), "######0.00")
                        txtSelprc.Text = Format(prc * SelRat, "######0.00")
                    End If

                    txtUntPrc.Text = Format(roundup(prc * SelRat), "######0.0000")
                    txtNetUntPrc.Text = txtUntPrc.Text
                    strOrgSelPrc = Format(roundup(prc), "#0.0000")

                    If chkPC.Checked = True And IsNumeric(Me.txtConftr.Text) Then
                        strorgpcprc = Format(roundup(prc * SelRat / CInt(Me.txtConftr.Text)), "#0.0000")
                        Me.txtPCPrc.Text = strorgpcprc
                    Else
                        strorgpcprc = ""
                        Me.txtPCPrc.Text = strorgpcprc
                    End If

                End If

            Case "MOA"
                dblRate = GetSelRat(CurCde, Custcurcde, strDate)
                SelRat = dblRate

                txtMOA.Text = Format(roundup(prc * SelRat), "#0")
            Case "RATE"
                dblRate = GetSelRat(CurCde, Custcurcde, strDate)
                strCurExRat = CStr(dblRate)
                strCurExEffDat = Format(CDate(strDate), "yyyy-MM-dd")
        End Select
    End Sub

    Public Function GetSelRat(ByVal strFrmCur As String, ByVal strToCur As String, ByRef strEffDat As String) As Double
        Dim rs As DataSet

        If strEffDat = "" Then
            gspStr = "sp_select_SYCUREX_transaction '','" & strFrmCur & "','" & strToCur & "','1900-01-01',''"
        Else
            gspStr = "sp_select_SYCUREX_transaction '','" & strFrmCur & "','" & strToCur & "','" & strEffDat & "',''"
        End If

        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #023 sp_select_SYCUREX_transaction : " & rtnStr)
            Return 0
        Else
            If rs.Tables("RESULT").Rows.Count > 0 Then
                If strEffDat = "" Then
                    strEffDat = Format(rs.Tables("RESULT").Rows(0)("yce_effdat"), "yyyy-MM-dd")
                End If
                Return CDbl(rs.Tables("RESULT").Rows(0)("yce_selrat"))
            Else
                Return 0
            End If
        End If
    End Function

    'Private Sub fillVenMrk(ByVal itmNo As String, ByVal um As String, ByVal inner As Integer, ByVal master As Integer)
    '    Dim ftycst As New DataSet
    '    Dim rs As New DataSet

    '    If txtItmno.Text.Length > 0 Then
    '        'gspStr = "sp_select_IMPRCINF_ftycst '','" & itmNo & "','" & um & "','" & inner & "','" & master & _
    '        '         "','" & Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "','X'"

    '        gspStr = "sp_select_IMPRCINF_ftycst '','" & itmNo & "','" & um & "','" & inner & "','" & master & _
    '             "','" & sImu_cus1no & "','" & sImu_cus2no & "','X'"

    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '        rtnLong = execute_SQLStatement(gspStr, ftycst, rtnStr)
    '        Me.Cursor = Windows.Forms.Cursors.Default
    '        If rtnLong <> RC_SUCCESS Then
    '            MsgBox("Error on loading SCM00001 #040 sp_select_IMPRCINF_ftycst : " & rtnStr)
    '            Exit Sub
    '        Else
    '            rs_FTYCST = ftycst.Copy
    '        End If

    '        Dim strPriCust As String
    '        Dim strSecCust As String

    '        ' Added by Mark Lau 20081216
    '        If Trim(cboPriCust.Text) <> "" Then
    '            'strPriCust = cboPriCust.Text.Substring(0, InStr(cboPriCust.Text, " - ") - 1)
    '            strPriCust = Split(cboPriCust.Text, " - ")(0)
    '        Else
    '            strPriCust = ""
    '        End If

    '        If Trim(cboSecCust.Text) <> "" Then
    '            'strSecCust = cboSecCust.Text.Substring(0, InStr(cboSecCust.Text, " - ") - 1)
    '            strSecCust = Split(cboSecCust.Text, " - ")(0)
    '        Else
    '            strSecCust = ""
    '        End If

    '        gspStr = "sp_select_SCVENMRK_wCust2 '','" & itmNo & "','" & um & "','" & inner & "','" & master & "','" & VendorType & _
    '                 "','" & sImu_cus1no & "','" & sImu_cus2no & "','" & sImu_hkprctrm & "','" & sImu_ftyprctrm & _
    '                 "','" & sImu_trantrm & "','1'"

    '        'Fixing global company code problem at 20100420
    '        gsCompany = Trim(cboCoCde.Text)
    '        Update_gs_Value(gsCompany)

    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '        Me.Cursor = Windows.Forms.Cursors.Default

    '        If rtnLong <> RC_SUCCESS Then
    '            MsgBox("Error on loading SCM00001 #024 sp_select_SCVENMRK_wCust2 : " & rtnStr)
    '            Exit Sub
    '        Else
    '            rs_SCVENMRK = rs.Copy()

    '            If rs_SCVENMRK.Tables("RESULT").Rows.Count > 0 Then
    '                fillcbovenno()
    '                txtOrdQty.Enabled = True
    '                LoadDVTtlCst(itmNo, um, inner, master, VendorType, True)
    '            Else
    '                '****************query Item in history Table****************************
    '                If tabFrame.SelectedIndex = tabFrame_Detail Then
    '                    MsgBox("No valid current price of this item. Try to find it in history now.")
    '                End If

    '                gspStr = "sp_select_SCVENMRK_H_wCust2 '','" & itmNo & "','" & um & "','" & inner & "','" & master & "','" & _
    '                         VendorType & "','" & sImu_cus1no & "','" & sImu_cus2no & "','" & sImu_hkprctrm & "','" & sImu_ftyprctrm & _
    '                 "','" & sImu_trantrm & "','1'"

    '                'Fixing global company code problem at 20100420
    '                gsCompany = Trim(cboCoCde.Text)
    '                Call Update_gs_Value(gsCompany)

    '                Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '                Me.Cursor = Windows.Forms.Cursors.Default
    '                If rtnLong <> RC_SUCCESS Then
    '                    MsgBox("Error on loading SCM00001 #025 sp_select_SCVENMRK_H_wCust2 : " & rtnStr)
    '                    Exit Sub
    '                Else
    '                    rs_SCVENMRK = rs.Copy()

    '                    If rs_SCVENMRK.Tables("RESULT").Rows.Count > 0 Then
    '                        If rs_SCVENMRK.Tables("RESULT").Rows(0)("imu_ftycst") <> 0 And rs_SCVENMRK.Tables("RESULT").Rows(0)("imu_ftyprc") <> 0 Then
    '                            fillcbovenno()
    '                            LoadDVTtlCst(itmNo, um, inner, master, VendorType, True)
    '                        Else
    '                            If tabFrame.SelectedIndex = tabFrame_Detail Then
    '                                MsgBox("No valid price of this item in history.")
    '                                txtOrdQty.Enabled = False
    '                                txtItmno.Focus()
    '                                txtItmno.SelectAll()
    '                            End If
    '                        End If
    '                    Else
    '                        If tabFrame.SelectedIndex = tabFrame_Detail Then
    '                            MsgBox("No valid price of this item in history.")
    '                            txtOrdQty.Enabled = False
    '                            txtItmno.Focus()
    '                            txtItmno.SelectAll()
    '                        End If
    '                    End If
    '                End If

    '            End If
    '        End If
    '    End If
    'End Sub

    'Private Sub fillcbovenno()
    '    cboPrdVen.Items.Clear()
    '    If rs_SCVENMRK.Tables("RESULT").Rows.Count > 0 Then
    '        For i As Integer = 0 To rs_SCVENMRK.Tables("RESULT").Rows.Count - 1
    '            If rs_SCVENMRK.Tables("RESULT").Rows(i)("vbi_vensna") <> "N/A" Then
    '                cboPrdVen.Items.Add(rs_SCVENMRK.Tables("RESULT").Rows(i)("ivi_venno") & " - " & rs_SCVENMRK.Tables("RESULT").Rows(i)("vbi_vensna"))
    '                If rs_SCVENMRK.Tables("RESULT").Rows(i)("ivi_def") = "Y" Then
    '                    defVen = rs_SCVENMRK.Tables("RESULT").Rows(i)("ivi_venno")
    '                End If
    '            End If
    '        Next
    '    End If
    '    If cboPrdVen.Items.Count = 0 And tabFrame.SelectedIndex = tabFrame_Detail Then
    '        MsgBox("Default Vendor not in Active status")
    '        If txtItmno.Enabled = True Then
    '            cboColPckInfo.Items.Clear()
    '            txtitmno_Change()
    '            If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
    '        End If
    '    End If
    '    display_combo(defVen, cboPrdVen)
    'End Sub

    Private Sub txtitmno_Change()
        recordStatus = True
        recordStatus_dtl = True
        'Allan Yuen remark the following code at 28/07/2004
        If txtItmno.Enabled = True Then
            If skipFlag = False Then
                Display_Dtl("INIT")
                setDtlStatus("FIND")
                'CTN_Clear(Trim(lblDtlSeq.Text))
                SHP_Clear(Trim(lblDtlSeq.Text))
            End If
        End If
    End Sub

    'Private Sub CTN_Clear(ByVal ordseq As Integer)
    '    Dim drCTN() As DataRow = rs_SCDTLCTN.Tables("RESULT").Select("sdc_seq =" & "'" & ordseq & "'")

    '    If drCTN.Length > 0 Then
    '        For i As Integer = 0 To drCTN.Length - 1
    '            drCTN(i).Delete()
    '        Next
    '    End If
    'End Sub
    Private Sub SHP_Clear(ByVal ordseq As Integer)
        Dim drSHP() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq =" & "'" & ordseq & "'")

        If drSHP.Length > 0 Then
            For i As Integer = 0 To drSHP.Length - 1
                drSHP(i).Delete()
            Next
        End If
    End Sub

    'Private Sub fillCusVen(ByVal itmNo As String)

    '    Dim rs As DataSet

    '    gspStr = "sp_select_IMCUSVEN '','" & itmNo & "'"

    '    'Fixing global company code problem at 20100420
    '    gsCompany = Trim(cboCoCde.Text)
    '    Update_gs_Value(gsCompany)

    '    Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '    If rtnLong <> RC_SUCCESS Then
    '        Me.Cursor = Windows.Forms.Cursors.Default
    '        MsgBox("Error on loading SCM00001 #026 sp_select_IMCUSVEN : " & rtnStr)
    '        Exit Sub
    '    End If

    '    rs_VNBASINF_SC = rs.Copy()

    '    If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
    '        fillcboCusVen()
    '    Else
    '        gspStr = "sp_select_IMCUSVENH '','" & itmNo & "'"

    '        'Fixing global company code problem at 20100420
    '        gsCompany = Trim(cboCoCde.Text)
    '        Update_gs_Value(gsCompany)

    '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '        If rtnLong <> RC_SUCCESS Then
    '            Me.Cursor = Windows.Forms.Cursors.Default
    '            MsgBox("Error on loading SCM00001 #027 sp_select_IMCUSVENH : " & rtnStr)
    '            Exit Sub
    '        End If
    '        rs_VNBASINF_SC = rs.Copy()
    '        If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
    '            fillcboCusVen()
    '        Else
    '            MsgBox("Custom Vendor  not found !")
    '            txtOrdQty.Enabled = False
    '        End If
    '    End If
    '    Me.Cursor = Windows.Forms.Cursors.Default
    'End Sub

    Private Sub fillcboCusVen(ByVal cusven As String)
        Dim dr() As DataRow

        cboCusVen.Items.Clear()
        If rs_VNBASINF_SC.Tables("RESULT").Rows.Count = 0 Then
            fillVendorList(txtItmno.Text)
        End If

        If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
            dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_vensts = 'A'")

            For i As Integer = 0 To dr.Length - 1
                cboCusVen.Items.Add(dr(i).Item("vbi_venno") & " - " & dr(i).Item("vbi_vensna"))
            Next

            dr = Nothing
            dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_venno = '" & cusven & "'")
            If dr.Length > 0 Then
                If dr(0).Item("vbi_vensts") = "A" Then
                    display_combo(cusven, cboCusVen)
                ElseIf dr(0).Item("vbi_vensts") = "I" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("CV status is inactive")
                    End If
                    cboCusVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(cusven, cboCusVen)
                ElseIf dr(0).Item("vbi_vensts") = "D" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("CV status has been discontinued")
                    End If
                    cboCusVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(cusven, cboCusVen)
                Else
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("CV not found in Item Master")
                    End If
                    cboCusVen.Items.Add(cusven)
                    display_combo(cusven, cboCusVen)
                End If
            Else
                If txtSCVerNo.Text = "1" Then
                    MsgBox("CV not found in Item Master")
                End If
                cboCusVen.Items.Add(cusven)
                display_combo(cusven, cboCusVen)
            End If
        Else
            If txtSCVerNo.Text = "1" Then
                MsgBox("CV not found in Item Master")
            End If
            cboCusVen.Items.Add(cusven)
            display_combo(cusven, cboCusVen)
        End If
    End Sub

    Private Sub fillcboPrdVen(ByVal prdven As String)
        Dim rs As DataSet
        Dim dr() As DataRow

        cboPrdVen.Items.Clear()
        'If rs_VNBASINF_SC.Tables("RESULT").Rows.Count = 0 Then
        '    fillVendorList(txtItmno.Text)
        'End If
        gspStr = "sp_select_IMVENINF_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #113 sp_select_IMVENINF : " & rtnStr)
            Exit Sub
        End If

        If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
            dr = rs.Tables("RESULT").Select("vbi_vensts = 'A'")

            For i As Integer = 0 To dr.Length - 1
                cboPrdVen.Items.Add(dr(i).Item("ivi_venno") & " - " & dr(i).Item("vbi_vensna"))
            Next

            dr = Nothing
            dr = rs.Tables("RESULT").Select("ivi_venno = '" & prdven & "'")
            If dr.Length > 0 Then
                If dr(0).Item("vbi_vensts") = "A" Then
                    display_combo(prdven, cboPrdVen)
                ElseIf dr(0).Item("vbi_vensts") = "I" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("PV status is inactive")
                    End If
                    cboPrdVen.Items.Add(dr(0).Item("ivi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(prdven, cboPrdVen)
                ElseIf dr(0).Item("vbi_vensts") = "D" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("PV status has been discontinued")
                    End If
                    cboPrdVen.Items.Add(dr(0).Item("ivi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(prdven, cboPrdVen)
                Else
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("PV not found in Item Master")
                    End If
                    cboPrdVen.Items.Add(prdven)
                    display_combo(prdven, cboPrdVen)
                End If
            Else
                If txtSCVerNo.Text = "1" Then
                    MsgBox("PV not found in Item Master")
                    cboPrdVen.Items.Add(prdven)
                    display_combo(prdven, cboPrdVen)
                Else
                    gspStr = "sp_select_VNBASINF '','" & prdven & "'"
                    rs = Nothing
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on loading SCM00001 #136 sp_select_VNBASINF : " & rtnStr)
                        Exit Sub
                    End If

                    If rs.Tables("RESULT").Rows.Count > 0 Then
                        cboPrdVen.Items.Add(rs.Tables("RESULT").Rows(0)("vbi_venno") & " - " & rs.Tables("RESULT").Rows(0)("vbi_vensna"))
                        display_combo(prdven, cboPrdVen)
                    Else
                        MsgBox("PV not found in Vendor Master")
                        cboPrdVen.Items.Add(prdven)
                        display_combo(prdven, cboPrdVen)
                    End If
                End If
            End If
        Else
            If txtSCVerNo.Text = "1" Then
                MsgBox("PV not found in Item Master")
            End If
            cboPrdVen.Items.Add(prdven)
            display_combo(prdven, cboPrdVen)
        End If
    End Sub

    Private Sub fillcboTradeVen(ByVal tradeven As String)
        Dim dr() As DataRow

        cboTradeVen.Items.Clear()
        'If rs_VNBASINF_SC.Tables("RESULT").Rows.Count = 0 Then
        If rs_VNBASINF.Tables("RESULT").Rows.Count = 0 Then
            fillVendorList(txtItmno.Text)
        End If

        'If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
        '   dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_vensts = 'A'")
        If rs_VNBASINF.Tables("RESULT").Rows.Count > 0 Then
            dr = rs_VNBASINF.Tables("RESULT").Select("vbi_vensts = 'A'")

            For i As Integer = 0 To dr.Length - 1
                cboTradeVen.Items.Add(dr(i).Item("vbi_venno") & " - " & dr(i).Item("vbi_vensna"))
            Next

            dr = Nothing
            'dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_venno = '" & tradeven & "'")
            dr = rs_VNBASINF.Tables("RESULT").Select("vbi_venno = '" & tradeven & "'")
            If dr.Length > 0 Then
                If dr(0).Item("vbi_vensts") = "A" Then
                    display_combo(tradeven, cboTradeVen)
                ElseIf dr(0).Item("vbi_vensts") = "I" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("TV status is inactive")
                    End If
                    cboTradeVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(tradeven, cboTradeVen)
                ElseIf dr(0).Item("vbi_vensts") = "D" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("TV status has been discontinued")
                    End If
                    cboTradeVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(tradeven, cboTradeVen)
                Else
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("TV not found in Item Master")
                    End If
                    cboTradeVen.Items.Add(tradeven)
                    display_combo(tradeven, cboTradeVen)
                End If
            Else
                If txtSCVerNo.Text = "1" Then
                    MsgBox("TV not found in Vendor Master")
                End If
                cboTradeVen.Items.Add(tradeven)
                display_combo(tradeven, cboTradeVen)
            End If
        Else
            If txtSCVerNo.Text = "1" Then
                MsgBox("TV not found in Item Master")
            End If
            cboTradeVen.Items.Add(tradeven)
            display_combo(tradeven, cboTradeVen)
        End If
    End Sub

    Private Sub fillcboexamven(ByVal examven As String)
        Dim dr() As DataRow

        cboExamVen.Items.Clear()
        'If rs_VNBASINF_SC.Tables("RESULT").Rows.Count = 0 Then
        If rs_VNBASINF.Tables("RESULT").Rows.Count = 0 Then
            fillVendorList(txtItmno.Text)
        End If

        'If rs_VNBASINF_SC.Tables("RESULT").Rows.Count > 0 Then
        '   dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_vensts = 'A'")
        If rs_VNBASINF.Tables("RESULT").Rows.Count > 0 Then
            dr = rs_VNBASINF.Tables("RESULT").Select("vbi_vensts = 'A'")

            For i As Integer = 0 To dr.Length - 1
                cboExamVen.Items.Add(dr(i).Item("vbi_venno") & " - " & dr(i).Item("vbi_vensna"))
            Next

            dr = Nothing
            'dr = rs_VNBASINF_SC.Tables("RESULT").Select("vbi_venno = '" & examven & "'")
            dr = rs_VNBASINF.Tables("RESULT").Select("vbi_venno = '" & examven & "'")
            If dr.Length > 0 Then
                If dr(0).Item("vbi_vensts") = "A" Then
                    display_combo(examven, cboExamVen)
                ElseIf dr(0).Item("vbi_vensts") = "I" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("FA status is inactive")
                    End If
                    cboExamVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(examven, cboExamVen)
                ElseIf dr(0).Item("vbi_vensts") = "D" Then
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("FA status has been discontinued")
                    End If
                    cboExamVen.Items.Add(dr(0).Item("vbi_venno") & " - " & dr(0).Item("vbi_vensna"))
                    display_combo(examven, cboExamVen)
                Else
                    If txtSCVerNo.Text = "1" Then
                        MsgBox("FA not found in Vendor Master")
                    End If
                    cboExamVen.Items.Add(examven)
                    display_combo(examven, cboExamVen)
                End If
            Else
                If txtSCVerNo.Text = "1" Then
                    MsgBox("FA not found in Vendor Master")
                End If
                cboExamVen.Items.Add(examven)
                display_combo(examven, cboExamVen)
            End If
        Else
            If txtSCVerNo.Text = "1" Then
                MsgBox("FA not found in Vendor Master")
            End If
            cboExamVen.Items.Add(examven)
            display_combo(examven, cboExamVen)
        End If
    End Sub

    Public Function contains_Combo(ByVal val As String, ByVal combo As ComboBox) As Boolean

        If val = "" Then
            combo.Text = val
            Return False
        End If

        Dim i As Integer

        For i = 0 To combo.Items.Count - 1
            If val = Split(combo.Items(i), " - ")(0) Then
                Return True
            End If
        Next i
        Return False
    End Function

    Private Sub LoadDVTtlCst(ByVal strItmNo As String, ByVal strUM As String, ByVal strInner As String, ByVal strMaster As String, ByVal strVendorType As String, ByVal blnSetValue As Boolean)

        Dim rs As DataSet

        Dim strPriCust As String
        Dim strSecCust As String

        If Trim(cboPriCust.Text) <> "" Then
            strPriCust = Split(cboPriCust.Text, " - ")(0)
        Else
            strPriCust = ""
        End If

        If Trim(cboSecCust.Text) <> "" Then
            strSecCust = Split(cboSecCust.Text, " - ")(0)
        Else
            strSecCust = ""
        End If

        'gspStr = "sp_select_SCVENMRK_DV_wCust2 '" & cboCoCde.Text & "','" & strItmNo & "','" & strUM & "','" & strInner & "','" & _
        '         strMaster & "','" & strVendorType & "','" & sImu_cus1no & "','" & sImu_cus2no & "','" & sImu_hkprctrm & "','" & _
        '         sImu_ftyprctrm & "','" & sImu_trantrm & "','1'"

        gspStr = "sp_select_SCVENMRK_DV_wCust '" & cboCoCde.Text & "','" & strItmNo & "','" & strUM & "','" & strInner & "','" & _
                 strMaster & "','" & sImu_cus1no & "','" & sImu_cus2no & "','" & sImu_hkprctrm & "','" & _
                 sImu_ftyprctrm & "','" & sImu_trantrm & "'"

        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #028 sp_select_SCVENMRK_DV_wCust : " & rtnStr)
            Exit Sub
        Else
            rs_SCVENMRK_DV = rs.Copy()

            If rs_SCVENMRK_DV.Tables("RESULT").Rows.Count = 0 Then
                If tabFrame.SelectedIndex = tabFrame_Detail And skipDVErrorFlag = False Then
                    MsgBox("No valid current DV price of this item. Try to find it in history now.")
                End If

                gspStr = "sp_select_SCVENMRK_H_DV_wCust2 '" & cboCoCde.Text & "','" & strItmNo & "','" & strUM & "','" & strInner & _
                         "','" & strMaster & "','" & strVendorType & "','" & sImu_cus1no & "','" & sImu_cus2no & "','" & _
                         sImu_hkprctrm & "','" & sImu_ftyprctrm & "','" & sImu_trantrm & "','1'"

                'Fixing global company code problem at 20100420
                gsCompany = Trim(cboCoCde.Text)
                Update_gs_Value(gsCompany)

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #029 sp_select_SCVENMRK_H_DV_wCust : " & rtnStr)
                    Exit Sub
                Else
                    rs_SCVENMRK_DV = rs.Copy()

                    If rs_SCVENMRK_DV.Tables("RESULT").Rows.Count > 0 Then
                        If rs_SCVENMRK.Tables("RESULT").Rows(0)("imu_ftycst") = 0 Or rs_SCVENMRK.Tables("RESULT").Rows(0)("imu_ftyprc") = 0 Then
                            If tabFrame.SelectedIndex = tabFrame_Detail Then
                                MsgBox("No valid DV price of this item in history.")
                            End If
                        End If
                    Else
                        If tabFrame.SelectedIndex = tabFrame_Detail And skipDVErrorFlag = False Then
                            MsgBox("No valid DV price of this item in history.")
                        End If
                    End If
                End If
            End If
        End If

        'lblDVTtlCstCur.Text = ""
        txtDVTtlCst.Text = "0"
        lblDVFtyUnt.Text = ""
        lblDVItmCstCur.Text = ""
        'lblDVBOMCstCur.Text = ""
        txtDVItmCst.Text = "0"
        txtDVBOMCst.Text = "0"
        'lblDV.Text = ""

        strVenType = VendorType

        If rs_SCVENMRK_DV.Tables("RESULT").Rows.Count > 0 Then

            strVenType = rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("vendortype")

            If rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_curcde") = "" Then
                strDVfcurcde = ""
            Else
                strDVfcurcde = rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_curcde")
            End If

            strDVTtlCstCur = strDVfcurcde
            strDVItmCstCur = strDVfcurcde
            strDVBOMCstCur = strDVfcurcde
            lblDVName.Text = rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("vbi_vensna")
            strDV = rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("ivi_venno")

            If strVenType = "I" Or strVenType = "J" Then
                'If rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_negprc") > 0 Then
                '    strDVItmCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_negprc"), "#0.0000")
                'Else
                '    strDVItmCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_ftyprc"), "#0.0000")
                'End If
                strDVItmCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_negprc"), "#0.0000")
                strDVBOMCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_bomcst"), "#0.0000")
                strDVTtlCst = strDVItmCst

            ElseIf strVenType = "E" Then
                strDVItmCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_ftyprc"), "#0.0000")

                strDVBOMCst = Format(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_bomcst"), "#0.0000")
                If rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_bomcst") = 0 Then
                    strDVTtlCst = Format(Val(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_ftyprc")) + Val(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_bomcst")), "#0.0000")
                Else
                    strDVTtlCst = Format(Math.Round(((Val(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_ftyprc")) + Val(rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_bomcst"))) * 10000) / 10000, 4), "#0.0000")
                End If

            End If

            strDVftyunt = rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("imu_pckunt")

            'If rs_SCVENMRK_DV.Tables("RESULT").Rows(0)("vendortype") = "E" Then
            '    displayDVPrices(False)
            'Else
            '    displayDVPrices(True)
            'End If

            SetDVTtlCst()
        Else
            ClearDVTtlCst()
            SetDVTtlCst()
        End If

    End Sub

    Private Sub SetDVTtlCst()
        recordStatus = True
        recordStatus_dtl = True

        txtDVItmCst.Enabled = True
        txtDVTtlCst.Enabled = False

        If gsUsrRank <= 4 Then
            txtDVItmCst.Enabled = True
            txtDVBOMCst.Enabled = True
        Else
            txtDVItmCst.Enabled = False
            txtDVBOMCst.Enabled = False
        End If

        If (strDVBOMCst = "0" Or CDbl(strDVBOMCst) = 0) And CDbl(txtBOMCst.Text) = 0 Then
            txtDVBOMCst.Enabled = False
        End If

        ' Added by Mark Lau 20080826
        If cboSCStatus.Text <> "" Then
            If cboSCStatus.Text.Substring(0, 3) <> "ACT" Then
                txtDVItmCst.Enabled = False
                txtDVBOMCst.Enabled = False
            End If
        End If

        If chkDelDtl.Checked = True Then
            txtDVItmCst.Enabled = False
            txtDVBOMCst.Enabled = False
        End If

        Dim rs As DataSet

        If strDV <> "" Then
            ' For New Data
            gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & strDV & "'"

            'Fixing global company code problem at 20100420
            gsCompany = Trim(cboCoCde.Text)
            Update_gs_Value(gsCompany)

            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #039 sp_select_VNBASINF : " & rtnStr)
                Exit Sub
            Else
                If rs.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
                    If gsFlgCstExt = "1" Then
                        'setDtlStatus("Cost")
                        setDtlStatus("NoDVCost")
                    Else
                        setDtlStatus("NoCost")
                    End If

                Else
                    If gsFlgCst = "1" Then
                        setDtlStatus("Cost")
                    Else
                        setDtlStatus("NoCost")
                    End If
                End If
            End If
        Else
            ' For Old Data
            If VendorType = "E" Then
                If gsFlgCstExt = "1" Then
                    'setDtlStatus("Cost")
                    setDtlStatus("NoDVCost")
                Else
                    setDtlStatus("NoCost")
                End If
            Else
                If gsFlgCst = "1" Then
                    setDtlStatus("Cost")
                Else
                    setDtlStatus("NoCost")
                End If
            End If
        End If

        'lblDVTtlCstCur.Text = strDVTtlCstCur
        txtDVTtlCst.Text = Format(CDbl(strDVTtlCst), "#0.0000")
        lblDVFtyUnt.Text = strDVftyunt
        lblDVItmCstCur.Text = strDVItmCstCur
        txtDVItmCst.Text = Format(CDbl(strDVItmCst), "#0.0000")
        'lblDVBOMCstCur.Text = strDVBOMCstCur
        txtDVBOMCst.Text = Format(CDbl(strDVBOMCst), "#0.0000")
        'lblDV.Caption = strDV
        VendorType = strVenType

        If Trim(lblDVName.Text = "") Then
            Dim vn As DataSet

            gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & strDV & "'"

            'Fixing global company code problem at 20100420
            gsCompany = Trim(cboCoCde.Text)
            Update_gs_Value(gsCompany)

            rtnLong = execute_SQLStatement(gspStr, vn, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #030 sp_select_VNBASINF : " & rtnStr)
                Exit Sub
            Else
                If vn.Tables("RESULT").Rows.Count > 0 Then
                    lblDVName.Text = vn.Tables("RESULT").Rows(0)("vbi_vensna")
                Else
                    lblDVName.Text = ""
                End If
            End If
        End If
    End Sub

    Private Sub ClearDVTtlCst()
        strDVTtlCstCur = ""
        strDVItmCstCur = ""
        strDVBOMCstCur = ""
        strDVTtlCst = 0
        strDVBOMCst = 0
        strDVItmCst = 0
        strDVftyunt = ""
        strDV = ""
        strDVfcurcde = ""
        lblDVName.Text = ""
    End Sub

    Private Sub LoadCustUM()
        cboCustUM.Items.Clear()
        cboCustUM.Items.Add("")

        Dim rs As DataSet

        gspStr = "sp_select_SQL '','" & "select ysi_cde from SYSETINF where ysi_typ = ''05'' order by ysi_cde asc" & "'"
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #031 sp_select_VNBASINF : " & rtnStr)
            Exit Sub
        End If

        For i As Integer = 0 To rs.Tables("RESULT").Rows.Count - 1
            cboCustUM.Items.Add(rs.Tables("RESULT").Rows(i)("ysi_cde"))
        Next
    End Sub

    Private Sub enable_txtBOMCst()
        Try
            txtBOMCst.Enabled = False
            Dim dr As DataRow() = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = '" & currentOrdSeq & "'")
            If dr.Length > 0 Then
                txtBOMCst.Enabled = True
            Else
                txtBOMCst.Enabled = False
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub checkMore()
        Dim status As String

        If cboSCStatus.Text = "" Then
            status = ""
        Else
            status = Split(cboSCStatus.Text, " - ")(0)
        End If

        '***********************Check the more Ship****************************************
        Dim drSHP() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = " & "'" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "' and sds_status = ' ' ")
        If drSHP.Length > 0 Then
            txtStartShip.Enabled = False
            txtEndShip.Enabled = False
            If addFlag = True Then
                txtCanDat.Enabled = True
                txtPOCanDat.Enabled = True
            End If
            'txtCanDat.Enabled = False
            cmdMoreShp.Enabled = True
            txtPOStartShip.Enabled = False
            txtPOEndShip.Enabled = False
            'txtPOCanDat.Enabled = False
            cmdPOCalDat.Enabled = False
        ElseIf (status = "ACT" Or status = "HLD") And chkDelDtl.Checked = False Then
            txtStartShip.Enabled = True
            txtEndShip.Enabled = True
            If addFlag = True Then
                txtCanDat.Enabled = True
                txtPOCanDat.Enabled = True
            End If
            'txtCanDat.Enabled = True
            txtPOStartShip.Enabled = True
            txtPOEndShip.Enabled = True
            'txtPOCanDat.Enabled = True
            cmdPOCalDat.Enabled = True
        End If

        '***********************Check the more Carton****************************************
        drSHP = Nothing
        drSHP = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = " & "'" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "' and sds_status = ' ' ")
        If drSHP.Length > 0 Then
            txtStartCarton.Enabled = False
            txtEndCarton.Enabled = False
            'cmdMoreCtn.Enabled = True
        ElseIf (status = "ACT" Or status = "HLD") And chkDelDtl.Checked = False Then
            txtStartCarton.Enabled = True
            txtEndCarton.Enabled = True
        End If
    End Sub

    Private Sub fillcboShipAdd(ByVal typ As String)
        cboShipAdd.Items.Clear()
        Select Case typ
            Case "P"
                If rs_CUCNTINF_P.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_CUCNTINF_P.Tables("RESULT").Rows.Count - 1
                        'cboShipAdd.Items.Add(rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntseq") & " - " & rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Substring(0, 35))
                        cboShipAdd.Items.Add(rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntseq") & " - " & rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Substring(0, IIf(rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length > 35, 35, rs_CUCNTINF_P.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length)))
                    Next
                    cboShipAdd.Enabled = True
                    cboShipAdd.SelectedIndex = 0
                Else
                    cboShipAdd.Enabled = False
                End If
            Case "S"
                If rs_CUCNTINF_S.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_CUCNTINF_S.Tables("RESULT").Rows.Count - 1
                        'cboShipAdd.Items.Add(rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntseq") & " - " & rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Substring(0, 35))
                        cboShipAdd.Items.Add(rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntseq") & " - " & rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Substring(0, IIf(rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length > 35, 35, rs_CUCNTINF_S.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length)))
                    Next
                    cboShipAdd.Enabled = True
                    cboShipAdd.SelectedIndex = 0
                Else
                    cboShipAdd.Enabled = False
                End If
        End Select
        cboShipAdd.Items.Add("")
    End Sub

    Private Sub fillcboBillAdd()
        If rs_CUCNTINF_BA.Tables("RESULT").Rows.Count > 0 Then
            cboBillAdd.Items.Clear()
            For i As Integer = 0 To rs_CUCNTINF_BA.Tables("RESULT").Rows.Count - 1
                cboBillAdd.Items.Add(rs_CUCNTINF_BA.Tables("RESULT").Rows(i)("cci_cntseq") & " - " & rs_CUCNTINF_BA.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Substring(0, IIf(rs_CUCNTINF_BA.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length > 35, 35, rs_CUCNTINF_BA.Tables("RESULT").Rows(i)("cci_cntadr").ToString.Length)))
            Next
            cboBillAdd.Enabled = True
            cboBillAdd.SelectedIndex = 0
        Else
            cboBillAdd.Enabled = False
        End If

        cboBillAdd.Items.Add("")
    End Sub

    Private Sub fillcboAgent()
        cboAgent.Items.Clear()
        If rs_CUBASINF_Agent.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_CUBASINF_Agent.Tables("RESULT").Rows.Count - 1
                cboAgent.Items.Add(rs_CUBASINF_Agent.Tables("RESULT").Rows(i)("cai_cusagt") & " - " & rs_CUBASINF_Agent.Tables("RESULT").Rows(i)("yai_stnam"))
            Next
            cboAgent.Enabled = True
        Else
            cboAgent.Enabled = False
        End If
    End Sub

    Private Sub fillcboPerson()
        If rs_CUBASINF_Person.Tables("RESULT").Rows.Count > 0 Then
            cboContactPerson.Items.Clear()
            For i As Integer = 0 To rs_CUBASINF_Person.Tables("RESULT").Rows.Count - 1
                cboContactPerson.Items.Add(rs_CUBASINF_Person.Tables("RESULT").Rows(i)("cci_cntctp"))
            Next
        End If
    End Sub

    Private Sub fillcboSecCust()
        cboSecCust.Items.Clear()
        cboSecCust.Items.Add("")
        Dim dr() As DataRow
        If addFlag = True Then
            dr = rs_CUBASINF_S.Tables("RESULT").Select("csc_seccus >= '60000'")
        Else
            dr = rs_CUBASINF_S.Tables("RESULT").Select()
        End If

        If dr.Length > 0 Then
            For i As Integer = 0 To dr.Length - 1
                If cboSecCust.Items.Contains(dr(i).Item("csc_seccus") & " - " & dr(i).Item("cbi_cussna")) = False Then
                    cboSecCust.Items.Add(dr(i).Item("csc_seccus") & " - " & dr(i).Item("cbi_cussna"))
                End If
            Next
        End If
    End Sub

    Private Sub Display_PrimaryCust()
        '***********Display 1 Folder**************************
        If rs_CUBASINF_P.Tables("RESULT").Rows.Count > 0 Then
            'rs_CUBASINF_P.MoveFirst()
            'rs_CUBASINF_P.Find("cbi_cusno = " & "'" & Split(cboPriCust.Text, " - ")(0) & "'")
            Dim drPriCus() As DataRow = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")

            If drPriCus.Length > 0 Then
                txtRemark.Text = drPriCus(0).Item("cbi_cerdoc")
                txtShipAdd.Text = drPriCus(0).Item("ship_cci_cntadr")
                txtShipSP.Text = drPriCus(0).Item("ship_cci_cntstt")
                If drPriCus(0).Item("ship_cci_cntcty") <> "" Then
                    display_combo(drPriCus(0).Item("ship_cci_cntcty"), cboShipCountry)
                Else
                    cboShipCountry.SelectedIndex = -1
                End If
                txtShipZIP.Text = drPriCus(0).Item("ship_cci_cntpst")

                Dim drSalRep() As DataRow = rs_CUBASINF_SalRep.Tables("RESULT").Select("ssr_saltem = '" & drPriCus(0).Item("cbi_saltem") & "' or ssr_saltem = 'S'")
                fillcboSalesRep(drSalRep)

                display_combo(drPriCus(0).Item("cbi_srname"), cboSalesRep)
                display_combo(drPriCus(0).Item("cpi_prctrm"), cboPrcTrm)
                display_combo(drPriCus(0).Item("cpi_paytrm"), cboPayTrm)

                '********if in Add Mode All Currency get from Real Time***********************
                If addFlag = True Then
                    lblTtlAmtCur.Text = drPriCus(0).Item("cpi_curcde")
                    lblNetAmtCur.Text = drPriCus(0).Item("cpi_curcde")
                    '******************Detial Folder*************************
                    lblSelprcCur.Text = drPriCus(0).Item("cpi_curcde")
                    lblBasprcCur.Text = drPriCus(0).Item("cpi_curcde")
                    lblPCPrcCur.Text = drPriCus(0).Item("cpi_curcde")
                    lblSubttlCur.Text = drPriCus(0).Item("cpi_curcde")
                    lblNetprcCur.Text = drPriCus(0).Item("cpi_curcde")
                Else
                    lblTtlAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    lblNetAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    '******************Detial Folder*************************
                    lblSelprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    lblPCPrcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    lblBasprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    lblSubttlCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                    lblNetprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                End If

                '*************Get the Customer's Markup Fml**************
                Custfml = "1"
                '*** Change to customer market at 2003/08/04
                If drPriCus(0).Item("cbi_advord") = "N" Then
                    advOrd = False
                Else
                    advOrd = True
                End If

                CreditUse = drPriCus(0).Item("cpi_rskuse")
                CreditAmt = drPriCus(0).Item("cpi_rsklmt")
            Else
                lblTtlAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblNetAmtCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblSelprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblPCPrcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblBasprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblSubttlCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                lblNetprcCur.Text = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_curcde")
                CreditUse = 0
                CreditAmt = 0
            End If

            If rs_CUCNTINF_BA.Tables("RESULT").Rows.Count > 0 Then
                txtBillAdd.Text = rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntadr")
                txtBillSP.Text = rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntstt")
                If rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntcty") <> "" Then
                    display_combo(rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntcty"), cboBillCountry)
                Else
                    cboBillCountry.SelectedIndex = -1
                End If
                txtBillZIP.Text = rs_CUCNTINF_BA.Tables("RESULT").Rows(0)("cci_cntpst")
            Else
                txtBillAdd.Text = ""
                txtBillSP.Text = ""
                txtRemark.Text = ""
                cboBillCountry.SelectedIndex = -1
                txtBillZIP.Text = ""
            End If
        End If
    End Sub

    Private Sub fillcboSalesRep(ByVal dr() As DataRow)
        If dr.Length > 0 Then
            cboSalesRep.Items.Clear()
            For i As Integer = 0 To dr.Length - 1
                cboSalesRep.Items.Add(dr(i).Item("dsc"))
            Next
            cboSalesRep.Sorted = True
        End If
    End Sub

    Private Sub Display_CUSHPINF()
        If rs_CUSHPINF.Tables("RESULT").Rows.Count > 0 Then
            Dim dr() As DataRow

            '****Display Consignee Information *********************
            dr = rs_CUSHPINF.Tables("RESULT").Select("csi_csetyp='CN'")
            If dr.Length = 1 Then
                strConName = dr(0).Item("csi_csenam")
                strConAdd = dr(0).Item("csi_cseadr")
                strConSP = dr(0).Item("csi_csestt")
                strConCountry = dr(0).Item("csi_csecty")
                strConZIP = dr(0).Item("csi_csepst")
            Else
                strConName = ""
                strConAdd = ""
                strConSP = ""
                strConCountry = ""
                strConZIP = ""
            End If

            '****Display Forwarder/Courier Information *********************
            dr = rs_CUSHPINF.Tables("RESULT").Select("csi_csetyp='FO' or csi_csetyp='FA' or csi_csetyp='FT' or csi_csetyp='CO'")
            If dr.Length = 1 Then
                strForAcc = dr(0).Item("csi_cseacc")
                strForDesc = dr(0).Item("csi_csedsc")
                strForInst = dr(0).Item("csi_cseinr")
                strForTyp = dr(0).Item("csi_csetyp")
            Else
                strForAcc = ""
                strForDesc = ""
                strForInst = ""
                strForTyp = ""
            End If

            '****Display Notify Party Information *********************
            dr = rs_CUSHPINF.Tables("RESULT").Select("csi_csetyp='NP'")
            If dr.Length = 1 Then
                strNotContractPerson = dr(0).Item("csi_csectp")
                strNotTitle = dr(0).Item("csi_csetil")
                strNotAdd = dr(0).Item("csi_cseadr")
                strNotSP = dr(0).Item("csi_csestt")
                strNotCountry = dr(0).Item("csi_csecty")
                strNotZIP = dr(0).Item("csi_csepst")
                strNotPhone = dr(0).Item("csi_csephn")
                strNotFax = dr(0).Item("csi_csefax")
                strNotEmail = dr(0).Item("csi_cseeml")
            Else
                strNotContractPerson = ""
                strNotTitle = ""
                strNotAdd = ""
                strNotSP = ""
                strNotCountry = ""
                strNotZIP = ""
                strNotPhone = ""
                strNotFax = ""
                strNotEmail = ""
            End If
        End If
    End Sub

    Private Sub fillcboShipMark(ByVal typ As String)
        Dim dr() As DataRow
        Dim dr_S() As DataRow
        Select Case typ
            Case "M"
                dr = rs_CUSHPMRK.Tables("RESULT").Select("csm_shptyp='M'")
                If Not rs_CUSHPMRK_S Is Nothing Then
                    If rs_CUSHPMRK_S.Tables.Count > 0 Then
                        dr_S = rs_CUSHPMRK_S.Tables("RESULT").Select("csm_shptyp='M'")
                    End If
                End If

            Case "S"
                dr = rs_CUSHPMRK.Tables("RESULT").Select("csm_shptyp='S'")
                If Not rs_CUSHPMRK_S Is Nothing Then
                    If rs_CUSHPMRK_S.Tables.Count > 0 Then
                        dr_S = rs_CUSHPMRK_S.Tables("RESULT").Select("csm_shptyp='S'")
                    End If
                End If
            Case "I"
                dr = rs_CUSHPMRK.Tables("RESULT").Select("csm_shptyp='I'")
                If Not rs_CUSHPMRK_S Is Nothing Then
                    If rs_CUSHPMRK_S.Tables.Count > 0 Then
                        dr_S = rs_CUSHPMRK_S.Tables("RESULT").Select("csm_shptyp='I'")
                    End If
                End If
        End Select
        cboShipMark.Items.Clear()
        cboShipMark.Items.Add("")
        If Trim(cboSecCust.Text) = "" Then
            If dr.Length > 0 Then
                'rs_CUSHPMRK.sort = "csm_imgnam"
                For i As Integer = 0 To dr.Length - 1
                    If Trim(dr(i).Item("csm_imgnam")) <> "" Then
                        cboShipMark.Items.Add(dr(i).Item("csm_imgnam"))
                    End If
                Next
            End If
        ElseIf Not rs_CUSHPMRK_S Is Nothing Then
            If rs_CUSHPMRK_S.Tables.Count > 0 Then
                If dr_S.Length > 0 Then
                    'rs_CUSHPMRK.sort = "csm_imgnam"
                    For i As Integer = 0 To dr_S.Length - 1
                        If Trim(dr_S(i).Item("csm_imgnam")) <> "" Then
                            cboShipMark.Items.Add(dr_S(i).Item("csm_imgnam"))
                        End If
                    Next
                End If
            End If
        End If
    End Sub

    Private Sub EnterKeyPressed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSCNo.KeyPress
        If Asc(e.KeyChar) = 13 Then
            cmdFind.PerformClick()
        End If
    End Sub

    Private Sub DisplayShpMrk(ByVal typ As String)
        Dim pth As String
        Dim shptype As String
        '*******Check the ShipMark Type******************
        If optMain.Checked = True Then
            shptype = "M"
        ElseIf optSide.Checked = True Then
            shptype = "S"
        Else
            shptype = "I"
        End If

        Dim dr() As DataRow

        Select Case typ
            Case "DropDown"
                If Trim(cboSecCust.Text) = "" Then
                    If rs_CUSHPMRK.Tables("RESULT").Rows.Count > 0 Then
                        ' picShipMark.Image = Nothing
                        dr = rs_CUSHPMRK.Tables("RESULT").Select("csm_imgnam =" & "'" & cboShipMark.Text & "'")
                        If dr.Length > 0 Then
                            Me.Cursor = Windows.Forms.Cursors.WaitCursor
                            pth = dr(0).Item("csm_imgpth")
                            ' txtImgPth.Text = pth
                            Try
                                ' picShipMark.Load(pth)
                            Catch ex As Exception

                            End Try
                            txtEngDsc.Text = dr(0).Item("csm_engdsc")
                            txtChiDsc.Text = dr(0).Item("csm_chndsc")
                            txtEngRmk.Text = dr(0).Item("csm_engrmk")
                            txtChiRmk.Text = dr(0).Item("csm_chnrmk")
                            Me.Cursor = Windows.Forms.Cursors.Default
                        End If
                    End If
                ElseIf Not rs_CUSHPMRK_S Is Nothing Then
                    If rs_CUSHPMRK_S.Tables("RESULT").Rows.Count > 0 Then
                        ' picShipMark.Image = Nothing
                        dr = rs_CUSHPMRK_S.Tables("RESULT").Select("csm_imgnam =" & "'" & cboShipMark.Text & "'")
                        If dr.Length > 0 Then
                            Me.Cursor = Windows.Forms.Cursors.WaitCursor
                            pth = dr(0).Item("csm_imgpth")
                            ' txtImgPth.Text = pth
                            Try
                                ' picShipMark.Load(pth)
                            Catch ex As Exception

                            End Try
                            txtEngDsc.Text = dr(0).Item("csm_engdsc")
                            txtChiDsc.Text = dr(0).Item("csm_chndsc")
                            txtEngRmk.Text = dr(0).Item("csm_engrmk")
                            txtChiRmk.Text = dr(0).Item("csm_chnrmk")
                            Me.Cursor = Windows.Forms.Cursors.Default
                        End If
                    End If
                End If

            Case "OPTION"

                If rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0 Then
                    dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = " & "'" & shptype & "'")
                    If dr.Length > 0 Then
                        Me.Cursor = Windows.Forms.Cursors.WaitCursor
                        dispSMFlag = True
                        If Trim(dr(0).Item("ssm_imgnam").ToString) = "" Then
                            cboShipMark.SelectedIndex = -1
                        Else
                            display_combo(dr(0).Item("ssm_imgnam").ToString, cboShipMark)
                        End If
                        dispSMFlag = False
                        ' txtImgPth.Text = dr(0).Item("ssm_imgpth")
                        txtEngDsc.Text = dr(0).Item("ssm_engdsc")
                        txtChiDsc.Text = dr(0).Item("ssm_chndsc")
                        txtEngRmk.Text = dr(0).Item("ssm_engrmk")
                        txtChiRmk.Text = dr(0).Item("ssm_chnrmk")

                        If dr(0).Item("ssm_creusr").ToString = "~*DEL*~" Or dr(0).Item("ssm_creusr").ToString = "~*NEW*~" Then
                            chkDelShp.Checked = True
                        Else
                            chkDelShp.Checked = False
                        End If
                        Try
                            ' picShipMark.Load(dr(0).Item("ssm_imgpth"))
                        Catch ex As Exception

                        End Try
                        Me.Cursor = Windows.Forms.Cursors.Default
                    End If
                Else
                    cboShipMark.SelectedIndex = -1
                End If

        End Select
    End Sub

    Private Sub cmdDtlNext_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDtlNext.Click
        If currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count - 1 Then
            If DtlInputisVaild() Then
                skipDVErrorFlag = True
                recordMove("NEXT")
                skipDVErrorFlag = False
            End If
        End If
    End Sub

    Private Sub cmdDtlBack_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDtlBack.Click
        If currentRow > 0 Then
            If DtlInputisVaild() Then
                skipDVErrorFlag = True
                recordMove("BACK")
                skipDVErrorFlag = False
            End If
        End If
    End Sub

    Private Sub Display_Dis()
        With grdDis
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        .Columns(i).HeaderText = "Del"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 5
                        .Columns(i).HeaderText = "Code"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 6
                        .Columns(i).HeaderText = "Description"
                        .Columns(i).Width = 450
                        rs_SCDISPRM_D.Tables("RESULT").Columns(6).ReadOnly = False
                        .Columns(i).ReadOnly = False
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 7
                        .Columns(i).HeaderText = "Percentage/Amount"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 8
                        .Columns(i).HeaderText = "%"
                        .Columns(i).Width = 75
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 9
                        .Columns(i).HeaderText = "Amount"
                        .Columns(i).Width = 90
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next

        End With
    End Sub
    Private Sub Display_pre()
        With grdPre
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        .Columns(0).HeaderText = "Del"
                        .Columns(0).Width = 40
                        .Columns(0).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 5
                        .Columns(5).HeaderText = "Code"
                        .Columns(5).Width = 80
                        .Columns(5).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 6
                        .Columns(6).HeaderText = "Description"
                        .Columns(6).Width = 450
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 7
                        .Columns(7).HeaderText = "Percentage/Amount"
                        .Columns(7).Width = 120
                        .Columns(7).ReadOnly = True
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 8
                        .Columns(8).HeaderText = "%"
                        .Columns(8).Width = 75
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case 9
                        .Columns(9).HeaderText = "Amount"
                        .Columns(9).Width = 90
                        .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub Display_Summary()
        With dgSummary
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 2
                        dgSummary_OrdSeq = i
                        .Columns(i).HeaderText = "Seq"
                        .Columns(i).Width = 30
                        .Columns(i).ReadOnly = True
                    Case 3
                        dgSummary_UpdPO = i
                        .Columns(i).HeaderText = "PO"
                        .Columns(i).Width = 30
                        .Columns(i).ReadOnly = True
                    Case 4
                        dgSummary_ChgFty = i
                        .Columns(i).HeaderText = "Fty"
                        .Columns(i).Width = 30
                        .Columns(i).ReadOnly = True
                    Case 5
                        dgSummary_CVName = i
                        .Columns(i).HeaderText = "C.V."
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 7
                        dgSummary_PVName = i
                        .Columns(i).HeaderText = "P.V."
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 9
                        dgSummary_TVName = i
                        .Columns(i).HeaderText = "T.V."
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 10
                        dgSummary_FAName = i
                        .Columns(i).HeaderText = "F.A."
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 11
                        dgSummary_PurOrd = i
                        .Columns(i).HeaderText = "PO #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 12
                        dgSummary_JobOrd = i
                        .Columns(i).HeaderText = "JOB #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 13
                        dgSummary_RunNo = i
                        .Columns(i).HeaderText = "Running No."
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 14
                        dgSummary_PJobNo = i
                        .Columns(i).HeaderText = "P.JOB #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 15
                        dgSummary_Itmno = i
                        .Columns(i).HeaderText = "Item #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 16
                        dgSummary_CusStyNo = i
                        .Columns(i).HeaderText = "Cust Sty #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 17
                        dgSummary_CusItm = i
                        .Columns(i).HeaderText = "Cust Item #"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 18
                        dgSummary_CusSKU = i
                        .Columns(i).HeaderText = "Cust SKU #"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 19
                        dgSummary_SecCusItm = i
                        .Columns(i).HeaderText = "Sec Cust Item #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 25
                        dgSummary_ColPck = i
                        .Columns(i).HeaderText = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/TranTrm)"
                        .Columns(i).Width = 210
                        .Columns(i).ReadOnly = True
                    Case 37
                        dgSummary_PrcGrp = i
                        .Columns(i).HeaderText = "Prc Grp"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 38
                        dgSummary_EffDat = i
                        .Columns(i).HeaderText = "Eff Date"
                        .Columns(i).Width = 70
                        .Columns(i).ReadOnly = True
                    Case 39
                        dgSummary_ExpDat = i
                        .Columns(i).HeaderText = "Exp Date"
                        .Columns(i).Width = 70
                        .Columns(i).ReadOnly = True
                    Case 40
                        dgSummary_PckItr = i
                        .Columns(i).HeaderText = "Packing Instruction"
                        .Columns(i).Width = 140
                        .Columns(i).ReadOnly = True
                    Case 41
                        dgSummary_ColDsc = i
                        .Columns(i).HeaderText = "Color Desc"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 47
                        dgSummary_OrdQty = i
                        .Columns(i).HeaderText = "Qty"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 48
                        dgSummary_ShpQty = i
                        .Columns(i).HeaderText = "Ship Qty"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 49
                        dgSummary_OutQty = i
                        .Columns(i).HeaderText = "O/S Qty"
                        .Columns(i).Width = 40
                        .Columns(i).DefaultCellStyle.Format = "#0"
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 51
                        dgSummary_OnePrc = i
                        .Columns(i).HeaderText = "OTP"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    Case 52
                        dgSummary_CurCde = i
                        .Columns(i).HeaderText = "CCY"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        If lblSubttlCur.Visible = False Then
                            .Columns(i).Visible = False
                        Else
                            .Columns(i).Visible = True
                        End If
                        'Case 45
                        '    .Columns(i).HeaderText = "Net SelPrc"
                        '    .Columns(i).Width = 60
                        '    .Columns(i).ReadOnly = True
                        '    .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        '    If txtNetUntPrc.Visible = False Then
                        '        .Columns(i).Visible = False
                        '    Else
                        '        .Columns(i).Visible = True
                        '    End If
                    Case 54
                        dgSummary_SelPrc = i
                        .Columns(i).HeaderText = "SelPrc"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        'If txtUntPrc.Visible = False Then
                        If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                            .Columns(i).Visible = False
                        Else
                            .Columns(i).Visible = True
                        End If
                    Case 56
                        dgSummary_MinPrc = i
                        .Columns(i).HeaderText = "MinMUPrc"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        'If txtItmBasprc.Visible = False Then
                        If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                            .Columns(i).Visible = False
                        Else
                            .Columns(i).Visible = True
                        End If
                    Case 57
                        dgSummary_BasPrc = i
                        .Columns(i).HeaderText = "BasPrc"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        'If txtItmBasprc.Visible = False Then
                        If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                            .Columns(i).Visible = False
                        Else
                            .Columns(i).Visible = True
                        End If
                    Case 70
                        dgSummary_CtnStr = i
                        .Columns(i).HeaderText = "Start Ctn"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 71
                        dgSummary_CtnEnd = i
                        .Columns(i).HeaderText = "End Ctn"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 72
                        dgSummary_TtlCtn = i
                        .Columns(i).HeaderText = "Ttl Ctn"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 74
                        dgSummary_MOQ = i
                        .Columns(i).HeaderText = "MOQ"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 75
                        dgSummary_MOQUntTyp = i
                        .Columns(i).HeaderText = "MOQ Unt Type"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                        'Case 75
                        '    dgSummary_MOQChg = i
                        '    .Columns(i).HeaderText = "MOQ Chg %"
                        '    .Columns(i).Width = 55
                        '    .Columns(i).ReadOnly = True
                        '    .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 77
                        dgSummary_SubTtl = i
                        .Columns(i).HeaderText = "Sub Ttl"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Format = "#0.##"
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        'If txtSelprc.Visible = False Then
                        If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                            .Columns(i).Visible = False
                        Else
                            .Columns(i).Visible = True
                        End If
                    Case 78
                        dgSummary_MOA = i
                        .Columns(i).HeaderText = "MOA"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Format = "#0.####"
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 93
                        dgSummary_Apprve = i
                        .Columns(i).HeaderText = "Req. Approval"
                        .Columns(i).Width = 50
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    Case 94
                        dgSummary_ShpStr = i
                        .Columns(i).HeaderText = "SC Shp Str"
                        .Columns(i).Width = 80
                        .Columns(i).DefaultCellStyle.Format = "MM/dd/yyyy"
                        .Columns(i).ReadOnly = True
                    Case 95
                        dgSummary_ShpEnd = i
                        .Columns(i).HeaderText = "SC Shp End"
                        .Columns(i).Width = 80
                        .Columns(i).DefaultCellStyle.Format = "MM/dd/yyyy"
                        .Columns(i).ReadOnly = True
                    Case 96
                        dgSummary_CanDat = i
                        .Columns(i).HeaderText = "SC Cancel Date"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 97
                        dgSummary_CanDat = i
                        .Columns(i).HeaderText = "PO Shp Str"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 98
                        dgSummary_CanDat = i
                        .Columns(i).HeaderText = "PO Shp End"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 99
                        dgSummary_CanDat = i
                        .Columns(i).HeaderText = "PO Cancel Date"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case 100
                        dgSummary_FCurCde = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "PV Fty Cur"
                            .Columns(i).Width = 47
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 101
                        dgSummary_FtyCst = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "PV Itm Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 102
                        dgSummary_BOMCst = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "PV BOM Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 103
                        dgSummary_FtyPrc = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "PV Ttl Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 106
                        dgSummary_DVFCurCde = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "DV Fty Cur"
                            .Columns(i).Width = 47
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 107
                        dgSummary_DVFtyCst = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "DV Itm Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 108
                        dgSummary_DVBOMCst = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "DV BOM Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 109
                        dgSummary_DVFtyPrc = i
                        If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                            .Columns(i).HeaderText = "DV Ttl Cst"
                            .Columns(i).Width = 80
                            .Columns(i).ReadOnly = True
                            .Columns(i).DefaultCellStyle.Format = "#0.####"
                            .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                        Else
                            .Columns(i).Visible = False
                        End If
                    Case 118
                        dgSummary_HrmCde = i
                        .Columns(i).HeaderText = "HSTU/Tariff #"
                        .Columns(i).Width = 110
                        .Columns(i).ReadOnly = True
                    Case 119
                        dgSummary_DtyRat = i
                        .Columns(i).HeaderText = "Duty"
                        .Columns(i).DefaultCellStyle.Format = "#0.####"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                    Case 122
                        dgSummary_Code1 = i
                        .Columns(i).HeaderText = "UPC/EAN (M)"
                        .Columns(i).Width = 110
                        .Columns(i).ReadOnly = True
                    Case 123
                        dgSummary_Code2 = i
                        .Columns(i).HeaderText = "UPC/EAN (I)"
                        .Columns(i).Width = 110
                        .Columns(i).ReadOnly = True
                    Case 124
                        dgSummary_Code3 = i
                        .Columns(i).HeaderText = "UPC/EAN (C)"
                        .Columns(i).Width = 110
                        .Columns(i).ReadOnly = True
                    Case 125
                        dgSummary_CusUSDCur = i
                        .Columns(i).HeaderText = "Retail 1 Curr"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 126
                        dgSummary_CusUSD = i
                        .Columns(i).HeaderText = "Retail 1 Amt"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Format = "#0.00##"
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 127
                        dgSummary_CusCADCur = i
                        .Columns(i).HeaderText = "Retail 2 Curr"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 128
                        dgSummary_CusCAD = i
                        .Columns(i).HeaderText = "Retail 2 Amt"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                        .Columns(i).DefaultCellStyle.Format = "#0.00##"
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    Case 129
                        dgSummary_AlsItmno = i
                        .Columns(i).HeaderText = "Alias Item"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 130
                        dgSummary_AlsColCde = i
                        .Columns(i).HeaderText = "Alias Color"
                        .Columns(i).Width = 50
                        .Columns(i).ReadOnly = True
                        'Case 124
                        '.Columns(i).HeaderText = "UM Factor"
                        '.Columns(i).Width = 60
                        '.Columns(i).ReadOnly = True
                    Case 132
                        dgSummary_ConToPC = i
                        .Columns(i).HeaderText = "Convert to PC"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                    Case 133
                        dgSummary_PCPrc = i
                        .Columns(i).HeaderText = "Price for PC"
                        .Columns(i).Width = 65
                        .Columns(i).DefaultCellStyle.Format = "#0.####"
                        .Columns(i).ReadOnly = True
                    Case 134
                        dgSummary_CustUM = i
                        .Columns(i).HeaderText = "Cust UM"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With

        dgSummary.ClearSelection()
    End Sub

    Private Sub cmdAss_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdAss.Click
        loadPanDtlASS()
        freeze_TabControl(tabFrame_Detail)
        grpDetail.Enabled = False
        panDtlASS.Width = 640
        panDtlASS.Height = 293
        panDtlASS.Location = New Point(150, 207)
        panDtlASS.Visible = True
        recordStatus_dtl = True
    End Sub

    Private Sub cmdBOM_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdBOM.Click
        Enq_right = Enq_right_local
        recordStatus = True

        If BOM_SUB Is Nothing Then
            BOM_SUB = New SCM00001_BOM
            BOM_SUB.myOwner = Me
        End If

        BOM_SUB.ShowDialog()
        recordStatus_dtl = True
    End Sub

    Private Sub cmdItmCstEn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdItmCstEn.Click
        txtItmCst.Enabled = True
        txtBOMCst.Enabled = True
        txtTtlCst.Enabled = True
        txtDVItmCst.Enabled = True
        txtDVBOMCst.Enabled = True
        txtDVTtlCst.Enabled = True
        txtIMPeriod.Enabled = True
    End Sub

    Private Sub tabChange(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tabFrame.SelectedIndexChanged
        focusedObject = ""

        If prev_tab = tabFrame_Detail Then
            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                If txtItmno.Text.Length > 0 Then
                    If DtlInputisVaild() = False Then
                        recordMove("TAB")
                        tabFrame.SelectTab(tabFrame_Detail)
                        Exit Sub
                    End If
                    recordMove("TAB")
                Else
                    If chkDelDtl.Checked = False Then
                        recordMove("TAB")
                    End If
                End If
            Else
                Exit Sub
            End If
            'ElseIf prev_tab = tabFrame_Summary Then
            '    rs_SCORDDTL = rs_SCORDDTL_Summary.Copy()
        End If

        If tabFrame.SelectedIndex = tabFrame_Header Then
            If Not rs_SCORDDTL Is Nothing And Trim(cboPriCust.Text) <> "" Then
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    If txtItmno.Text <> "" Then
                        If DtlInputisVaild() And chkDelDtl.Checked = False Then
                            updateDetailRS()
                        Else
                            prev_tab = tabFrame.SelectedIndex
                            Exit Sub
                        End If
                    Else
                        prev_tab = tabFrame.SelectedIndex
                        Exit Sub
                    End If
                End If
                Cal_TotalAmt()
            End If
            If addFlag = True And cboPriCust.Enabled = True Then
                If cboPriCust.Enabled And cboPriCust.Visible Then cboPriCust.Focus()
            Else
                If txtBillAdd.Enabled = True Then
                    'txtBillAdd.SetFocus
                    If cboBillAdd.Enabled And cboBillAdd.Visible Then cboBillAdd.Focus()
                End If
            End If
        ElseIf tabFrame.SelectedIndex = tabFrame_Detail Then
            prev_tab = tabFrame.SelectedIndex
            skipDVErrorFlag = True
            recordMove("LOAD")
            skipDVErrorFlag = False
        ElseIf tabFrame.SelectedIndex = tabFrame_Shpmrk Then
            If optMain.Checked = False And optSide.Checked = False And optInner.Checked = False Then
                If Split(cboPriCust.Text, " - ")(0).ToString.Length = 5 Then
                    optMain.Checked = True
                End If
            End If
        ElseIf tabFrame.SelectedIndex = tabFrame_Summary Then
            prev_tab = tabFrame.SelectedIndex
            rs_SCORDDTL_Summary = rs_SCORDDTL.Copy()
            dv_sum = rs_SCORDDTL_Summary.Tables("RESULT").DefaultView
            initFlag = True
            dgSummary.DataSource = dv_sum
            Display_Summary()
            initFlag = False
            'Else
            '    prev_tab = tabFrame.SelectedIndex
        End If

        prev_tab = tabFrame.SelectedIndex
    End Sub

    Private Sub tabFrame_Selecting(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TabControlCancelEventArgs) Handles tabFrame.Selecting
        If tabFrame.TabPages(e.TabPageIndex).Enabled = False And initFlag = False Then
            e.Cancel = True
        End If

        If initFlag = False Then
            If prev_tab = tabFrame_Header Then
                If txtCustPoDat.Text.Length <> 10 Or Not IsDate(txtCustPoDat.Text) Then
                    e.Cancel = True
                    'MsgBox("Invalid Customer PO Date (MM/DD/YYYY)")
                    txtCustPoDat.Focus()
                    txtCustPoDat.SelectAll()
                    Exit Sub
                End If

                If txtStartShipDat.Text.Length <> 10 Or Not IsDate(txtStartShipDat.Text) Then
                    e.Cancel = True
                    'MsgBox("Invalid Ship Start Date (MM/DD/YYYY)")
                    txtStartShipDat.Focus()
                    txtStartShipDat.SelectAll()
                    Exit Sub
                End If

                If txtEndShipDat.Text.Length <> 10 Or Not IsDate(txtEndShipDat.Text) Then
                    e.Cancel = True
                    'MsgBox("Invalid Ship End Date (MM/DD/YYYY)")
                    txtEndShipDat.Focus()
                    txtEndShipDat.SelectAll()
                    Exit Sub
                End If

                'If txtCancelDat.Text.Length <> 10 Or Not IsDate(txtCancelDat.Text) Then
                '    e.Cancel = True
                '    'MsgBox("Invalid Cancel Date (MM/DD/YYYY)")
                '    txtCancelDat.Focus()
                '    txtCancelDat.SelectAll()
                '    Exit Sub
                'End If
            ElseIf prev_tab = tabFrame_Detail Then
                If txtTentOrdno.Text <> "" And txtTentOrdSeq.Text = "" Then
                    e.Cancel = True
                    MsgBox("Tentative Order No. has not been matched yet")
                    txtTentOrdno.Focus()
                    txtTentOrdno.SelectAll()
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Private Sub shpmrkTypChange(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optMain.CheckedChanged, optSide.CheckedChanged, optInner.CheckedChanged
        If initFlag = False Then
            recordStatus = True
            If optMain.Checked = True Then
                UpdateShipMark()
                auto_assign_SMrs()
                fillcboShipMark("M")
                DisplayShpMrk("OPTION")
                prevShpMrkTyp = "M"
            ElseIf optSide.Checked = True Then
                UpdateShipMark()
                auto_assign_SMrs()
                fillcboShipMark("S")
                DisplayShpMrk("OPTION")
                prevShpMrkTyp = "S"
            ElseIf optInner.Checked = True Then
                UpdateShipMark()
                auto_assign_SMrs()
                fillcboShipMark("I")
                DisplayShpMrk("OPTION")
                prevShpMrkTyp = "I"
            End If
        End If
    End Sub

    Private Sub UpdateShipMark()
        Dim dr() As DataRow

        If prevShpMrkTyp = "M" Then
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'M'")
        ElseIf prevShpMrkTyp = "S" Then
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'S'")
        ElseIf prevShpMrkTyp = "I" Then 'optInner.Checked = True Then
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'I'")
        End If

        If Not dr Is Nothing Then
            If dr.Length > 0 Then
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_imgnam").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_imgpth").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_engdsc").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_chndsc").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_engrmk").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_chnrmk").ReadOnly = False
                rs_SCSHPMRK.Tables("RESULT").Columns("ssm_creusr").ReadOnly = False

                dr(0).Item("ssm_imgnam") = cboShipMark.Text
                dr(0).Item("ssm_imgpth") = "" 'txtImgPth.Text
                dr(0).Item("ssm_engdsc") = txtEngDsc.Text
                dr(0).Item("ssm_chndsc") = txtChiDsc.Text
                dr(0).Item("ssm_engrmk") = txtEngRmk.Text
                dr(0).Item("ssm_chnrmk") = txtChiRmk.Text
                If dr(0).Item("ssm_creusr").ToString <> "~*ADD*~" And dr(0).Item("ssm_creusr").ToString <> "~*DEL*~" And _
                   dr(0).Item("ssm_creusr").ToString <> "~*NEW*~" Then
                    dr(0).Item("ssm_creusr") = "~*UPD*~"
                End If
            End If
        End If
    End Sub

    Private Sub auto_assign_SMrs()
        Dim dr() As DataRow
        Dim shptype As String

        ' -- Check Ship Mark Type --
        If optMain.Checked = True Then
            shptype = "M"
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'M'")
        ElseIf optSide.Checked = True Then
            shptype = "S"
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'S'")
        Else
            shptype = "I"
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'I'")
        End If

        If rs_SCSHPMRK.Tables("RESULT").Rows.Count = 0 Then
            Dim newRow As DataRow = rs_SCSHPMRK.Tables("RESULT").NewRow
            newRow.Item("ssm_shptyp") = shptype
            newRow.Item("ssm_engdsc") = ""
            newRow.Item("ssm_chndsc") = ""
            newRow.Item("ssm_engrmk") = ""
            newRow.Item("ssm_chnrmk") = ""
            newRow.Item("ssm_imgpth") = ""
            newRow.Item("ssm_creusr") = "~*ADD*~"
            rs_SCSHPMRK.Tables("RESULT").Rows.Add(newRow)
            chkDelShp.Checked = False
        Else
            If dr.Length = 0 Then
                Dim newRow As DataRow = rs_SCSHPMRK.Tables("RESULT").NewRow
                newRow.Item("ssm_shptyp") = shptype
                newRow.Item("ssm_engdsc") = ""
                newRow.Item("ssm_chndsc") = ""
                newRow.Item("ssm_engrmk") = ""
                newRow.Item("ssm_chnrmk") = ""
                newRow.Item("ssm_imgpth") = ""
                newRow.Item("ssm_creusr") = "~*ADD*~"
                rs_SCSHPMRK.Tables("RESULT").Rows.Add(newRow)
                chkDelShp.Checked = False
            End If
        End If
    End Sub

    Private Sub chkDelShp_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkDelShp.CheckedChanged
        recordStatus = True
        Dim dr() As DataRow
        If optMain.Checked = True Then
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'M'")
        ElseIf optSide.Checked = True Then
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'S'")
        Else
            dr = rs_SCSHPMRK.Tables("RESULT").Select("ssm_shptyp = 'I'")
        End If
        If chkDelShp.Enabled = True And dr.Length > 0 Then
            rs_SCSHPMRK.Tables("RESULT").Columns("ssm_creusr").ReadOnly = False
            If chkDelShp.Checked = True Then
                If dr(0).Item("ssm_creusr").ToString <> "~*ADD*~" And dr(0).Item("ssm_creusr").ToString <> "~*NEW*~" Then
                    dr(0).Item("ssm_creusr") = "~*DEL*~"
                ElseIf dr(0).Item("ssm_creusr").ToString = "~*ADD*~" Then
                    dr(0).Item("ssm_creusr") = "~*NEW*~"
                End If
            Else
                If dr(0).Item("ssm_creusr").ToString = "~*NEW*~" Then
                    dr(0).Item("ssm_creusr") = "~*ADD*~"
                ElseIf dr(0).Item("ssm_creusr").ToString <> "~*NEW*~" And dr(0).Item("ssm_creusr").ToString <> "~*ADD*~" Then
                    dr(0).Item("ssm_creusr") = "~*UPD*~"
                End If
            End If
        End If
    End Sub

    Private Sub grdDisPre_CellBeginEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles grdDis.CellBeginEdit, grdPre.CellBeginEdit
        recordStatus = True
        DisPreEditCellRow = sender.CurrentCell.RowIndex
        DisPreEditCellCol = sender.CurrentCell.ColumnIndex
    End Sub

    Private Sub grdDisPre_CellEndEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdDis.CellEndEdit, grdPre.CellEndEdit
        If DisPreEditCellCol = 5 Then
            If sender.name = "grdDis" Then
                textboxCombo(sender, "Discount")
            Else
                textboxCombo(sender, "Premium")
            End If

        End If
    End Sub

    Private Sub objFocused(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles grdDis.Enter, grdPre.Enter
        If grdDis.Focused = True Then
            focusedObject = "grdDis"
            lblDisInfo.ForeColor = Color.Green
            lblPreInfo.ForeColor = Color.Black
        ElseIf grdPre.Focused = True Then
            focusedObject = "grdPre"
            lblDisInfo.ForeColor = Color.Black
            lblPreInfo.ForeColor = Color.Green
        End If
    End Sub



    Private Sub cboShipMark_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboShipMark.SelectedIndexChanged
        recordStatus = True

        If dispSMFlag = False And cboShipMark.Enabled = True Then
            '**********Update Previous Value***********************
            UpdateShipMark()

            auto_assign_SMrs()
            '*********Display Ship Mark****************************

            If cboShipMark.Text <> "" Then
                DisplayShpMrk("DropDown")
            Else
                Reset_ShipMark()
            End If

            UpdateShipMark()
        End If
    End Sub

    Private Function DtlInputisVaild() As Boolean
        Dim Err As String
        Dim colpck As Integer

        If IsNumeric(txtUntPrc.Text) = False Then
            txtUntPrc.Text = 0
        End If
        If IsNumeric(txtDiscount.Text) = False Then
            txtDiscount.Text = 0
        End If
        If IsNumeric(txtDuty.Text) = False Then
            txtDuty.Text = 0
        End If
        If IsNumeric(txtTtlCst.Text) = False Then
            txtTtlCst.Text = 0
        End If
        If IsNumeric(txtItmCst.Text) = False Then
            txtItmCst.Text = 0
        End If

        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 And chkDelDtl.Checked = False And cboPriCust.Text <> "" Then
            If Not Valid_Colpck() Then
                Return False
            ElseIf Split(lblColPckType.Text, strColPck)(1) = "" Then
                setDtlStatus("ADD")
                Display_Dtl("CUITMPRC")
                recordMove("DEL")
            End If

            If txtItmno.Text = "" Then
                Exit Function
            End If

            If cboColPckInfo.Text <> "" Then
                colpck = Split(cboColPckInfo.Text, " / ")(3)
            End If

            If Trim(txtItmno.Text) = "" And txtItmno.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the Item No.", MsgBoxStyle.Information, "Message")

                If txtItmno.Enabled And txtItmno.Visible Then
                    txtItmno.Focus()
                End If
                Return False
            ElseIf Trim(cboColPckInfo.Text) = "" Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please Select the Color Packing!", MsgBoxStyle.Information, "Message")

                If cboColPckInfo.Enabled And cboColPckInfo.Visible Then
                    cboColPckInfo.Focus()
                ElseIf txtItmno.Enabled And txtItmno.Visible Then
                    txtItmno.Focus()
                End If
                Return False
            ElseIf Trim(txtOrdQty.Text) = "" Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the Order Qty", MsgBoxStyle.Information, "Message")
                If txtOrdQty.Enabled And txtOrdQty.Visible Then txtOrdQty.Focus()
                Return False
            ElseIf CLng(Trim(txtOrdQty.Text)) = 0 And txtSCVerNo.Text = 1 And Split(cboSCStatus.Text, " - ")(0) <> "CAN" Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Order Qty cannot be Zero!", MsgBoxStyle.Exclamation, "Message")
                Cal_DtlTotalCtn(txtOrdQty.Text)
                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, 0)
                If txtOrdQty.Enabled And txtOrdQty.Visible Then txtOrdQty.Focus()
                Exit Function
            ElseIf CLng(txtOrdQty.Text) < CLng(txtShipped.Text) And txtSCVerNo.Text <> 1 Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Order Qty < Shipped Qty !", MsgBoxStyle.Information, "Message")
                Cal_DtlTotalCtn(txtOrdQty.Text)
                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, 0)
                If txtOrdQty.Enabled And txtOrdQty.Visible Then txtOrdQty.Focus()
                Exit Function
            ElseIf Split(cboColPckInfo.Text, " / ")(3) = "0" Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Order Qty not Divisible by Master Qty", MsgBoxStyle.Exclamation, "Message")
                Cal_DtlTotalCtn(txtOrdQty.Text)
                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, 0)
                If txtOrdQty.Enabled And txtOrdQty.Visible Then txtOrdQty.Focus()
                DtlInputisVaild = False
                Exit Function
            ElseIf Trim(txtOrdQty.Text) Mod colpck <> 0 And txtOrdQty.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Order Qty not Divisible by Master Qty", MsgBoxStyle.Exclamation, "Message")
                Cal_DtlTotalCtn(txtOrdQty.Text)
                Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text, IIf(txtMOQChg.Text = "", 0, txtMOQChg.Text))
                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)
                If txtOrdQty.Enabled And txtOrdQty.Visible Then txtOrdQty.Focus()
                Return False
            ElseIf Trim(txtDiscount.Text) = "" And txtDiscount.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the Discount", MsgBoxStyle.Information, "Message")
                If txtDiscount.Enabled And txtDiscount.Visible Then txtDiscount.Focus()
                Return False
            ElseIf CDec(Trim(txtDiscount.Text)) > 100 And txtDiscount.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Discount % cannot over 100", MsgBoxStyle.Exclamation, "Message")
                txtDiscount.Text = 0
                Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text, IIf(txtMOQChg.Text = "", 0, txtMOQChg.Text))
                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)
                If txtDiscount.Enabled And txtDiscount.Visible Then txtDiscount.Focus()
                Return False
            ElseIf Trim(txtUntPrc.Text) = "" And txtUntPrc.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the Unit Price", MsgBoxStyle.Exclamation, "Message")
                Cal_DtlPrcSubTTl(0, txtDiscount.Text, Custfml, 0)
                If txtUntPrc.Enabled And txtUntPrc.Visible And txtUntPrc.ReadOnly = False Then txtUntPrc.Focus()
                Exit Function
            ElseIf CDbl(Trim(txtUntPrc.Text)) = 0 And txtUntPrc.Enabled = True And chkReplacement.Checked = 0 Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Unit Price Can't be Zero", MsgBoxStyle.Exclamation, "Message")
                Cal_DtlPrcSubTTl(0, txtDiscount.Text, Custfml, 0)
                If txtUntPrc.Enabled And txtUntPrc.Visible And txtUntPrc.ReadOnly = False Then txtUntPrc.Focus()
                Exit Function
            ElseIf (cboRetailUSDCur.Text = "" And CDbl(txtRetailUSD.Text) > 0) And cboRetailUSDCur.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Missing Currency Unit", MsgBoxStyle.Information, "Message")
                If cboRetailUSDCur.Enabled And cboRetailUSDCur.Visible Then cboRetailUSDCur.Focus()
                Return False
            ElseIf (cboRetailCADCur.Text = "" And CDbl(txtRetailCAD.Text) > 0) And cboRetailCADCur.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Missing Currency Unit", MsgBoxStyle.Information, "Message")
                If cboRetailCADCur.Enabled And cboRetailCADCur.Visible Then cboRetailCADCur.Focus()
                Return False
            ElseIf (cboRetailUSDCur.Text = cboRetailCADCur.Text And cboRetailUSDCur.Text <> "") And cboRetailUSDCur.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Duplicate Currency Unit", MsgBoxStyle.Information, "Message")
                If cboRetailUSDCur.Enabled And cboRetailUSDCur.Visible Then cboRetailUSDCur.Focus()
                Return False
            ElseIf Trim(txtStartCarton.Text) = "" And txtStartCarton.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the Strat Carton", MsgBoxStyle.Information, "Message")
                If txtStartCarton.Enabled And txtStartCarton.Visible Then txtStartCarton.Focus()
                Return False
            ElseIf Trim(txtEndCarton.Text) = "" And txtEndCarton.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Please input the End Carton", MsgBoxStyle.Information, "Message")
                If txtEndCarton.Enabled And txtEndCarton.Visible Then txtEndCarton.Focus()
                Return False
            ElseIf CLng(txtStartCarton.Text) > CLng(txtEndCarton.Text) And txtStartCarton.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Start Carton > End Carton !", MsgBoxStyle.Exclamation, "Message")
                If txtStartCarton.Enabled And txtStartCarton.Visible Then txtStartCarton.Focus()
                Return False
            ElseIf (CLng(txtEndCarton.Text) - CLng(txtStartCarton.Text) + 1) <> lblTotalCtn.Text And txtStartCarton.Text <> "0" _
                    And txtEndCarton.Text <> "0" And txtStartCarton.Enabled = True And chkCancel.Checked = False Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Not equal to the Total Carton Number !", MsgBoxStyle.Information, "Message")
                If txtStartCarton.Enabled And txtStartCarton.Visible Then
                    txtStartCarton.Focus()
                    'Else
                    'If cmdMoreCtn.Enabled And cmdMoreCtn.Visible Then cmdMoreCtn.Focus()
                End If
                Return False
            ElseIf CDate(txtStartShip.Text) > CDate(txtEndShip.Text) And txtStartShip.Enabled = True Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("SC Start Date > SC End Date !", MsgBoxStyle.Exclamation, "Message")
                If txtStartShip.Enabled And txtStartShip.Visible Then txtStartShip.Focus()
                Return False
                'ElseIf txtCanDat.Text = "  /  /" And Split(cboSCStatus.Text, " - ")(0) = "ACT" Then
                '    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                '        Detail_Err = True
                '        tabFrame.SelectTab(tabFrame_Detail)
                '        Detail_Err = False
                '    End If
                '    MsgBox("SC Cancel Date cannot be empty", MsgBoxStyle.Information, "Message")
                '    If txtCanDat.Enabled And txtCanDat.Visible Then txtCanDat.Focus()
                '    Return False
            ElseIf txtCanDat.Text <> "  /  /" Then
                If Not IsDate(txtCanDat.Text) Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("SC Cancel Date is not a valid date", MsgBoxStyle.Information, "Message")
                    If txtCanDat.Enabled And txtCanDat.Visible Then txtCanDat.Focus()
                    Return False
                End If
                If CDate(txtCanDat.Text) < CDate(txtEndShip.Text) And txtCanDat.Enabled = True Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("SC Cancel Date < SC Ship End Date !", MsgBoxStyle.Information, "Message")
                    If txtCanDat.Enabled And txtCanDat.Visible Then txtCanDat.Focus()
                    Return False
                End If
            End If

            If txtMOQ.Text <> "" And txtMOQUnttyp.Text = "" Then
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("Missing MOQ UM", MsgBoxStyle.Exclamation, "Message")
                Return False
            End If

            If Split(lblColPckType.Text, " : ").Length > 1 Then
                If Split(lblColPckType.Text, " : ")(1) = "ASS" And txtUM.Text = "ST" And (txtConftr.Text = "" Or txtConftr.Text = "1") Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("Invalid Conversion Factor", MsgBoxStyle.Exclamation, "Message")
                    Return False
                End If
            End If

            If txtSCVerNo.Text = "1" Then
                If txtPOStartShip.Text = "  /  /" And txtPOEndShip.Text <> "  /  /" Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("Missing PO Start Date", MsgBoxStyle.Information, "Message")
                    If txtPOStartShip.Enabled And txtPOStartShip.Visible Then txtPOStartShip.Focus()
                    Return False
                ElseIf txtPOStartShip.Text <> "  /  /" And txtPOEndShip.Text = "  /  /" Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("Missing PO End Date", MsgBoxStyle.Information, "Message")
                    If txtPOStartShip.Enabled And txtPOStartShip.Visible Then txtPOStartShip.Focus()
                    Return False
                ElseIf txtPOStartShip.Text <> "  /  /" And txtPOEndShip.Text <> "  /  /" Then
                    If CDate(txtPOStartShip.Text) > CDate(txtPOEndShip.Text) And txtPOStartShip.Enabled = True Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("PO Start Date > PO End Date !", MsgBoxStyle.Exclamation, "Message")
                        If txtStartShip.Enabled And txtStartShip.Visible Then txtStartShip.Focus()
                        Return False
                    End If
                End If
            Else
                If txtPOStartShip.Text = "  /  /" Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("PO Start Date is not a valid date", MsgBoxStyle.Information, "Message")
                    If txtPOStartShip.Enabled And txtPOStartShip.Visible Then txtPOStartShip.Focus()
                    Return False
                ElseIf txtPOEndShip.Text = "  /  /" Then
                    If tabFrame.SelectedIndex <> tabFrame_Detail Then
                        Detail_Err = True
                        tabFrame.SelectTab(tabFrame_Detail)
                        Detail_Err = False
                    End If
                    MsgBox("PO End Date is not a valid date", MsgBoxStyle.Information, "Message")
                    If txtPOEndShip.Enabled And txtPOEndShip.Visible Then txtPOEndShip.Focus()
                    Return False
                Else
                    If CDate(txtPOStartShip.Text) > CDate(txtPOEndShip.Text) And txtPOStartShip.Enabled = True Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("PO Start Date > PO End Date !", MsgBoxStyle.Exclamation, "Message")
                        If txtStartShip.Enabled And txtStartShip.Visible Then txtStartShip.Focus()
                        Return False
                    End If
                End If

                If txtPOCanDat.Text <> "  /  /" Then
                    If Not IsDate(txtPOCanDat.Text) Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("PO Cancel Date is not a valid date", MsgBoxStyle.Information, "Message")
                        If txtPOCanDat.Enabled And txtPOCanDat.Visible Then txtPOCanDat.Focus()
                        Return False
                    End If
                    If CDate(txtPOCanDat.Text) < CDate(txtPOEndShip.Text) And txtPOCanDat.Enabled = True Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("PO Cancel Date < PO Ship End Date !", MsgBoxStyle.Information, "Message")
                        If txtPOCanDat.Enabled And txtPOCanDat.Visible Then txtPOCanDat.Focus()
                        Return False
                    End If
                End If
            End If

            Dim ttl As Long
            ttl = 0
            If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And _
                 txtStartShip.Enabled = False Then
                '***********************Check the more Ship****************************************
                Dim dr_SCDTLSHP() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = " & "'" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "' and sds_status = ' ' ")
                If dr_SCDTLSHP.Length > 0 Then
                    For i As Integer = 0 To dr_SCDTLSHP.Length - 1
                        ttl = ttl + dr_SCDTLSHP(i).Item("sds_ordqty")
                    Next
                    If ttl <> CLng(txtOrdQty.Text) Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("More Ship Qty not equal to Detail Order Qty", MsgBoxStyle.Information, "Message")
                        Return False
                    End If
                End If
            End If
            ttl = 0
            If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And _
                    txtStartCarton.Text <> "0" And txtEndCarton.Text <> "0" And txtStartCarton.Enabled = False Then
                '***********************Check the more Carton***************************************
                Dim dr_SCDTLSHP() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = " & "'" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq") & "' and sds_status = ' ' ")
                If dr_SCDTLSHP.Length > 0 Then
                    For i As Integer = 0 To dr_SCDTLSHP.Length - 1
                        ttl = ttl + dr_SCDTLSHP(i).Item("sds_ttlctn")
                    Next
                    If ttl <> CLng(lblTotalCtn.Text) Then
                        If tabFrame.SelectedIndex <> tabFrame_Detail Then
                            Detail_Err = True
                            tabFrame.SelectTab(tabFrame_Detail)
                            Detail_Err = False
                        End If
                        MsgBox("More Total Carton not equal to Detail", MsgBoxStyle.Information, "Message")
                        Return False
                    End If
                End If
            End If

            If txtTentOrdno.Text <> "" And txtTentOrdSeq.Text = "" Then
                MsgBox("Tentative Order No. has not been matched yet", MsgBoxStyle.Information, "Message")
                Return False
            End If

            Return True
        End If
        Return True
    End Function

    Function Valid_Colpck() As Boolean
        If currentRow < 0 Then
            Exit Function
        End If

        If rs_SCORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Return False
        End If
        If Trim(txtItmno.Text) = "" And txtItmno.Enabled = True Then
            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                Detail_Err = True
                tabFrame.SelectTab(tabFrame_Detail)
                Detail_Err = False
            End If
            MsgBox("Please input the Item No.")
            If txtItmno.Enabled And txtItmno.Visible Then
                txtItmno.Focus()
            End If
            Return False
        ElseIf Trim(cboColPckInfo.Text) = "" Then
            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                Detail_Err = True
                tabFrame.SelectTab(tabFrame_Detail)
                Detail_Err = False
            End If
            MsgBox("Please Select the Color Packing!")
            If cboColPckInfo.Enabled And cboColPckInfo.Visible Then
                cboColPckInfo.Focus()
            End If
            Return False
        End If
        If historyFlag = True And cboColPckInfo.Enabled = True Then
            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                Detail_Err = True
                tabFrame.SelectTab(tabFrame_Detail)
                Detail_Err = False
            End If
            MsgBox("This Item is an Inactive Item") 'Item in History
            Display_Dtl("ADD")
            setDtlStatus("FIND")
            cboColPckInfo.SelectedIndex = -1
            If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
            Return False
        ElseIf historyFlag = False And cboColPckInfo.Enabled = True Then
            Dim dr() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_itmno = " & "'" & Trim(txtItmno.Text) & "' and sod_colpck = '" & Replace(cboColPckInfo.Text, "'", "''") & "' and sod_ordseq <> '" & Trim(lblDtlSeq.Text) & "' and (sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~')")
            If dr.Length = 0 Then
                If rs_CUITMPRC.Tables.Count = 0 Then
                    Return True
                End If
                If rs_CUITMPRC.Tables("RESULT").Rows.Count > 0 Then
                    Dim dr_CUITMPRC() As DataRow = rs_CUITMPRC.Tables("RESULT").Select("cis_colpck = " & "'" & Replace(cboColPckInfo.Text, "'", "''") & "'")
                    If dr_CUITMPRC.Length > 0 Then
                        If dr_CUITMPRC(0).Item("icf_colcde") = "@#" Then
                            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                                Detail_Err = True
                                tabFrame.SelectTab(tabFrame_Detail)
                                Detail_Err = False
                            End If
                            MsgBox("Color or Packing Not exist in Item Master", MsgBoxStyle.Information, "Message")

                            Display_Dtl("ADD")
                            setDtlStatus("FIND")
                            cboColPckInfo.SelectedIndex = -1
                            cboColPckInfo.Enabled = True
                            If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()
                            Return False

                            'ElseIf dr_CUITMPRC(0).Item("imu_status") <> "ACT" Then
                            '    MsgBox("The quoted item has no ACT pricing in IM for this customer!", MsgBoxStyle.Information, "Message")
                            '    cboColPckInfo.SelectedIndex = -1
                            '    cboColPckInfo.Enabled = True
                            '    If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()
                            '    Return False
                            'ElseIf dr_CUITMPRC(0).Item("imu_bcurcde") <> "N/A" Then
                            '    Return True
                        ElseIf dr_CUITMPRC(0).Item("cip_curcde") <> "N/A" Then
                            Return True
                        Else
                            If tabFrame.SelectedIndex <> tabFrame_Detail Then
                                Detail_Err = True
                                tabFrame.SelectTab(tabFrame_Detail)
                                Detail_Err = False
                            End If
                            MsgBox("This Packing does not exist in CIH", MsgBoxStyle.Information, "Message")
                            Display_Dtl("ADD")
                            setDtlStatus("FIND")
                            cboColPckInfo.SelectedIndex = -1
                            cboColPckInfo.Enabled = True
                            If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()
                            Return False
                        End If
                    End If
                End If
            Else
                setDtlStatus("FIND")
                If tabFrame.SelectedIndex <> tabFrame_Detail Then
                    Detail_Err = True
                    tabFrame.SelectTab(tabFrame_Detail)
                    Detail_Err = False
                End If
                MsgBox("This Color Packing already existed", MsgBoxStyle.Information, "Message")
                cboColPckInfo.SelectedIndex = -1
                cboColPckInfo.Enabled = True
                If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()
                Return False
            End If
        End If

        Return True

    End Function

    Private Sub Cal_DtlTotalCtn(ByVal ordqty As Long)
        Dim TotalCtn As Long
        Dim master As Integer

        If cboColPckInfo.Text <> "" Then
            master = Split(cboColPckInfo.Text, " / ")(3)
            If master <> 0 Then
                TotalCtn = ordqty / master
            Else
                TotalCtn = 0
            End If
            lblTotalCtn.Text = TotalCtn
        End If
    End Sub

    Private Sub cmdCtnSeq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCtnSeq.Click
        recordStatus = True
        Dim X
inputx:
        X = InputBox("Confirm to Re-Sequence Carton Number?" & Chr(13) & _
                    "You can input Re-Starting Sequence number" & Chr(13) & _
                    "(Cancel to Exit)", "CTN Re-Seq", 1)

        If Trim(X) = "" Then
            Exit Sub
        End If
        If IsNumeric(X) = False Or Len(X) > 7 Then
            cmdCtnSeq.PerformClick()
            Exit Sub
        End If

        If chkSCSeqReOrd.Checked = False Then
            Auto_gen_Carton(CLng(X))
        Else
            Dim CtnStart As Integer = CLng(X)
            rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnstr").ReadOnly = False
            rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnend").ReadOnly = False
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ctnstr") = CtnStart
                rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ctnend") = CtnStart + rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn") - 1
            Next
        End If

        rs_SCORDDTL.AcceptChanges()
        rs_SCORDDTL_Summary = rs_SCORDDTL.Copy
        initFlag = True
        dgSummary.DataSource = rs_SCORDDTL_Summary.Tables("RESULT").DefaultView
        initFlag = False
        'rs_SCORDDTL_Summary.Tables("RESULT").DefaultView.Sort = sort_seq
        chkSCSeqReOrd.Checked = False
        Display_Summary()
        Display_Dtl("SCORDDTL")
        skipDVErrorFlag = True
        recordMove("LOAD")
        skipDVErrorFlag = False
    End Sub

    Private Sub Auto_gen_Carton(ByVal X As Long)
        Dim LastCarton As Long
        LastCarton = X
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            'rs_SCORDDTL.Filter = "sod_cusitm = '' and sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_ordqty > 0"
            Dim dr() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_cusitm = '' and sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_ordqty > 0")
            If dr.Length > 0 Then
                'rs_SCORDDTL.Filter = "sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_ordqty <> 0 "
                'rs_SCORDDTL.sort = "sod_itmno,sod_ordseq"
                dr = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_ordqty <> 0", "sod_itmno, sod_ordseq")
                rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnstr").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnend").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False
                For i As Integer = 0 To dr.Length - 1
                    If dr(i).Item("sod_shpqty") = 0 Then
                        clearMore("CTL", dr(i).Item("sod_ordseq"))
                        dr(i).Item("sod_ctnstr") = LastCarton
                        dr(i).Item("sod_ctnend") = CInt(dr(i).Item("sod_ctnstr")) + CInt(dr(i).Item("sod_ttlctn")) - 1
                        LastCarton = dr(i).Item("sod_ctnend") + 1
                        If dr(i).Item("sod_creusr") <> "~*ADD*~" And dr(i).Item("sod_creusr") <> "~*DEL*~" And _
                           dr(i).Item("sod_creusr") <> "~*NEW*~" Then
                            dr(i).Item("sod_creusr") = "~*UPD*~"
                        End If
                    End If
                Next
            Else
                dr = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_ordqty <> 0", "sod_cusitm, sod_ordseq")
                rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnstr").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_ctnend").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False
                For i As Integer = 0 To dr.Length - 1
                    If dr(i).Item("sod_shpqty") = 0 Then
                        clearMore("CTL", dr(i).Item("sod_ordseq"))
                        dr(i).Item("sod_ctnstr") = LastCarton
                        dr(i).Item("sod_ctnend") = CInt(dr(i).Item("sod_ctnstr")) + CInt(dr(i).Item("sod_ttlctn")) - 1
                        LastCarton = dr(i).Item("sod_ctnend") + 1
                        If dr(i).Item("sod_creusr") <> "~*ADD*~" And dr(i).Item("sod_creusr") <> "~*DEL*~" And _
                           dr(i).Item("sod_creusr") <> "~*NEW*~" Then
                            dr(i).Item("sod_creusr") = "~*UPD*~"
                        End If
                    End If
                Next
            End If
            'rs_SCORDDTL.Filter = ""
            'rs_SCORDDTL.sort = "sod_ordseq"

        End If
    End Sub

    Private Sub txtOrdQty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtOrdQty.TextChanged
        recordStatus = True
        recordStatus_dtl = True
        If txtOrdQty.Enabled = True And txtOrdQty.Text <> "" And txtDiscount.Text <> "" And txtUntPrc.Text <> "" Then
            Cal_DtlTotalCtn(txtOrdQty.Text)
            Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)
        Else
            Cal_DtlTotalCtn(0)
            Cal_DtlPrcSubTTl(0, 0, Custfml, 0)
            Cal_DtlPrcNetSelPrc(0, 0, Custfml, 0, 0)
            OrgMOQChg = 0
            txtMOQChg.Text = 0
            txtMOQChg.Enabled = False
        End If
    End Sub

    Private Sub txtDiscount_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDiscount.Enter
        txtDiscount.SelectAll()
        discountFocus = True
    End Sub

    Private Sub txtDiscount_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDiscount.LostFocus
        If txtDiscount.Text = "" Then
            txtDiscount.Text = "0.000"
        End If
        discountFocus = False
    End Sub

    Private Sub keyPress_Discount(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDiscount.KeyPress, txtPODiscount.KeyPress
        If Asc(e.KeyChar) = 46 Then
            If sender.Text.Contains(".") Then
                e.KeyChar = Chr(0)
            End If
        ElseIf Asc(e.KeyChar) = 8 Then
            Return
        ElseIf Not IsNumeric(e.KeyChar) Then
            e.KeyChar = Chr(0)
        Else
            If sender.Text.Substring(sender.Text.Length - (sender.Text.Length - InStr(sender.Text, ".")), sender.Text.Length - InStr(sender.Text, ".")).Length >= 3 Then
                If sender.SelectionLength = 0 Then
                    e.KeyChar = Chr(0)
                End If
            End If
        End If
    End Sub

    Private Sub txtDiscount_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDiscount.TextChanged
        If discountFocus = True Then
            recordStatus = True
            recordStatus_dtl = True

            If txtDiscount.Enabled = True And txtDiscount.Text <> "" And txtOrdQty.Text <> "" And txtDiscount.Text <> "." And strOrgSelPrc <> "" Then
                Cal_DtlTotalCtn(txtOrdQty.Text)
                Cal_DtlPrc(strOrgSelPrc, txtDiscount.Text, Custfml, txtOrdQty.Text)
            Else
                Cal_DtlTotalCtn(0)
                Cal_DtlPrc(0, 0, Custfml, 0)
            End If

            Call Cal_DtlPrcNetSelPrc(Val(txtUntPrc.Text), Val(txtDiscount.Text), Custfml, Val(txtOrdQty.Text) + 0, Val(txtMOQChg.Text))
            Call Cal_DtlPrcSubTTl(Val(txtNetUntPrc.Text), Val(txtDiscount.Text), Custfml, Val(txtOrdQty.Text) + 0)
        End If
    End Sub

    Private Sub Cal_DtlPrc(ByVal basprc As Double, ByVal Discount As Double, ByVal fml As String, ByVal ordqty As Long)
        Dim untprc As Double

        If Me.chkPC.Visible = True And Me.chkPC.Checked = True And IsNumeric(Me.txtPCPrc.Text) And basprc > 0 Then
            basprc = CDbl(strorgpcprc)
            untprc = (basprc * (1 - Val(Discount) / 100))
            txtPCPrc.Text = Format(roundup(untprc), "######0.0000")
            txtPCPrc.Refresh()
        Else
            untprc = (basprc * (1 - Val(Discount) / 100))
            txtUntPrc.Text = Format(roundup(untprc), "######0.0000")
            txtUntPrc.Refresh()
        End If

    End Sub

    Private Sub txtUntPrc_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtUntPrc.TextChanged
        recordStatus = True
        recordStatus_dtl = True

        If Trim(txtDiscount.Text) <> "0" And discountFocus = False And txtUntPrc.Enabled = True Then
            txtDiscount.Text = 0
        End If

        If txtUntPrc.Enabled = True And txtOrdQty.Text <> "" And txtDiscount.Text <> "" And txtUntPrc.Text <> "" And txtUntPrc.Text <> "." Then
            If txtDiscount.Text = "." Then
                txtDiscount.Text = "0"
            End If
            If txtMOQChg.Text = "" Then
                Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text, 0)
            Else
                Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text, txtMOQChg.Text)
            End If
            Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)

        Else
            If Trim(txtOrdQty.Text) <> "" Then
                'Call Cal_DtlPrcSubTTl(0, 0, Custfml, 0)
				Call Cal_DtlPrcSubTTl(CDbl(txtUntPrc.Text), 0, Custfml, Long.Parse(txtOrdQty.Text))
            End If
        End If

        If txtMOQChg.Enabled = True Then
            If txtMOQChg.Text = 0 And txtMOQChg.Text <> "" Then
                txtNetUntPrc.Text = txtUntPrc.Text
            End If
        End If
    End Sub

    Private Sub highlightControl(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtItmCst.GotFocus, txtBOMCst.GotFocus, txtTtlCst.GotFocus, txtDVItmCst.GotFocus, txtDVBOMCst.GotFocus, txtDVTtlCst.GotFocus, txtItmno.GotFocus, txtUntPrc.GotFocus, txtPCPrc.GotFocus, txtOrdQty.GotFocus, txtPC.GotFocus, txtDiscount.GotFocus
        sender.SelectAll()
    End Sub

    Private Sub txtItmCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtItmCst.TextChanged
        If txtItmCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True

            If txtItmCst.Text = "." Then
                Cal_PVCosts_ItmCst(0, IIf(txtBOMCst.Text = "", 0, txtBOMCst.Text))
            Else
                Cal_PVCosts_ItmCst(IIf(txtItmCst.Text = "", 0, txtItmCst.Text), IIf(txtBOMCst.Text = "", 0, txtBOMCst.Text))
            End If
        End If
    End Sub

    Private Sub Cal_PVCosts_ItmCst(ByVal itmcst As Double, ByVal bomcst As Double)
        txtBOMCst.Text = Format(bomcst, "########0.0000")
        txtTtlCst.Text = Format(itmcst + bomcst, "########0.0000")
    End Sub

    Private Sub txtBOMCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtBOMCst.TextChanged
        If txtBOMCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True

            Cal_PVCosts_BOMCst(txtItmCst.Text, IIf(txtBOMCst.Text = "" Or txtBOMCst.Text = ".", 0, txtBOMCst.Text))
        End If
    End Sub

    Private Sub Cal_PVCosts_BOMCst(ByVal itmcst As Double, ByVal bomcst As Double)
        txtItmCst.Text = Format(itmcst, "########0.0000")
        txtTtlCst.Text = Format(itmcst + bomcst, "########0.0000")
    End Sub

    Private Sub txtTtlCst_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtTtlCst.SelectAll()
    End Sub

    Private Sub txtTtlCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtTtlCst.TextChanged
        If txtTtlCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True
        End If
    End Sub

    Private Sub check_numeric_format(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtItmCst.Validating, txtBOMCst.Validating, txtTtlCst.Validating, txtDVItmCst.Validating, txtDVBOMCst.Validating, txtDVTtlCst.Validating, txtTtlCst.Validating, txtItmCst.Validating, txtDVTtlCst.Validating, txtDVItmCst.Validating, txtDVBOMCst.Validating, txtBOMCst.Validating
        If cmdClear.Focused = True Or cmdExit.Focused = True Then
            Exit Sub
        End If

        Try
            If CDbl(IIf(sender.Text = "", 0, sender.Text)) = 0 And (sender.Name.ToString <> "txtBOMCst" And sender.Name.ToString <> "txtDVBOMCst") Then
                sender.Text = "0.0000"
                Select Case sender.Name.ToString
                    Case "txtItmCst"
                        MsgBox("Item Cost cannot be zero")
                    Case "txtTtlCst"
                        MsgBox("Total Cost cannot be zero")
                    Case "txtDVItmCst"
                        MsgBox("DV Item Cost cannot be zero")
                    Case "txtDVTtlCst"
                        MsgBox("DV Total Cost cannot be zero")
                End Select
                e.Cancel = True
                sender.SelectAll()
            Else
                txtItmCst.Text = Format(CDbl(txtItmCst.Text), "########0.0000")
                txtBOMCst.Text = Format(CDbl(txtBOMCst.Text), "########0.0000")
                txtTtlCst.Text = Format(CDbl(txtTtlCst.Text), "########0.0000")
                txtDVItmCst.Text = Format(CDbl(txtDVItmCst.Text), "########0.0000")
                txtDVBOMCst.Text = Format(CDbl(txtDVBOMCst.Text), "########0.0000")
                txtDVTtlCst.Text = Format(CDbl(txtDVTtlCst.Text), "########0.0000")
            End If
        Catch ex As Exception
            MsgBox("Invalid Input")
            e.Cancel = True
        End Try
    End Sub

    Private Sub txtDVItmCst_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtDVItmCst.SelectAll()
    End Sub

    Private Sub txtDVItmCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDVItmCst.TextChanged
        If txtDVItmCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True

            Cal_DVCosts_ItmCst(IIf(txtDVItmCst.Text = "", 0, txtDVItmCst.Text), IIf(txtDVBOMCst.Text = "", 0, txtDVBOMCst.Text))
        End If
    End Sub

    Private Sub Cal_DVCosts_ItmCst(ByVal itmcst As Double, ByVal bomcst As Double)
        txtDVBOMCst.Text = Format(bomcst, "########0.0000")
        txtDVTtlCst.Text = Format(itmcst + bomcst, "########0.0000")
    End Sub

    'Private Sub check_numeric_format(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtItmCst.LostFocus, txtBOMCst.LostFocus, txtTtlCst.LostFocus, txtDVItmCst.LostFocus, txtDVBOMCst.LostFocus, txtDVTtlCst.LostFocus
    '    Try
    '        If CDbl(IIf(sender.Text = "", 0, sender.Text)) = 0 And (sender.Name.ToString <> "txtBOMCst" And sender.Name.ToString <> "txtDVBOMCst") Then
    '            sender.Text = "0.0000"
    '            Select Case sender.Name.ToString
    '                Case "txtItmCst"
    '                    MsgBox("Item Cost cannot be zero")
    '                Case "txtTtlCst"
    '                    MsgBox("Total Cost cannot be zero")
    '                Case "txtDVItmCst"
    '                    MsgBox("DV Item Cost cannot be zero")
    '                Case "txtDVTtlCst"
    '                    MsgBox("DV Total Cost cannot be zero")
    '            End Select
    '            If sender.Focused = False Then
    '                sender.Focus()
    '            End If
    '            sender.SelectAll()
    '        Else
    '            txtItmCst.Text = Format(CDbl(txtItmCst.Text), "########0.0000")
    '            txtBOMCst.Text = Format(CDbl(txtBOMCst.Text), "########0.0000")
    '            txtTtlCst.Text = Format(CDbl(txtTtlCst.Text), "########0.0000")
    '            txtDVItmCst.Text = Format(CDbl(txtDVItmCst.Text), "########0.0000")
    '            txtDVBOMCst.Text = Format(CDbl(txtDVBOMCst.Text), "########0.0000")
    '            txtDVTtlCst.Text = Format(CDbl(txtDVTtlCst.Text), "########0.0000")
    '        End If
    '    Catch ex As Exception
    '        MsgBox("Invalid Input")
    '        sender.Focus()
    '    End Try

    'End Sub

    Private Sub txtDVBOMCst_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtDVBOMCst.SelectAll()
    End Sub

    Private Sub txtDVBOMCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDVBOMCst.TextChanged
        If txtDVBOMCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True

            Cal_DVCosts_BOMCst(txtDVItmCst.Text, IIf(txtDVBOMCst.Text = "", 0, txtDVBOMCst.Text))
        End If
    End Sub

    Private Sub Cal_DVCosts_BOMCst(ByVal itmcst As Double, ByVal bomcst As Double)
        txtDVItmCst.Text = Format(itmcst, "########0.0000")
        txtDVTtlCst.Text = Format(itmcst + bomcst, "########0.0000")
    End Sub

    Private Sub txtDVTtlCst_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtDVTtlCst.SelectAll()
    End Sub

    Private Sub txtDVTtlCst_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtTtlCst.TextChanged
        If txtDVTtlCst.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True
        End If
    End Sub

    Private Sub txtUntPrc_Leave(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtUntPrc.LostFocus
        If CDbl(IIf(sender.Text = "", 0, sender.Text)) = 0 Then
            sender.Text = "0.0000"
            MsgBox("Unit Price cannot be zero")
            sender.Focus()
            sender.selectAll()
        Else
            txtUntPrc.Text = Format(CDbl(txtUntPrc.Text), "########0.0000")
        End If
    End Sub

    Private Sub checkShipDate(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtStartShip.Validating, txtEndShip.Validating, txtPOStartShip.Validating, txtPOEndShip.Validating

        If IsDate(sender.Text) And sender.Text.Length = 10 Then
            Select Case sender.Name.ToString
                Case "txtPOStartShip"
                    If CDate(txtPOStartShip.Text) > CDate(txtEndShip.Text) Then
                        e.Cancel = True
                        MsgBox("PO Start Ship Date > SC End Ship Date", MsgBoxStyle.Information, "SCM00001 - " & sender.Name.ToString)
                        sender.SelectAll()
                        Exit Sub
                    End If
                Case Else

            End Select
        Else
            If sender.Text <> "  /  /" Then
                e.Cancel = True
                MsgBox("Date is Invalid !")
                sender.SelectAll()
            End If
        End If
    End Sub

    Private Sub checkCarton(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtStartCarton.Validating, txtEndCarton.Validating
        If sender.Text = "" Then
            sender.Text = "0"
        ElseIf IsNumeric(sender.Text) = False Then
            e.Cancel = True
            MsgBox("Carton must be numeric")
            sender.SelectAll()
        End If
    End Sub

    Private Sub txtItmDsc_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtItmDsc.GotFocus
        txtItmDsc.BringToFront()
        txtItmDsc.Height = sender.Height + 60
        txtItmDsc.SelectionStart = 0
        txtItmDsc.SelectionLength = 0
    End Sub

    Private Sub txtItmDsc_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtItmDsc.LostFocus
        txtItmDsc.Height = sender.Height - 60
    End Sub

    Private Sub txtDtlRmk_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDtlSCRmk.GotFocus
        'txtDtlSCRmk.Height = sender.Height + 60
        'txtDtlSCRmk.BringToFront()
        ''txtDtlRmk.Location = New Point(txtDtlRmk.Location.X, txtDtlRmk.Location.Y - 100)
        'txtDtlSCRmk.SelectionStart = 0
        'txtDtlSCRmk.SelectionLength = 0
    End Sub

    Private Sub txtDtlRmk_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDtlSCRmk.LostFocus
        ''txtDtlRmk.Width = 311
        'txtDtlSCRmk.Height = sender.Height - 60
        ''txtDtlRmk.Location = New Point(txtDtlRmk.Location.X, txtDtlRmk.Location.Y + 100)
    End Sub

    Private Sub txtPckItr_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPckItr.GotFocus
        txtPckItr.BringToFront()
        'txtPckItr.Width = 294
        txtPckItr.Height = sender.Height + 60
        txtPckItr.SelectionStart = 0
        txtPckItr.SelectionLength = 0
    End Sub

    Private Sub txtPckItr_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPckItr.LostFocus
        'txtPckItr.Width = 157
        txtPckItr.Height = sender.Height - 60
    End Sub

    Private Sub changesMade(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtRunNo.TextChanged, txtPckItr.TextChanged, txtItmDsc.TextChanged, txtCustColCde.TextChanged, cboCustUM.SelectedIndexChanged, txtColDsc.TextChanged, txtStartShip.TextChanged, txtStartCarton.TextChanged, txtSKUNo.TextChanged, txtSecCusItm.TextChanged, txtRetailUSD.TextChanged, txtRetailCAD.TextChanged, txtRespPODtl.TextChanged, txtRefDoc.TextChanged, txtRefdat.TextChanged, txtRefClaim.TextChanged, txtEndShip.TextChanged, txtEndCarton.TextChanged, txtDuty.TextChanged, txtDtlSCRmk.TextChanged, txtDept.TextChanged, txtCustPODtl.TextChanged, txtCustItmno.TextChanged, txtCdeMer.TextChanged, txtCdeInr.TextChanged, txtCdeCtn.TextChanged, txtCanDat.TextChanged, optUPC.CheckedChanged, OptOnePrcY.CheckedChanged, OptOnePrcN.CheckedChanged, optEAN.CheckedChanged, chkChgFty.CheckedChanged, cboCusStyNo.SelectedIndexChanged, txtIMPeriod.TextChanged, cboHSTU.TextChanged, txtPOStartShip.TextChanged, txtPOEndShip.TextChanged, txtPOCanDat.TextChanged, txtPJobNo.TextChanged, txtDtlPORmk.TextChanged
        If sender.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True
        End If
    End Sub

    Private Sub chkDelDtl_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkDelDtl.CheckedChanged
        If cmdDelRow.Enabled = False Then
            Exit Sub
        End If
        If chkDelDtl.Enabled = True Then
            rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False
            If chkDelDtl.Checked = True Then
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" And _
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*NEW*~" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*DEL*~"
                ElseIf rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*NEW*~"
                End If
                setDtlStatus("INIT")
                chkDelDtl.Enabled = True
            Else
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*NEW*~" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~"

                    If Split(lblColPckType.Text, strColPck)(1) = "" Then
                        setDtlStatus("FIND")
                    Else
                        setDtlStatus("ADD")
                    End If
                    Call recordMove("DEL")
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                ElseIf rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*NEW*~" And _
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*UPD*~"
                    setDtlStatus("Updating")
                    recordMove("DEL")
                    If txtItmDsc.Enabled And txtItmDsc.Visible Then txtItmDsc.Focus()
                End If

            End If
            recordStatus = True
            recordStatus_dtl = True

        End If
    End Sub

    Private Sub txtZTNVBELN_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtZTNVBELN.TextChanged
        recordStatus_dtl = True
    End Sub

    Private Sub txtZTNPOSNR_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtZTNPOSNR.TextChanged
        recordStatus_dtl = True
    End Sub

    Private Sub chkUpdatePO_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkUpdatePO.CheckedChanged
        If chkUpdatePO.Checked = True Then
            chkChgFty.Checked = False
            chkChgFty.Enabled = False
        Else
            chkChgFty.Enabled = True
        End If
        recordStatus_dtl = True
        recordStatus = True
    End Sub

    Private Sub cboCusVen_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboCusVen.SelectedIndexChanged
        recordStatus = True
        recordStatus_dtl = True
        '    change this function by user request.
        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" Then
            If txtSCVerNo.Text <> "1" Then
                chkChgFty.Checked = True
            Else
                chkChgFty.Checked = False
            End If
        Else
            chkUpdatePO.Checked = True
        End If
    End Sub

    Private Sub txtIMPeriod_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtIMPeriod.KeyPress
        rs_SCORDDTL.Tables("RESULT").Columns("sod_imqutdatchg").ReadOnly = False
        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_imqutdatchg") = "Y"
    End Sub

    'Private Sub cboVenno_ChangeVenno()
    '    '--If Trim(Split(cboVenno.Text, "-")(0)) <> rs_SCORDDTL("SOD_VENNO") Then
    '    Dim CurCde As String
    '    Dim rs As New DataSet

    '    recordStatus = True
    '    recordStatus_dtl = True

    '    'Frankie Cheung 20100712 get ftycst
    '    If rs_FTYCST.Tables.Count > 0 Then
    '        If rs_FTYCST.Tables("RESULT").Rows.Count > 0 Then
    '            If Not rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst") Is Nothing Then
    '                DVItmCst = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst")), 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst"))
    '            End If
    '            If Not rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur") Is Nothing Then
    '                ItmCstCur = IIf(IsDBNull(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur")), 0, rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur"))
    '            End If

    '            rs_SCORDDTL.Tables("RESULT").Columns("sod_dvitmcst").ReadOnly = False
    '            rs_SCORDDTL.Tables("RESULT").Columns("sod_itmcstcur").ReadOnly = False
    '            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvitmcst") = rs_FTYCST.Tables("RESULT").Rows(0)("imu_ftycst")
    '            rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_itmcstcur") = rs_FTYCST.Tables("RESULT").Rows(0)("imu_curcde")
    '        End If
    '    End If

    '    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
    '        '---- Get Vendor Charge MOQ or not
    '        'OrgVenno = cboVenno.Text

    '        gspStr = "sp_select_VNBASINF '','" & Trim(Split(cboPrdVen.Text, "-")(0)) & "'"

    '        'Fixing global company code problem at 20100420
    '        gsCompany = Trim(cboCoCde.Text)
    '        Update_gs_Value(gsCompany)

    '        Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '        If rtnLong <> RC_SUCCESS Then
    '            Me.Cursor = Windows.Forms.Cursors.Default
    '            MsgBox("Error on loading SCM00001 #041 sp_select_VNBASINF : " & rtnStr)
    '            Exit Sub
    '        Else
    '            If rs.Tables("RESULT").Rows.Count > 0 Then
    '                If rs.Tables("RESULT").Rows(0)("vbi_moqchg") = "Y" Then
    '                    VENMOQChgFlag = True
    '                Else
    '                    VENMOQChgFlag = False
    '                End If
    '            End If
    '        End If

    '        '-------------------------------------

    '        If rs.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
    '            VendorType = "E"
    '            If gsFlgCstExt = "1" Then
    '                'setDtlStatus("Cost")
    '                setDtlStatus("NoDVCost")
    '            Else
    '                setDtlStatus("NoCost")
    '            End If
    '        Else
    '            VendorType = "I"
    '            If gsFlgCst = "1" Then
    '                setDtlStatus("Cost")
    '            Else
    '                setDtlStatus("NoCost")
    '            End If
    '        End If

    '        If txtIssDat.Text < MOAStartDate Then
    '            'If rs_SCORDHDR("soh_creusr") = "~*ADD*~" Then
    '            If addFlag = True Then
    '                '---- Get Customer Charge MOQ or not
    '                gspStr = "sp_select_CUPRCINF '" & cboCoCde.Text & "','" & Trim(Split(cboPriCust.Text, "-")(0)) & "'"

    '                'Fixing global company code problem at 20100420
    '                gsCompany = Trim(cboCoCde.Text)
    '                Call Update_gs_Value(gsCompany)

    '                Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '                rs = Nothing
    '                rtnLong = execute_SQLStatement(gspStr, rs, rtnLong)

    '                If rtnLong <> RC_SUCCESS Then
    '                    Me.Cursor = Windows.Forms.Cursors.Default
    '                    MsgBox("Error on loading SCM00001 #042 sp_select_CUPRCINF : " & rtnStr)
    '                    Exit Sub
    '                Else
    '                    If rs.Tables("RESULT").Rows.Count > 0 Then
    '                        If rs.Tables("RESULT").Rows(0)("cpi_moqchgflg") = "Y" Then
    '                            CUSMOQChgFlag = True
    '                        Else
    '                            CUSMOQChgFlag = False
    '                        End If
    '                        If rs.Tables("RESULT").Rows(0)("cpi_moachgflg") = "Y" Then
    '                            CUSMOAChgFlag = True
    '                        Else
    '                            CUSMOAChgFlag = False
    '                        End If
    '                    End If
    '                End If
    '            End If
    '        End If
    '        '-------------------------------------
    '    Else
    '        '---- Get Vendor Charge MOQ or not
    '        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno") <> "" Then
    '            gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno") & "'"

    '            'Fixing global company code problem at 20100420
    '            gsCompany = Trim(cboCoCde.Text)
    '            Update_gs_Value(gsCompany)

    '            Me.Cursor = Windows.Forms.Cursors.WaitCursor
    '            rs = Nothing
    '            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '            If rtnLong <> RC_SUCCESS Then
    '                Me.Cursor = Windows.Forms.Cursors.Default
    '                MsgBox("Error on loading SCM00001 #043 sp_select_VNBASINF : " & rtnStr)
    '                Exit Sub
    '            End If
    '            '-------------------------------------
    '            If rs.Tables("RESULT").Rows.Count > 0 Then
    '                If rs.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
    '                    VendorType = "E"
    '                    If gsFlgCstExt = "1" Then
    '                        'setDtlStatus("Cost")
    '                        setDtlStatus("NoDVCost")
    '                    Else
    '                        setDtlStatus("NoCost")
    '                    End If
    '                Else
    '                    VendorType = "I"
    '                    If gsFlgCst = "1" Then
    '                        setDtlStatus("Cost")
    '                    Else
    '                        setDtlStatus("NoCost")
    '                    End If
    '                End If
    '            End If

    '            '--------------------------------------------
    '            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("SOD_CUSMOQCHG") = "Y" Then
    '                CUSMOQChgFlag = True
    '            Else
    '                CUSMOQChgFlag = False
    '            End If
    '            '----------
    '            If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("SOD_VENMOQCHG") = "Y" Then
    '                VENMOQChgFlag = True
    '            Else
    '                VENMOQChgFlag = False
    '            End If
    '            'OrgVenno = rs_SCORDDTL("sod_orgvenno")
    '        End If
    '    End If


    '    If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And chkCloseOut.Checked = False Then
    '        '    chkUpdatePO.Value = 1
    '        '    change this function by user request.
    '        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" Then
    '            If txtSCVerNo.Text <> "1" Then
    '                chkChgFty.Checked = True
    '            Else
    '                chkChgFty.Checked = False
    '            End If
    '        Else
    '            chkUpdatePO.Checked = True
    '        End If
    '        If rs_SCVENMRK.Tables("RESULT").Rows.Count > 0 Then
    '            Dim dr() As DataRow = rs_SCVENMRK.Tables("RESULT").Select("ivi_venno = " & "'" & Split(cboPrdVen.Text, " - ")(0) & "'")
    '            If dr.Length > 0 Then
    '                If VendorType = "I" Or VendorType = "J" Then
    '                    'If gsCompany = "UCPP" Then
    '                    If dr(0).Item("ivi_subcde") = "" Then
    '                        strSubCde = ""
    '                    Else
    '                        strSubCde = dr(0).Item("ivi_subcde")
    '                    End If

    '                    lblVenItm.Text = dr(0).Item("ivi_venitm")
    '                    'lblTtlCstCur.Text = dr(0).Item("imu_curcde")
    '                    lblItmCstCur.Text = dr(0).Item("imu_curcde")
    '                    'lblBOMCstCur.Text = dr(0).Item("imu_curcde")
    '                    '***********Carlos Lui commented on 20120709************
    '                    'lblpckseq.Caption = rs_SCVENMRK("imu_pckseq").Value
    '                    '***********Carlos Lui commented on 20120709************
    '                    'lblftyunt.Caption = "[ UM = " & rs_SCVENMRK("imu_pckunt").Value & " ]"
    '                    lblFtyUnt.Text = dr(0).Item("imu_pckunt")
    '                    'Frankie Cheung 20100809 Get latest Item Master period for change of prod. vendor
    '                    If Not dr(0).Item("ipi_qutdat") Is Nothing Then
    '                        If CStr(Year(dr(0).Item("ipi_qutdat"))) <> "1900" Then
    '                            txtIMPeriod.Text = CStr(Year(dr(0).Item("ipi_qutdat"))) + "-" + Microsoft.VisualBasic.Right("00" + CStr(Month(dr(0).Item("ipi_qutdat"))), 2)
    '                        Else
    '                            txtIMPeriod.Text = ""
    '                        End If
    '                    Else
    '                        txtIMPeriod.Text = ""
    '                    End If

    '                    'DummyFtyPrc = dr(0).Item("imu_ftyprc")

    '                    If VendorType = "E" Then
    '                        txtItmCst.Text = Format(dr(0).Item("imu_ftyprc"), "#0.0000")
    '                    Else
    '                        If dr(0).Item("imu_negprc") > 0 Then
    '                            txtItmCst.Text = Format(dr(0).Item("imu_negprc"), "#0.0000")
    '                        Else
    '                            txtItmCst.Text = Format(dr(0).Item("imu_ftyprc"), "#0.0000")
    '                        End If

    '                    End If

    '                    txtBOMCst.Text = Format(dr(0).Item("imu_bomcst"), "#0.0000")
    '                    If Trim(txtBOMCst.Text) = "" Then txtBOMCst.Text = "0.0000"
    '                    If txtBOMCst.Text = 0 Then
    '                        txtTtlCst.Text = Format(Val(txtItmCst.Text) + Val(txtBOMCst.Text), "#0.0000")
    '                    Else
    '                        txtTtlCst.Text = Format(Int((Val(txtItmCst.Text) + Val(txtBOMCst.Text)) * 10000 + 0.00000001) / 10000, "#0.0000")
    '                    End If
    '                    '               End If
    '                    'txtFtyCst.Text = Format(rs_SCVENMRK("imu_ftycst").Value, "#0.0000")

    '                    If currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count Then
    '                        'rs_SCORDDTL("sod_orgfty").Value = Format(rs_SCVENMRK("imu_calftyprc").Value, "#0.0000")
    '                        rs_SCORDDTL.Tables("RESULT").Columns("sod_orgfty").ReadOnly = False
    '                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgfty") = Format(dr(0).Item("imu_negprc"), "#0.0000")
    '                    End If
    '                Else
    '                    If dr(0).Item("ivi_subcde") = "" Then
    '                        strSubCde = ""
    '                    Else
    '                        strSubCde = dr(0).Item("ivi_subcde")
    '                    End If
    '                    lblVenItm.Text = dr(0).Item("ivi_venitm")
    '                    'lblTtlCstCur.Text = dr(0).Item("imu_curcde")
    '                    lblItmCstCur.Text = dr(0).Item("imu_curcde")
    '                    'lblBOMCstCur.Text = dr(0).Item("imu_curcde")
    '                    lblFtyUnt.Text = dr(0).Item("imu_pckunt")
    '                    '***********Carlos Lui commented on 20120709************
    '                    'lblpckseq.Caption = rs_SCVENMRK("imu_pckseq").Value
    '                    '***********Carlos Lui commented on 20120709************

    '                    'Frankie Cheung 20100704 Get latest period for change of prod. vendor
    '                    'txtPeriod.Text = CStr(year(rs_SCVENMRK("ipi_qutdat"))) + "-" + Right("00" + CStr(month(rs_SCVENMRK("ipi_qutdat"))), 2)

    '                    If dr(0).Item("ipi_qutdat") Is Nothing Then
    '                        txtIMPeriod.Text = ""
    '                    Else
    '                        If CStr(Year(dr(0).Item("ipi_qutdat"))) <> "1900" Then
    '                            txtIMPeriod.Text = CStr(Year(dr(0).Item("ipi_qutdat"))) + "-" + Microsoft.VisualBasic.Right("00" + CStr(Month(dr(0).Item("ipi_qutdat"))), 2)
    '                        Else
    '                            txtIMPeriod.Text = ""
    '                        End If
    '                    End If

    '                    If VendorType = "E" Then
    '                        '                        txtFtyCst.Text = Format(rs_SCVENMRK("imu_ftycst").Value, "#0.0000")
    '                        txtItmCst.Text = Format(dr(0).Item("imu_ftyprc"), "#0.0000")
    '                    Else
    '                        txtItmCst.Text = Format(dr(0).Item("imu_negprc"), "#0.0000")
    '                    End If


    '                    txtBOMCst.Text = Format(dr(0).Item("imu_bomcst"), "#0.0000")

    '                    'Marco Chan 2006-03-20 External Item BOM Round Up
    '                    'txtFtyPrc.Text = Format(Int((val(txtFtyCst.Text) + val(txtBOMCst.Text)) * 100) / 100, "#0.0000")
    '                    If Trim(txtBOMCst.Text) = "" Then txtBOMCst.Text = "0.0000"
    '                    If txtBOMCst.Text = 0 Then
    '                        txtTtlCst.Text = Format(Val(txtItmCst.Text) + Val(txtBOMCst.Text), "#0.0000")
    '                    Else
    '                        txtTtlCst.Text = Format(Math.Round(((Val(txtItmCst.Text) + Val(txtBOMCst.Text)) * 10000) / 10000, 2), "#0.0000")
    '                    End If
    '                    '                End If
    '                    If currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count Then
    '                        rs_SCORDDTL.Tables("RESULT").Columns("sod_orgfty").ReadOnly = False
    '                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgfty") = Format(rs_SCVENMRK.Tables("RESULT").Rows(0)("imu_ftycst"), "#0.0000")
    '                    End If
    '                End If
    '            Else
    '                lblVenItm.Text = ""
    '                'lblTtlCstCur.Text = ""
    '                lblItmCstCur.Text = ""
    '                'lblBOMCstCur.Text = ""
    '                'lblpckseq.Text = 0
    '                lblFtyUnt.Text = "N/A"
    '                ''txtFtyPrc.Text = Format(0, "#0.0000")
    '                txtItmCst.Text = Format(0, "#0.0000")

    '                If currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count Then
    '                    rs_SCORDDTL.Tables("RESULT").Columns("sod_orgfty").ReadOnly = False
    '                    rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgfty") = Format(0, "#0.0000")
    '                End If
    '            End If
    '            ' -----------------------

    '            ' *** Get UM, Master & Inner Information ***
    '            If Trim(cboColPckInfo.Text) = "" Then
    '                um = ""
    '                master = 0
    '                inner = 0
    '            Else
    '                um = Split(cboColPckInfo.Text, " / ")(1)
    '                inner = Split(cboColPckInfo.Text, " / ")(2)
    '                master = Split(cboColPckInfo.Text, " / ")(3)
    '            End If


    '            ' Get the MOQ / MOA inforamtion.
    '            If txtIssDat.Text >= MOQStartDate And txtIssDat.Text < MOAStartDate Then
    '                ' *** Using old logic of MOQ Charge logic ***'
    '                txtMOQChg.Text = 0
    '                txtMOA.Text = "0.0000"
    '                txtMOQ.Text = 0
    '                If Trim(txtOrdQty.Text) = "" Then
    '                    'S = "㊣ItemMaster_moq_moa_wunttyp※S※" & GetCtrlValue(cboPriCust) & "※" & GetCtrlValue(cboSecCust) & "※" & txtItmno.Text & _
    '                    '     "※" & um & "※" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "※" & master & "※" & inner & "※Y※OLD※" & master
    '                    gspStr = "sp_select_ItemMaster_moq_moa_wunttyp '" & cboCoCde.Text & "','" & GetCtrlValue(cboPriCust) & "','" & GetCtrlValue(cboSecCust) & _
    '                             "','" & txtItmno.Text & "','" & um & "','" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "','" & master & _
    '                             "','" & inner & "','Y','OLD','" & master & "'"
    '                Else
    '                    If txtOrdQty.Text >= master Then
    '                        'S = "㊣ItemMaster_moq_moa_wunttyp※S※" & GetCtrlValue(cboPriCust) & "※" & GetCtrlValue(cboSecCust) & "※" & txtItmno.Text & _
    '                        '     "※" & um & "※" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "※" & master & "※" & inner & "※Y※OLD※" & txtOrdQty.Text
    '                        gspStr = "sp_select_ItemMaster_moq_moa_wunttyp '" & cboCoCde.Text & "','" & GetCtrlValue(cboPriCust) & "','" & GetCtrlValue(cboSecCust) & _
    '                             "','" & txtItmno.Text & "','" & um & "','" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "','" & master & _
    '                             "','" & inner & "','Y','OLD','" & txtOrdQty.Text & "'"
    '                    Else

    '                    End If
    '                    'S = "㊣ItemMaster_moq_moa_wunttyp※S※" & GetCtrlValue(cboPriCust) & "※" & GetCtrlValue(cboSecCust) & "※" & txtItmno.Text & _
    '                    '"※" & um & "※" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "※" & master & "※" & inner & "※Y※OLD※" & master
    '                    gspStr = "sp_select_ItemMaster_moq_moa_wunttyp '" & cboCoCde.Text & "','" & GetCtrlValue(cboPriCust) & "','" & GetCtrlValue(cboSecCust) & _
    '                             "','" & txtItmno.Text & "','" & um & "','" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "','" & master & _
    '                             "','" & inner & "','Y','OLD','" & master & "'"
    '                End If

    '                'Fixing global company code problem at 20100420
    '                gsCompany = Trim(cboCoCde.Text)
    '                Update_gs_Value(gsCompany)

    '                rs = Nothing
    '                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '                If rtnLong <> RC_SUCCESS Then  '*** An error has occured
    '                    Me.Cursor = Windows.Forms.Cursors.Default
    '                    MsgBox("Error on loading SCM00001 #044 sp_select_ItemMaster_moq_moa_wunttyp : " & rtnStr)
    '                    Exit Sub
    '                Else
    '                    txtMOA.Text = Format(rs.Tables("RESULT").Rows(0)("MOA"), "#0.0000")
    '                    txtMOQ.Text = rs.Tables("RESULT").Rows(0)("MOQ")

    '                    If CDbl(rs.Tables("RESULT").Rows(0)("MOQ")) > 0 Then
    '                        ' Added by Mark Lau 20090205
    '                        txtMOQUnttyp.Text = "CTN" 'rs(1)("UNTTYP").Value
    '                    Else
    '                        txtMOQUnttyp.Text = ""
    '                    End If
    '                End If
    '            Else
    '                'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    '                'Lester Wu 2007-10-17, HardCode
    '                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Or txtIssDat.Text >= "10/10/2007" Then
    '                    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    '                    ' *** Using New of MOA Charge logic ***'
    '                    CUSMOQChgFlag = False
    '                    txtMOQChg.Text = 0
    '                    txtMOA.Text = "0.0000"
    '                    txtMOQ.Text = 0
    '                    'S = "㊣ItemMaster_moq_moa_wunttyp※S※" & GetCtrlValue(cboPriCust) & "※" & GetCtrlValue(cboSecCust) & "※" & txtItmno.Text & _
    '                    '    "※" & um & "※" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "※" & master & "※" & inner & "※Y※NEW※1"
    '                    gspStr = "sp_select_ItemMaster_moq_moa_wunttyp '" & cboCoCde.Text & "','" & GetCtrlValue(cboPriCust) & "','" & GetCtrlValue(cboSecCust) & _
    '                             "','" & txtItmno.Text & "','" & um & "','" & Trim(IIf(txtConftr.Text = "", 1, txtConftr.Text)) & "','" & master & _
    '                             "','" & inner & "','Y','NEW','1'"

    '                    'Fixing global company code problem at 20100420
    '                    gsCompany = Trim(cboCoCde.Text)
    '                    Update_gs_Value(gsCompany)

    '                    rs = Nothing
    '                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
    '                        Me.Cursor = Windows.Forms.Cursors.Default
    '                        MsgBox("Error on loading SCM00001 #045 sp_select_ItemMaster_moq_moa_wunttyp : " & rtnStr)
    '                        Exit Sub
    '                    Else
    '                        Dim drCust_P As DataRow() = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")
    '                        'SalRate(rs_CUBASINF_P.Tables("RESULT").Rows(currentRow)("cpi_curcde"), rs.Tables("RESULT").Rows(0)("CURCDE"), rs.Tables("RESULT").Rows(0)("MOA"), "MOA")
    '                        SalRate(drCust_P(0).Item("cpi_curcde"), rs.Tables("RESULT").Rows(0)("CURCDE"), rs.Tables("RESULT").Rows(0)("MOA"), "MOA")
    '                        txtMOQ.Text = Format(IIf(rs.Tables("RESULT").Rows(0)("MOQ").ToString.Length = 0, 0, rs.Tables("RESULT").Rows(0)("MOQ")), "#0")

    '                        If CDbl(IIf(IsDBNull(rs.Tables("RESULT").Rows(0)("MOQ")), 0, rs.Tables("RESULT").Rows(0)("MOQ"))) > 0 Then
    '                            ' Added by Mark Lau 20090205
    '                            txtMOQUnttyp.Text = "CTN" 'rs(1)("UNTTYP").Value
    '                        Else
    '                            txtMOQUnttyp.Text = ""
    '                        End If
    '                    End If
    '                    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    '                End If
    '                'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    '            End If
    '        End If
    '    Else
    '        'lblTtlCstCur.Text = ""
    '        lblItmCstCur.Text = ""
    '        'lblBOMCstCur.Text = ""
    '    End If 'recordcount


    '    If Trim(txtOrdQty.Text) <> "" Then
    '        If txtOrdQty.Text <> 0 Then
    '            If txtOrdQty.Enabled = True And txtOrdQty.Text <> "" And txtDiscount.Text <> "" And txtUntPrc.Text <> "" Then
    '                Cal_DtlTotalCtn(txtOrdQty.Text)
    '                Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)
    '                If (CUSMOQChgFlag = True And chkCloseOut.Checked = False And chkReplacement.Checked = False) And (txtOrdQty.Text / Split(cboColPckInfo.Text, " / ")(3)) >= 1 Then
    '                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
    '                        OrgMOQChg = rs.Tables("RESULT").Rows(0)("MOQCHG")
    '                        txtMOQChg.Text = rs.Tables("RESULT").Rows(0)("MOQCHG")
    '                    Else
    '                        OrgMOQChg = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgmoqchg")
    '                        txtMOQChg.Text = rs.Tables("RESULT").Rows(0)("MOQCHG")
    '                    End If
    '                    txtMOQChg.Refresh()
    '                    If txtMOQChg.Text > 0 And cboSCStatus.Text.Substring(0, 3) <> "REL" And cboSCStatus.Text.Substring(0, 3) <> "CLO" Then
    '                        txtMOQChg.Enabled = True
    '                    Else
    '                        txtMOQChg.Enabled = False
    '                    End If
    '                Else
    '                    OrgMOQChg = 0
    '                    txtMOQChg.Text = 0
    '                    txtMOQChg.Refresh()
    '                    txtMOQChg.Enabled = False
    '                End If
    '                Call Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text + 0, txtMOQChg.Text)
    '            Else
    '                Cal_DtlTotalCtn(0)
    '                Cal_DtlPrcSubTTl(0, 0, Custfml, 0)
    '                Cal_DtlPrcNetSelPrc(0, 0, Custfml, 0, 0)
    '                OrgMOQChg = 0
    '                txtMOQChg.Text = 0
    '                txtMOQChg.Enabled = False
    '            End If
    '        End If
    '    End If
    '    '--End If
    '    Me.Cursor = Windows.Forms.Cursors.Default
    'End Sub

    Private Function GetCtrlValue(ByVal Ctrl As Object) As String
        If TypeOf Ctrl Is ComboBox Then
            If Ctrl.Text <> "" Then
                If UBound(Split(Ctrl.Text, " - ")) > 0 Then
                    Return Split(Ctrl.Text, " - ")(0)
                Else
                    Return Ctrl.Text
                End If
            Else
                Return ""
            End If
        ElseIf TypeOf Ctrl Is ListBox Then
            If Ctrl.Items.Count > 0 Then
                If Ctrl.Items(0).ToString <> "" Then
                    If UBound(Split(Ctrl.Items(0).ToString, " - ")) > 0 Then
                        Return Split(Ctrl.Items(0).ToString, " - ")(0)
                    Else
                        Return ""
                    End If
                Else
                    Return ""
                End If
            Else
                Return ""
            End If
        Else
            Return ""
        End If
    End Function

    Private Sub shipMarkChanges(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtEngDsc.TextChanged, txtEngRmk.TextChanged, txtChiRmk.TextChanged, txtChiDsc.TextChanged
        If sender.Focused = True Then
            recordStatus = True
        End If
    End Sub

    Private Sub cboBillAdd_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboBillAdd.SelectedIndexChanged
        If cboBillAdd.Focused = True Then
            recordStatus = True
        End If

        Dim BillAdd As Integer
        If cboBillAdd.Text <> "" Then
            BillAdd = Split(cboBillAdd.Text, " - ")(0)
        End If

        If cboBillAdd.Enabled = True Then
            Dim dr() As DataRow = rs_CUCNTINF_BA.Tables("RESULT").Select("cci_cntseq=" & "'" & BillAdd & "'")
            If dr.Length > 0 Then
                txtBillAdd.Text = dr(0).Item("cci_cntadr")
                txtBillSP.Text = dr(0).Item("cci_cntstt")
                If dr(0).Item("cci_cntcty").ToString <> "" Then
                    display_combo(dr(0).Item("cci_cntcty"), cboBillCountry)
                Else
                    cboBillCountry.SelectedIndex = -1
                End If
                txtBillZIP.Text = dr(0).Item("cci_cntpst")
            Else
                txtBillAdd.Text = ""
                txtBillSP.Text = ""
                cboBillCountry.SelectedIndex = -1
                txtBillZIP.Text = ""
            End If
        End If
    End Sub

    Private Sub cboShipAdd_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboShipAdd.SelectedIndexChanged
        If cboShipAdd.Focused = True Then
            recordStatus = True
        End If

        Dim shpadd As Integer
        If cboShipAdd.Text <> "" Then
            shpadd = Split(cboShipAdd.Text, " - ")(0)
        End If

        Dim dr() As DataRow
        If cboSecCust.Text <> "" And cboShipAdd.Enabled = True Then
            dr = rs_CUCNTINF_S.Tables("RESULT").Select("cci_cntseq=" & "'" & shpadd & "'")
            If dr.Length > 0 Then
                txtShipAdd.Text = dr(0).Item("cci_cntadr")
                txtShipSP.Text = dr(0).Item("cci_cntstt")
                If dr(0).Item("cci_cntcty") <> "" Then
                    Call display_combo(dr(0).Item("cci_cntcty"), cboShipCountry)
                Else
                    cboShipCountry.SelectedIndex = -1
                End If
                txtShipZIP.Text = dr(0).Item("cci_cntpst")
                strSAddSeq = dr(0).Item("cci_sapshcusno")
            Else
                txtShipAdd.Text = ""
                txtShipSP.Text = ""
                cboShipCountry.SelectedIndex = -1
                txtShipZIP.Text = ""
                strSAddSeq = 0
            End If
        ElseIf cboShipAdd.Enabled = True Then
            If rs_CUCNTINF_P.Tables("RESULT").Rows.Count > 0 Then
                dr = rs_CUCNTINF_P.Tables("RESULT").Select("cci_cntseq=" & "'" & shpadd & "'")
                If dr.Length > 0 Then
                    txtShipAdd.Text = dr(0).Item("cci_cntadr")
                    txtShipSP.Text = dr(0).Item("cci_cntstt")
                    If dr(0).Item("cci_cntcty") <> "" Then
                        Call display_combo(dr(0).Item("cci_cntcty"), cboShipCountry)
                    Else
                        cboShipCountry.SelectedIndex = -1
                    End If
                    txtShipZIP.Text = dr(0).Item("cci_cntpst")
                    strSAddSeq = dr(0).Item("cci_sapshcusno")
                Else
                    txtShipAdd.Text = ""
                    txtShipSP.Text = ""
                    cboShipCountry.SelectedIndex = -1
                    txtShipZIP.Text = ""
                End If
            Else
                txtShipAdd.Text = ""
                txtShipSP.Text = ""
                cboShipCountry.SelectedIndex = -1
                txtShipZIP.Text = ""
                strSAddSeq = 0
            End If

        End If
    End Sub

    Private Sub Find_DtlItem()
        Dim SecCust As String
        '*** perform query on database after user input an item number
        If txtItmno.Enabled = False Then
            Exit Sub
        End If

        If (Trim(txtItmno.Text) = "") And txtItmno.Enabled = True Then
            If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
            MsgBox("Please input Item No.", MsgBoxStyle.Information, "Message")
            Exit Sub
        End If

        If (Trim(cboPriCust.Text) = "") And cboPriCust.Enabled = True Then
            If tabFrame.SelectedIndex <> 0 Then
                tabFrame.SelectTab(0)
            End If
            If cboPriCust.Enabled And cboPriCust.Visible Then cboPriCust.Focus()
            MsgBox("Please Select a Primary Customer.", MsgBoxStyle.Information, "Message")
            Exit Sub
        End If

        'If (Trim(cboSecCust.Text) = "") Then
        '    SecCust = ""
        'Else
        '    SecCust = Split(cboSecCust.Text, " - ")(0)
        'End If

        SecCust = Split(cboSecCust.Text, " - ")(0)

        Dim rs_IMXChk As New DataSet
        Dim rsCUITMPRC As New DataSet
        Dim Tibi_typ As String

        '**** Checking Item can use this company or not ************************************************************
        gspStr = "sp_select_IMXChk '" & cboCoCde.Text & "','" & Split(cboPriCust.Text, " - ")(0) & "',' ','" & txtItmno.Text & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_IMXChk, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #057 sp_select_IMXChk : " & rtnStr)
            Exit Sub
        End If

        If rs_IMXChk.Tables("RESULT").Rows.Count = 0 Then
            MsgBox("Item cannot be used in this Company! Customer and Compnay Relation Missing.")
            If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
            Exit Sub
        End If
        '*************************************************************************************************************
        '******************************************************************************************************
        '****************************Query CUITMSUM ****************************************************
        '******************************************************************************************************
        gspStr = "sp_select_CUITMPRC_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & Split(cboPriCust.Text, " - ")(0) & _
                 "','" & SecCust & "','" & txtCustPoDat.Text & " 23:59'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rsCUITMPRC, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #058 sp_select_CUITMPRC_SC : " & rtnStr)
            Exit Sub
        Else
            Dim tmpHistory As Boolean
            historyFlag = False
            rs_CUITMPRC = rsCUITMPRC.Copy
            If rs_CUITMPRC.Tables("RESULT").Rows.Count > 0 Then
                Display_Dtl("ADD")
                If rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_itmsts") = "N/A" Then
                    tmpHistory = True
                    For i As Integer = 0 To rs_CUITMPRC.Tables("RESULT").Rows.Count - 1
                        If rs_CUITMPRC.Tables("RESULT").Rows(i)("ibi_itmsts").ToString <> "N/A" Then
                            tmpHistory = False
                        End If
                    Next
                    If tmpHistory = True Then
                        historyFlag = True
                        Tier_typ = False
                    End If
                ElseIf Split(rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_itmsts"), " - ")(0) = "DIS" Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("This is a Discontiune Item", MsgBoxStyle.Information, "Message")
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                    Exit Sub
                ElseIf rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_ftytmp").ToString = "Y" Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("This is a Fty Tmp Item", MsgBoxStyle.Information, "Message")
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                    Exit Sub
                ElseIf Split(rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_itmsts"), " - ")(0) = "OLD" Then
                    Me.Cursor = Windows.Forms.Cursors.Default
                    MsgBox("This is an Old Item", MsgBoxStyle.Information, "Message")
                    If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                    Exit Sub
                Else
                    ' Ignore the first row cannot be found in IM
                    Dim dr() As DataRow = rs_CUITMPRC.Tables("RESULT").Select("icf_colcde <> '@#'")
                    If dr.Length > 0 Then
                        If dr(0).Item("ibi_ftytmp").ToString = "Y" Then
                            Me.Cursor = Windows.Forms.Cursors.Default
                            MsgBox("This is a Fty Tmp Item", MsgBoxStyle.Information, "Message")
                            If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                            Exit Sub
                        End If

                        rs_SCORDDTL.Tables("RESULT").Columns("sod_tirtyp").ReadOnly = False
                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tirtyp") = dr(0).Item("cis_tirtyp")
                        If dr(0).Item("cis_tirtyp") = 1 Then
                            Tier_typ = True
                        Else
                            Tier_typ = False
                        End If
                        historyFlag = False
                    Else
                        Tier_typ = True
                        historyFlag = False
                    End If
                End If

                cboColPckInfo.Enabled = True
                If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()

                '***************Get Assort Item******************
                '**** Allan Yuen add this function cater item have assortment or not
                Tibi_typ = ""
                If rs_CUITMPRC.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_CUITMPRC.Tables("RESULT").Rows.Count - 1
                        If Tibi_typ <> "ASS" Then
                            Tibi_typ = rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_typ").ToString
                        End If
                    Next
                Else
                    Tibi_typ = rs_CUITMPRC.Tables("RESULT").Rows(0)("ibi_typ")
                End If

                If Tibi_typ = "ASS" Then
                    ITEMASS_Check()
                Else
                    If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                        assItmCount = 1
                    Else
                        assItmCount = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount")
                    End If
                    ASS_Check(Trim(lblDtlSeq.Text), "DEL")
                End If

                '**********************************************

                ITEMBOM_Check()
                fillColPckTrm("CUITMPRC")
            Else
                MsgBox("No Record Found!", MsgBoxStyle.Information, "Message")
                'aaaa
                cboColPckInfo.Items.Clear()
                If txtItmno.Enabled And txtItmno.Visible Then txtItmno.Focus()
                ASS_Check(Trim(lblDtlSeq.Text), "DEL")
            End If

            ' Added by Mark Lau 20080611
            LoadCustUM()
            ' Added by Mark Lau 20080825
            ClearDVTtlCst()
            Me.Cursor = Windows.Forms.Cursors.Default

            'Clear Material Breakdown
            Dim dr_SCCPTBKD() As DataRow = rs_SCCPTBKD.Tables("RESULT").Select("scb_ordseq = " & "'" & currentOrdSeq & "'")
            If dr_SCCPTBKD.Length > 0 Then
                For i As Integer = 0 To dr_SCCPTBKD.Length - 1
                    dr_SCCPTBKD(i).Delete()
                Next
                rs_SCCPTBKD.AcceptChanges()
            End If
        End If

        '******************************************************************************************************
        '******************************************************************************************************
    End Sub

    Private Sub ITEMBOM_Check()
        Dim rsIMBOMINF As New DataSet

        '***** Checking BOM Item ********
        'Check item contain BOM item or not
        BOM_Check(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq"), "DEL")
        gspStr = "sp_select_IMBOM_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rsIMBOMINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #059 sp_select_IMBOM_SC : " & rtnStr)
            Exit Sub
        Else
            rs_IMBOMINF = rsIMBOMINF.Copy()
            '*******If got IMBOMASS Record*****************
            If rs_IMBOMINF.Tables("RESULT").Rows.Count > 0 Then
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    BOMitmCount = rs_IMBOMINF.Tables("RESULT").Rows.Count
                End If
                BOM_Check(Trim(lblDtlSeq.Text), "ADD")
            Else
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    BOMitmCount = 1
                End If
            End If
            '**********************************************
        End If
        '********************************
    End Sub

    Private Sub BOM_Check(ByVal ordseq As Integer, ByVal Act As String)
        Select Case Act

            '*************Add BOM to RS*********************
            Case "ADD"

                Dim dr() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = " & "'" & ordseq & "'")
                If dr.Length = 0 Then
                    For i As Integer = 0 To rs_IMBOMINF.Tables("RESULT").Rows.Count - 1
                        Dim newRow As DataRow = rs_SCBOMINF.Tables("RESULT").NewRow
                        newRow.Item("sbi_ordno") = UCase(txtSCNo.Text)
                        newRow.Item("sbi_ordseq") = ordseq
                        newRow.Item("sbi_itmno") = UCase(Trim(txtItmno.Text))
                        newRow.Item("sbi_assitm") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_assitm")
                        newRow.Item("sbi_assinrqty") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_assinrqty")
                        newRow.Item("sbi_assmtrqty") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_assmtrqty")
                        newRow.Item("sbi_bomitm") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bomitm")
                        newRow.Item("sbi_venno") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_venno")
                        newRow.Item("sbi_bomdsce") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bomdsce")
                        newRow.Item("sbi_bomdscc") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bomdscc")
                        newRow.Item("sbi_colcde") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_colcde")
                        newRow.Item("sbi_coldsc") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_coldsc")
                        newRow.Item("sbi_pckunt") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_pckunt")
                        newRow.Item("sbi_ordqty") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_ordqty")
                        newRow.Item("sbi_fcurcde") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_fcurcde")
                        newRow.Item("sbi_ftyprc") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_ftyprc")
                        newRow.Item("sbi_bcurcde") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bcurcde")
                        newRow.Item("sbi_bomcst") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bomcst")
                        newRow.Item("sbi_obcurcde") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_obcurcde")
                        newRow.Item("sbi_obomcst") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_obomcst")
                        newRow.Item("sbi_obomprc") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_obomprc")
                        newRow.Item("sbi_creusr") = "~*ADD*~"
                        newRow.Item("sbi_ordseq2") = ordseq
                        newRow.Item("sbi_bompoflg") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_bompoflg")
                        newRow.Item("sbi_imperiod") = rs_IMBOMINF.Tables("RESULT").Rows(i)("sbi_imperiod")
                        rs_SCBOMINF.Tables("RESULT").Rows.Add(newRow)
                    Next
                Else
                    MsgBox("This Record already existed!", MsgBoxStyle.Information, "Message")
                End If

                '*************Del BOM to RS*********************
            Case "DEL"
                Dim dr() As DataRow = rs_SCBOMINF.Tables("RESULT").Select("sbi_ordseq = " & "'" & ordseq & "'")
                If dr.Length > 0 Then
                    '    While dr.Length > 0
                    '        dr(0).Delete()
                    '    End While
                    For i As Integer = 0 To dr.Length - 1
                        dr(i).Delete()
                    Next
                    rs_SCBOMINF.AcceptChanges()
                End If
        End Select
    End Sub

    Private Sub ITEMASS_Check()
        Dim rsIMBOMASS As New DataSet
        Dim rs() As ADOR.Recordset

        ASS_Check(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ordseq"), "DEL")

        gspStr = "sp_select_IMBOMASS_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & Split(cboPriCust.Text, " - ")(0) & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rsIMBOMASS, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #060 sp_select_IMBOMASS_SC : " & rtnStr)
            Exit Sub
        Else
            rs_IMBOMASS = rsIMBOMASS.Copy()
            '*******If got IMBOMASS Record*****************
            If rs_IMBOMASS.Tables("RESULT").Rows.Count > 0 Then
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    assItmCount = rs_IMBOMASS.Tables("RESULT").Rows.Count
                Else
                    assItmCount = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount")
                End If
                ASS_Check(Trim(lblDtlSeq.Text), "ADD")
            Else
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") = "~*ADD*~" Then
                    assItmCount = 1
                Else
                    assItmCount = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_assitmcount")
                End If
            End If
            '**********************************************
        End If
    End Sub

    Private Sub ASS_Check(ByVal ordseq As Integer, ByVal Act As String)
        Select Case Act

            '*************Add Assort to RS*********************
            Case "ADD"
                Dim dr() As DataRow = rs_SCASSINF.Tables("RESULT").Select("sai_ordseq = " & "'" & ordseq & "'")
                If dr.Length = 0 Then
                    For i As Integer = 0 To rs_IMBOMASS.Tables("RESULT").Rows.Count - 1
                        Dim newRow As DataRow = rs_SCASSINF.Tables("RESULT").NewRow
                        newRow.Item("sai_ordno") = UCase(txtSCNo.Text)
                        newRow.Item("sai_ordseq") = ordseq
                        newRow.Item("sai_itmno") = UCase(Trim(txtItmno.Text))
                        newRow.Item("sai_assitm") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_assitm")
                        newRow.Item("sai_assdsc") = rs_IMBOMASS.Tables("RESULT").Rows(i)("ibi_engdsc")
                        newRow.Item("sai_colcde") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_colcde")
                        newRow.Item("sai_coldsc") = rs_IMBOMASS.Tables("RESULT").Rows(i)("icf_coldsc")
                        newRow.Item("sai_untcde") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_pckunt")
                        newRow.Item("sai_inrqty") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_inrqty")
                        newRow.Item("sai_mtrqty") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_mtrqty")
                        newRow.Item("sai_imperiod") = rs_IMBOMASS.Tables("RESULT").Rows(i)("iba_period")
                        newRow.Item("sai_cusrtl") = 0
                        newRow.Item("sai_cusstyno") = rs_IMBOMASS.Tables("RESULT").Rows(i)("ics_cusstyno")
                        newRow.Item("sai_tordno") = ""
                        newRow.Item("sai_tordseq") = ""
                        newRow.Item("sai_creusr") = "~*ADD*~"
                        newRow.Item("sai_ordseq2") = ordseq
                        rs_SCASSINF.Tables("RESULT").Rows.Add(newRow)
                    Next
                Else
                    MsgBox("This Record already existed!", MsgBoxStyle.Information, "Message")
                End If
                '*************Del Assort to RS*********************
            Case "DEL"
                Dim dr() As DataRow = rs_SCASSINF.Tables("RESULT").Select("sai_ordseq = " & "'" & ordseq & "'")
                If dr.Length > 0 Then
                    '    While dr.Length > 0
                    '        dr(0).Delete()
                    '    End While
                    For i As Integer = 0 To dr.Length - 1
                        dr(i).Delete()
                    Next
                    rs_SCASSINF.AcceptChanges()
                End If
        End Select
    End Sub

    Private Sub txtItmno_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtItmno.KeyPress
        If Asc(e.KeyChar) = 13 Then
            txtItmno.Text = UCase(txtItmno.Text)
            Find_DtlItem()
        End If
    End Sub

    Private Sub Autosearch_Cust(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboPriCust.KeyUp, cboSecCust.KeyUp, cboPanCopyCustPriCust.KeyUp, cboPanCopyCustSecCust.KeyUp
        If (e.KeyValue >= 47 And e.KeyValue <= 57) Or (e.KeyValue >= 96 And e.KeyValue <= 105) Then
            If Split(sender.Text, " - ")(0).Length <= 5 Then
                auto_search_combo(sender)
            End If
        End If
    End Sub

    Private Sub ValidateKeyPress_Cust(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboPriCust.KeyPress, cboSecCust.KeyPress, cboPanCopyCustPriCust.KeyPress, cboPanCopyCustSecCust.KeyPress
        If Asc(e.KeyChar) = 8 Then
            Exit Sub
        ElseIf Asc(e.KeyChar) = 13 Then
            'sender.SelectAll()
            If sender.Name.ToString = "cboPriCust" Then
                cboSecCust.Focus()
            ElseIf sender.Name.ToString = "cboPanCopyCustPriCust" Then
                cboPanCopyCustSecCust.Focus()
            End If
        ElseIf Asc(e.KeyChar) >= 47 And Asc(e.KeyChar) <= 57 Then
            Exit Sub
        Else
            e.KeyChar = ""
        End If
    End Sub

    Private Sub cboContactPerson_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboContactPerson.TextChanged
        If cboContactPerson.Focused = True Then
            recordStatus = True
            SetDefaultEmail()
        End If
    End Sub

    Private Sub SetDefaultEmail()
        If rs_CUBASINF_Person.Tables("RESULT").Rows.Count > 0 Then
            Dim dr() As DataRow = rs_CUBASINF_Person.Tables("RESULT").Select("cci_cntctp ='" & Replace(cboContactPerson.Text, "'", "''") & "'")
            If dr.Length > 0 Then
                txtEmail.Text = dr(0).Item("cci_cnteml")
            Else
                txtEmail.Text = ""
            End If
        End If
    End Sub

    Private Sub Hightlight_Text(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCustPoDat.GotFocus, txtCancelDat.GotFocus, txtStartShipDat.GotFocus, txtEndShipDat.GotFocus
        sender.SelectAll()
    End Sub

    Private Sub ValidateKeyPress_SalRep(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboSalesRep.KeyPress
        If Asc(e.KeyChar) = 8 Then
            recordStatus = True
            Exit Sub
        ElseIf (Asc(e.KeyChar) >= 47 And Asc(e.KeyChar) <= 57) Then
            recordStatus = True
            Exit Sub
        ElseIf Asc(e.KeyChar) = 13 Then
            sender.SelectAll()
        Else
            e.KeyChar = ""
        End If
    End Sub


    Private Sub Autosearch_SalRep(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboSalesRep.KeyUp
        If (e.KeyValue >= 47 And e.KeyValue <= 57) Or (e.KeyValue >= 96 And e.KeyValue <= 105) Then
            If Split(sender.Text, " - ")(0).Length <= 3 Then
                auto_search_combo(sender)
            End If
        End If
    End Sub

    Private Sub ValidateKeyPress_PayTrm(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboPayTrm.KeyPress
        If Asc(e.KeyChar) = 8 Then
            Exit Sub
        ElseIf (Asc(e.KeyChar) >= 47 And Asc(e.KeyChar) <= 57) Then
            Exit Sub
        ElseIf Asc(e.KeyChar) = 13 Then
            sender.SelectAll()
        Else
            e.KeyChar = ""
        End If
    End Sub

    Private Sub Autosearch_PayTrm(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboPayTrm.KeyUp
        If (e.KeyValue >= 47 And e.KeyValue <= 57) Or (e.KeyValue >= 96 And e.KeyValue <= 105) Then
            If Split(sender.Text, " - ")(0).Length <= 3 Then
                auto_search_combo(sender)
            End If
        End If
    End Sub

    Private Sub Autosearch_PrcTrm(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboPrcTrm.KeyUp
        If e.KeyValue <> 8 And e.KeyValue <> 13 Then
            auto_search_combo(sender)
        End If
    End Sub

    Private Sub isValidInput(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles cboPrcTrm.Validating, cboSecCust.Validating, cboSalesRep.Validating, cboPriCust.Validating, cboPayTrm.Validating, cboContactPerson.Validating, cboPanCopyCustSecCust.Validating, cboPanCopyCustPriCust.Validating
        If cmdClear.Focused = True Or cmdExit.Focused = True Then
            Exit Sub
        End If

        Select Case sender.Name.ToString
            Case "cboPrcTrm", "cboPayTrm", "cboSalesRep"
                If Not sender.Items.Contains(sender.Text) Then
                    e.Cancel = True
                    MsgBox("Invalid Data. Please check again", MsgBoxStyle.Information, "SCM00001 Error - " & sender.Name.ToString)
                    sender.Focus()
                    sender.SelectAll()
                End If
            Case Else
                If Not sender.Items.Contains(sender.Text) And Trim(sender.Text).Length > 0 Then
                    e.Cancel = True
                    MsgBox("Invalid Data. Please check again", MsgBoxStyle.Information, "SCM00001 Error - " & sender.Name.ToString)
                    sender.Focus()
                    sender.SelectAll()
                End If
        End Select
    End Sub

    Private Sub Autosearch_Person(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboContactPerson.KeyUp
        If e.KeyValue <> 8 And e.KeyValue <> 13 Then
            auto_search_combo(sender)
        End If
    End Sub

    Private Sub cboSecCust_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboSecCust.SelectedIndexChanged
        recordStatus = True
        '******************************Have ShipMark and Change customer Handle*********************
        If Trim(cboSecCust.Text) <> "" And cboSecCust.Enabled = True Then
            If Seccustno = Split(cboSecCust.Text, " - ")(0) Then
                Exit Sub
            End If
        End If

        If (rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Or rs_SCSHPMRK.Tables("RESULT").Rows.Count > 0) And cboSecCust.Enabled = True Then
            ' Changed by Mark Lau 20090518
            ' Added by Mark Lau 20090518
            If copyFlag = False And addFlag = False Then
                If (MsgBox("All Detail and Shipmark Record will be Delete", MsgBoxStyle.YesNo, "Message")) = MsgBoxResult.Yes Then
                    clearDetail()
                    clearShipMark()
                    setDtlStatus("INIT")
                    Display_Dtl("INIT")
                    Reset_ShipMark()
                    txtItmno.Text = ""
                    fillcboShipMark("M")
                    If Trim(cboSecCust.Text) <> "" Then
                        Seccustno = Split(cboSecCust.Text, " - ")(0)
                    Else
                        Seccustno = ""
                    End If
                Else
                    display_combo(Seccustno, cboSecCust)
                    Exit Sub
                End If
            End If
        End If
        '*************************************************************************************************

        Dim cusno As String
        Dim dr_S() As DataRow = rs_CUBASINF_S.Tables("RESULT").Select("csc_seccus = " & "'" & Split(cboSecCust.Text, " - ")(0) & "'")
        Dim dr_P() As DataRow = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")
        If rs_CUBASINF_S Is Nothing Then
            Exit Sub
        End If
        If rs_CUBASINF_S.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub
        End If
        If rs_CUBASINF_S.Tables("RESULT").Rows.Count > 0 And Trim(cboSecCust.Text) <> "" Then
            If dr_S.Length > 0 Then
                If dr_S(0).Item("ship_cci_cntadr") <> "N/A" Then
                    txtShipAdd.Text = dr_S(0).Item("ship_cci_cntadr")
                    txtShipSP.Text = dr_S(0).Item("ship_cci_cntstt")
                    If dr_S(0).Item("ship_cci_cntcty").ToString <> "" Then
                        display_combo(dr_S(0).Item("ship_cci_cntcty"), cboShipCountry)
                    Else
                        cboShipCountry.SelectedIndex = -1
                    End If
                    txtShipZIP.Text = dr_S(0).Item("ship_cci_cntpst")
                    txtRemark.Text = dr_S(0).Item("cbi_cerdoc")
                Else
                    txtShipAdd.Text = ""
                    txtShipSP.Text = ""
                    display_combo("", cboShipCountry)
                    txtShipZIP.Text = ""
                End If
            End If
        Else
            If dr_P.Length > 0 Then
                txtRemark.Text = dr_P(0).Item("cbi_cerdoc")
                txtShipAdd.Text = dr_P(0).Item("ship_cci_cntadr")
                txtShipSP.Text = dr_P(0).Item("ship_cci_cntstt")
                If dr_P(0).Item("ship_cci_cntcty") <> "" Then
                    display_combo(dr_P(0).Item("ship_cci_cntcty"), cboShipCountry)
                Else
                    cboShipCountry.SelectedIndex = -1
                End If
                txtShipZIP.Text = dr_P(0).Item("ship_cci_cntpst")
                fillcboShipAdd("P")
            End If
        End If

        If Trim(cboSecCust.Text) <> "" Then
            cusno = Split(cboSecCust.Text, " - ")(0)
            Seccustno = Split(cboSecCust.Text, " - ")(0)

            gspStr = "sp_select_CUSHPMRK '" & cboCoCde.Text & "','" & cusno & "'"

            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rs_CUSHPMRK_S, rtnStr)

            If rtnLong <> RC_SUCCESS Then
                Me.Cursor = Windows.Forms.Cursors.Default
                MsgBox("Error on loading SCM00001 #061 sp_select_CUSHPMRK : " & rtnStr)
                Exit Sub
            End If
            gspStr = "sp_select_CUCNTINF_SC '" & cboCoCde.Text & "','" & cusno & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_CUCNTINF_S, rtnStr)

            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #062 sp_select_CUCNTINF_SC : " & rtnStr)
                Exit Sub
            End If

            fillcboShipMark("M")
            fillcboShipAdd("S")
        End If

        If Trim(cboSecCust.Text) <> "" Then
            Seccustno = Split(cboSecCust.Text, " - ")(0)
        Else
            Seccustno = ""
        End If

        ' AY Fix the secondary customer Certificates/Documentation at 16/01/2003
        If Trim(cboSecCust.Text) <> "" Then
            If dr_S.Length > 0 Then
                txtRemark.Text = dr_S(0).Item("cbi_cerdoc")
            End If
        Else
            If dr_P.Length > 0 Then
                txtRemark.Text = dr_P(0).Item("cbi_cerdoc")
            End If
        End If

        ' 2013-10-17 Set Secondary Customer Payment Terms if exists
        If dr_S.Length > 0 Then
            If dr_S(0).Item("cpi_paytrm") <> "" Then
                display_combo(dr_S(0).Item("cpi_paytrm"), cboPayTrm)
            End If
        End If
    End Sub

    Private Sub txtCustPO_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCustPO.TextChanged, txtItmno.TextChanged
        If sender.Focused = True Then
            recordStatus = True
            poChange = True
        End If
    End Sub

    Private Sub cboPckTrmInfo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboColPckInfo.SelectedIndexChanged
        If cboColPckInfo.Enabled = True Then
            If skipFlag = False Then
                Display_Dtl("ADD")
                setDtlStatus("FIND")
                txtStartShip.Enabled = True
                txtEndShip.Enabled = True
                txtCanDat.Enabled = True

                txtPOStartShip.Enabled = True
                txtPOEndShip.Enabled = True
                txtPOCanDat.Enabled = True
                cmdPOCalDat.Enabled = True

                cboColPckInfo.Enabled = True
                If cboColPckInfo.Enabled And cboColPckInfo.Visible Then cboColPckInfo.Focus()
                'CTN_Clear(Trim(lblDtlSeq.Text))
                SHP_Clear(Trim(lblDtlSeq.Text))
            End If
        End If
    End Sub

    Private Sub cboPckTrmInfo_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboColPckInfo.KeyPress
        recordStatus = True

        If Asc(e.KeyChar) = 13 Then

            'Dim bookmark As Integer
            recordStatus_dtl = True
            If cboColPckInfo.Enabled = True Then
                If Not Valid_Colpck() Then
                    Exit Sub
                Else
					Dim dr_CUITMPRC() As DataRow = rs_CUITMPRC.Tables("RESULT").Select("cis_colpck = " & "'" & Replace(cboColPckInfo.Text, "'", "''") & "'")
                    If dr_CUITMPRC.Length > 0 Then
                        If dr_CUITMPRC(0).Item("cip_effcpo") = "N" Then
                            If MsgBox("[" & cboColPckInfo.Text & "]" & Environment.NewLine & "Effective Date is out of range from your Customer PO Date." & _
                                      Environment.NewLine & "Confirm to continue?", MsgBoxStyle.Information + MsgBoxStyle.YesNo, _
                                      Me.Name & " - Effective Date Out of Range") = MsgBoxResult.No Then
                                Exit Sub
                            End If
                        End If
                    End If
                    setDtlStatus("ADD")
                    Display_Dtl("CUITMPRC")


                    '********** Check Item Status *************
                    If txtItmStatus.Text.Substring(0, 3) <> "CMP" Then
                        MsgBox("Item not in Complete Status !", MsgBoxStyle.Information, "Information")
                        cboColPckInfo.SelectedIndex = -1
                        Exit Sub
                    End If
                    '******************************************

                    '**********Check Replacement******************
                    If gsFlgCst = "1" And gsFlgCstExt = "1" And authUsr = True Then
                        setDtlStatus("Replace")
                    Else
                        setDtlStatus("Non-Replace")
                    End If
                    '*********************************************

                    If authUsr = True Then
                        setDtlStatus("Auth")
                    Else
                        setDtlStatus("UNAuth")
                    End If

                End If

                ' 2014-01-08 David Yue Component Breakdown Load from CIH Component Breakdown
                ''Load Component Breakdown from Quotation
                'Dim rs_QUCPTBKD As DataSet

                'gspStr = "sp_select_QUCPTBKD_SC '" & cboCoCde.Text & "','" & _
                '         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_qutno") & "','" & _
                '         txtItmno.Text & "','" & _
                '         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde") & "','" & _
                '         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_inrqty") & "','" & _
                '         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_mtrqty") & "','" & _
                '         Split(cboColPckInfo.Text, " / ")(0) & "'"
                'rtnLong = execute_SQLStatement(gspStr, rs_QUCPTBKD, rtnStr)
                'If rtnLong <> RC_SUCCESS Then
                '    MsgBox("Error on loading SCM00001 #110 sp_select_QUCPTBKD_SC : " & rtnStr)
                '    Exit Sub
                'End If

                'If rs_QUCPTBKD.Tables("RESULT").Rows.Count > 0 Then
                '    For i As Integer = 0 To rs_QUCPTBKD.Tables("RESULT").Rows.Count - 1
                '        Dim newRow As DataRow = rs_SCCPTBKD.Tables("RESULT").NewRow
                '        newRow.Item("scb_cocde") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_cocde")
                '        newRow.Item("scb_ordno") = ""
                '        newRow.Item("scb_ordseq") = currentOrdSeq
                '        newRow.Item("scb_itmno") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_itmno")
                '        newRow.Item("scb_cptseq") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_cptseq")
                '        newRow.Item("scb_cpt") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_cpt")
                '        newRow.Item("scb_curcde") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_curcde")
                '        newRow.Item("scb_cst") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_cst")
                '        newRow.Item("scb_cstpct") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_cstpct")
                '        newRow.Item("scb_pct") = rs_QUCPTBKD.Tables("RESULT").Rows(i)("qcb_pct")
                '        newRow.Item("scb_creusr") = "~*ADD*~"
                '        rs_SCCPTBKD.Tables("RESULT").Rows.Add(newRow)
                '    Next
                'End If

                Dim rs_CUCPTBKD As DataSet

                gspStr = "sp_select_CUCPTBKD_SC '" & cboCoCde.Text & "','" & _
                         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cusno") & "','" & _
                         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_seccus") & "','" & _
                         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_itmno") & "','" & _
                         rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_colcde") & "'"
                rs_CUCPTBKD = Nothing
                rtnLong = execute_SQLStatement(gspStr, rs_CUCPTBKD, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #110 sp_select_CUCPTBKD_SC : " & rtnStr)
                    Exit Sub
                End If

                If rs_CUCPTBKD.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_CUCPTBKD.Tables("RESULT").Rows.Count - 1

                        Dim dr_check() As DataRow

                        dr_check = rs_SCCPTBKD.Tables("RESULT").Select("scb_itmno = '" & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_itmno") & "'" & _
                                                                        " and scb_cpt = '" & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cpt") & "'" & _
                                                                            " and scb_curcde = '" & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_curcde") & "'" & _
                                                                            " and scb_cst = " & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cst") & _
                                                                            " and scb_cstpct = " & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cstpct") & _
                                                                            " and scb_pct = " & rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_pct"))

                        If dr_check.Length <> 0 Then
                            Continue For
                        End If

                        Dim newRow As DataRow = rs_SCCPTBKD.Tables("RESULT").NewRow
                        newRow.Item("scb_cocde") = cboCoCde.Text
                        newRow.Item("scb_status") = ""
                        newRow.Item("scb_ordno") = ""
                        newRow.Item("scb_ordseq") = currentOrdSeq
                        newRow.Item("scb_itmno") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_itmno")
                        newRow.Item("scb_cptseq") = i + 1 'rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cptseq")
                        newRow.Item("scb_cpt") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cpt")
                        newRow.Item("scb_curcde") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_curcde")
                        newRow.Item("scb_cst") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cst")
                        newRow.Item("scb_cstpct") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_cstpct")
                        newRow.Item("scb_pct") = rs_CUCPTBKD.Tables("RESULT").Rows(i)("ccb_pct")
                        newRow.Item("scb_creusr") = "~*ADD*~"
                        rs_SCCPTBKD.Tables("RESULT").Rows.Add(newRow)
                    Next
                End If
            End If

            '-- Disable MOQ Charge File if not need.
            If Tier_typ = False Then
                txtMOQChg.Enabled = False
                'txtMOQChg.Locked = True
                txtMOQChg.Text = 0
                txtMOQChg.TabStop = False
            End If
            If cboPrdVen.Enabled And cboPrdVen.Visible Then cboPrdVen.Focus()
            'cboVenNo_LostFocus()

            If txtPckItr.Enabled And txtPckItr.Visible Then
                txtPckItr.Focus()
            End If

            If rplSeqFlag = True Then
                txtStartShip.Text = rplSeq_SCShpStr
                txtEndShip.Text = rplSeq_SCShpEnd
                txtCanDat.Text = rplSeq_SCCanDat
                txtPOStartShip.Text = rplSeq_POShpStr
                txtPOEndShip.Text = rplSeq_POShpEnd
                txtPOCanDat.Text = rplSeq_POCanDat
                txtDtlSCRmk.Text = rplSeq_SCRmk
                txtDtlPORmk.Text = rplSeq_PORmk

                rplSeqFlag = False
            End If
        End If
    End Sub

    Private Sub txtItmno_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtItmno.TextChanged

    End Sub

    Private Function checkMOQSC() As Boolean
        Dim rs_chkMOQSC As New DataSet
        checkMOQSC = False
        On Error GoTo err_handle_MOQSC
        If Me.txtMOQSC.Enabled And Me.txtMOQSC.Visible And Me.txtMOQSC.ReadOnly = False Then
            If Trim(Me.txtMOQSC.Text) <> "" Then
                If Len(Trim(Me.txtMOQSC.Text)) <> 9 Then
                    tabFrame.SelectTab(0)
                    MsgBox("Invalid MOQ SC #!")
                    If Me.txtMOQSC.Enabled = True And Me.txtMOQSC.Visible = True And Me.txtMOQSC.ReadOnly = False Then
                        tabFrame.SelectTab(0)
                        Me.txtMOQSC.Focus()
                    End If
                    Exit Function
                End If

                gspStr = "sp_select_SCORDHDR_MOQSC '" & cboCoCde.Text & "','" & Trim(Me.txtMOQSC.Text) & "','" & GetCtrlValue(cboPriCust) & _
                         "','" & GetCtrlValue(cboSecCust) & "','" & LCase(gsUsrID) & "'"

                'Fixing global company code problem at 20100420
                gsCompany = Trim(cboCoCde.Text)
                Update_gs_Value(gsCompany)

                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, rs_chkMOQSC, rtnStr)


                Me.Cursor = Windows.Forms.Cursors.Default
                If rtnLong <> RC_SUCCESS Then
                    tabFrame.SelectTab(0)
                    MsgBox("Error on loading SCM00001 #063 sp_select_SCORDHDR_MOQSC : " & rtnStr)
                    Exit Function
                End If
                If IsDBNull(rs_chkMOQSC.Tables("RESULT").Rows(0)("RET")) Then
                    tabFrame.SelectTab(0)
                    MsgBox("System cannot check MOQ SC Number!")
                ElseIf rs_chkMOQSC.Tables("RESULT").Rows(0)("RET") <> "OK" Then
                    tabFrame.SelectTab(0)
                    MsgBox(rs_chkMOQSC.Tables("RESULT").Rows(0)("RET").ToString)
                    If Me.txtMOQSC.Enabled = True And Me.txtMOQSC.Visible = True And Me.txtMOQSC.ReadOnly = False Then Me.txtMOQSC.Focus()
                End If
            End If
        End If
        checkMOQSC = True
        Exit Function
err_handle_MOQSC:
        MsgBox(Err.Description)
        Err.Clear()
        Exit Function
    End Function

    Private Function ChecktimeStamp() As Boolean
        'Compare the current record's timestamp and the DB timestamp
        Dim Save_TimeStamp As Long
        Dim rs_chktimstp As New DataSet

        gspStr = "sp_select_SCORDHDR '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_chktimstp, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #064 sp_select_SCORDHDR : " & rtnStr)
            Return False
        End If
        If rs_chktimstp.Tables("RESULT").Rows.Count = 0 Then
            MsgBox("RFO", MsgBoxStyle.Information, "Message")
            Return False
        Else
            rs_SCORDHDR = rs_chktimstp.Copy()
            Save_TimeStamp = rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_timstp")
        End If

        'Write your code for Compare
        If current_TimeStamp <> Save_TimeStamp Then
            MsgBox(CStr(current_TimeStamp) & " .vs. " & CStr(Save_TimeStamp))
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub Cal_TotalAmt()
        Dim TotalAmt As Double
        Dim TotalNetAmt As Double
        Dim TotalCtn As Long
        Dim TotalCFT As Double
        Dim TotalCBM As Double
        'Dim bmark As Integer
        TotalAmt = 0
        TotalNetAmt = 0
        TotalCtn = 0
        TotalCBM = 0
        TotalCFT = 0

        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*DEL*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" Then
                    TotalAmt = TotalAmt + Format(CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_selprc")), "#.00")
                    TotalNetAmt = TotalNetAmt + Format(CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_selprc")), "#.00")
                    TotalCtn = TotalCtn + CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn"))
                    TotalCBM = TotalCBM + (CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn")) * CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_cbm")))
                    TotalCFT = TotalCFT + (CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn")) * CDbl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_cft")))
                End If
            Next
        End If
        txtAmt.Text = Format(roundup2(TotalAmt), "######0.00")
        '********CAl the Dis/Pre**********
        Cal_DisPre()
        '*********************************
        TotalNetAmt = TotalNetAmt - Total_D_Amt + Total_P_Amt
        TotalNetAmt = TotalNetAmt + (TotalNetAmt * (Val(Total_P_Per) / 100)) - (TotalNetAmt * (Val(Total_D_Per) / 100))
        txtNetAmt.Text = Format(roundup2(TotalNetAmt), "######0.00")
        txtTotalCtn.Text = TotalCtn
        txtTotalCube.Text = Format(TotalCBM, "#0.0000")
        txtTotalCFT.Text = Format(TotalCFT, "#0.0000")
    End Sub

    Private Sub Cal_DisPre()
        Total_D_Amt = 0
        Total_D_Per = 0
        Total_P_Amt = 0
        Total_P_Per = 0
        If rs_SCDISPRM_D.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_SCDISPRM_D.Tables("RESULT").Rows.Count - 1
                If rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
                    If rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_pctamt") = "Percentage" Then
                        Total_D_Per = Total_D_Per + rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_pct")
                        rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
                        rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_amt") = CDbl(txtAmt.Text) * (CDbl(rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_pct")) / 100)
                    Else
                        Total_D_Amt = Total_D_Amt + CDbl(rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_amt"))
                    End If
                    If rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*ADD*~" And rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And _
                        rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
                        rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                        rs_SCDISPRM_D.Tables("RESULT").Rows(i)("sdp_creusr") = "~*UPD*~"
                    End If
                End If
            Next
        End If


        If rs_SCDISPRM_P.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_SCDISPRM_P.Tables("RESULT").Rows.Count - 1
                If rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
                    If rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_pctamt") = "Percentage" Then
                        Total_P_Per = Total_P_Per + CDbl(rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_pct").ToString)
                        rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_amt").ReadOnly = False
                        rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_amt") = CDbl(txtAmt.Text) * (CDbl(rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_pct")) / 100)
                    Else
                        Total_P_Amt = Total_P_Amt + IIf(IsDBNull(rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_amt")), 0, rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_amt"))
                    End If
                    If rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*ADD*~" And rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*DEL*~" And _
                        rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") <> "~*NEW*~" Then
                        rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                        rs_SCDISPRM_P.Tables("RESULT").Rows(i)("sdp_creusr") = "~*UPD*~"
                    End If

                End If
            Next
        End If
    End Sub

    Private Function InputIsValid() As Boolean
        'Dim Err As String
        'Dim book As Integer
        '****Primary Customer*****
        If Trim(cboPriCust.Text) = "" Then
            MsgBox("Please Select a Primary Customer.")
            Return False
        End If
        '********Check SC Detail***********
        Dim dr_SCORDDTL() As DataRow
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            dr_SCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' ")
            If dr_SCORDDTL.Length = 0 Then
                MsgBox("Please input Detail for this SC")
                Return False
            End If
        Else
            MsgBox("Please input Detail for this SC")
            Return False
        End If
        ''********Check SC Detail For Replacement***********
        'If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 And chkReplacement.Checked = False Then
        '    dr_SCORDDTL = Nothing
        '    dr_SCORDDTL = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' and sod_untprc =  0 ")
        '    If dr_SCORDDTL.Length > 0 Then
        '        'book = rs_SCORDDTL("sod_ordseq").Value
        '        If rs_SCORDDTL("sod_itmno").Value = "" Then
        '            Call Display_Dtl("INIT")
        '        Else
        '            Call Display_Dtl("SCORDDTL")
        '        End If
        '        If rs_SCORDDTL("sod_creusr").Value = "~*DEL*~" Or rs_SCORDDTL("sod_creusr").Value = "~*NEW*~" Then
        '            chkDelDtl.Value = 1
        '        End If
        '        rs_SCORDDTL.Filter = "sod_cocde = 'XXX'"
        '        If SSTab1.Tab <> 3 Then
        '            SSTab1.Tab = 3
        '        End If
        '        rs_SCORDDTL.Filter = ""
        '        rs_SCORDDTL.Find("sod_ordseq = " & "'" & book & "'")
        '        recordMove("LOAD")
        '        msg("M00351")
        '        InputIsValid = False
        '        Exit Function
        '    End If
        '    rs_SCORDDTL.Filter = ""
        'End If
        '*********Ship Date Checking***********
        If Trim(txtCustPO.Text) = "" And txtCustPO.Enabled = True And advOrd = False Then
            If tabFrame.SelectedIndex <> 0 Then
                tabFrame.SelectTab(0)
            End If
            MsgBox("Please input Customer PO #")
            If txtCustPO.Enabled And txtCustPO.Visible Then txtCustPO.Focus()
            Return False
        ElseIf txtCustPO.Enabled = True And (addFlag = True Or poChange = True) Then
            '******************Check Dup CustPO#*******************************

            Dim rsSCORDHDR As New DataSet
            Dim PriCust As String
            Dim SecCust As String
            Dim count As Integer
            If (Trim(cboPriCust.Text) = "") Then
                PriCust = ""
            Else
                PriCust = Split(cboPriCust.Text, " - ")(0)
            End If

            If (Trim(cboSecCust.Text) = "") Then
                SecCust = ""
            Else
                SecCust = Split(cboSecCust.Text, " - ")(0)
            End If

            gspStr = "sp_select_SCORDHDR_CUSTPO '" & cboCoCde.Text & "','" & SecCust & "','" & txtCustPO.Text & "','" & PriCust & "'"

            'Fixing global company code problem at 20100420
            gsCompany = Trim(cboCoCde.Text)
            Update_gs_Value(gsCompany)

            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rsSCORDHDR, rtnStr)

            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #065 sp_select_SCORDHDR_CUSTPO : " & rtnStr)
            Else
                If addFlag = True Then
                    count = 0
                Else
                    count = 1
                End If

                If rsSCORDHDR.Tables("RESULT").Rows(0)("soh_cuspo") > count Then
                    If MsgBox("Customer PO # already Existed", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
                        If tabFrame.SelectedIndex <> 0 Then
                            tabFrame.SelectTab(0)
                        End If
                        If txtCustPO.Enabled And txtCustPO.Visible Then txtCustPO.Focus()
                        Return False
                    End If
                End If
            End If
            '******************************************************************
        End If

        If CDbl(txtNetAmt.Text) <= 0 And chkReplacement.Checked = False And chkCloseOut.Checked = False And chkCancel.Checked = False Then
            If tabFrame.SelectedIndex <> 0 Then
                tabFrame.SelectTab(0)
            End If
            MsgBox("Net Amount Can't be Zero or less than Zero")
            Return False
        ElseIf CDate(txtStartShipDat.Text) > CDate(txtEndShipDat.Text) Then
            If tabFrame.SelectedIndex <> 0 Then
                tabFrame.SelectTab(0)
            End If
            MsgBox("Start Date > End Date !")
            If txtStartShipDat.Enabled And txtStartShipDat.Visible Then txtStartShipDat.Focus()
            Return False

        ElseIf Trim(txtCancelDat.Text) <> "/  /" Then
            If CDate(txtCancelDat.Text) < CDate(txtEndShipDat.Text) And txtCancelDat.Enabled = True Then
                If tabFrame.SelectedIndex <> 0 Then
                    tabFrame.SelectTab(0)
                End If
                MsgBox("Cancel Date < Ship End Date !")
                If txtCancelDat.Enabled And txtCancelDat.Visible Then txtCancelDat.Focus()
                Return False
            End If
        End If
        '**************Check Each Line not over 40 chars************************************
        If MultiLineTextIsValid(txtEngDsc.Text, 40) = False And txtEngDsc.ReadOnly = False Then
            If tabFrame.SelectedIndex <> 3 Then
                tabFrame.SelectTab(3)
            End If
            MsgBox("Each Line not Over 40 characters")
            If txtEngDsc.Enabled And txtEngDsc.Visible Then txtEngDsc.Focus()
            Return False

        ElseIf MultiLineTextIsValid(txtChiDsc.Text, 40) = False And txtEngDsc.ReadOnly = False Then
            If tabFrame.SelectedIndex <> 3 Then
                tabFrame.SelectTab(3)
            End If
            MsgBox("Each Line not Over 40 characters")
            If txtChiDsc.Enabled And txtChiDsc.Visible Then txtChiDsc.Focus()
            Return False

        End If

        Return True
    End Function

    Public Function MultiLineTextIsValid(ByVal S As String, ByVal maxChar As Integer) As Boolean

        MultiLineTextIsValid = True

        Dim v() As String   '*** Variant
        Dim temp As String   '*** temp variable

        v = Split(S, Chr(13) + Chr(10))   '*** split string by "vbNewLine"

        For Each temp In v
            If Len(temp) > maxChar Then   '*** if length of each string > maxChar
                MultiLineTextIsValid = False   '***return false
            End If
        Next

    End Function



    Private Sub updatePO(ByVal typ As String)
        Dim seq As Integer
        rs_SCORDDTL.Tables("RESULT").Columns("sod_updpo").ReadOnly = False
        rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False
        Select Case typ
            Case "True"
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                        rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_updpo") = "Y"
                        If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*ADD*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*DEL*~" And _
                           rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" Then
                            rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*UPD*~"
                        End If
                    Next

                    'If tabFrame.SelectedIndex = tabFrame_Detail Then
                    '    chkUpdatePO.Checked = True
                    'End If
                    chkUpdatePO.Checked = True
                End If
            Case "False"
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                        rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_updpo") = "N"
                        If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*ADD*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*DEL*~" And _
                           rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" Then
                            rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*UPD*~"
                        End If
                    Next

                    'If tabFrame.SelectedIndex = tabFrame_Detail Then
                    '    chkUpdatePO.Checked = False
                    'End If
                    chkUpdatePO.Checked = False

                End If

        End Select

    End Sub

    Private Sub chkhdrpo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkhdrpo.Click
        If chkhdrpo.Focused = True Then
            If chkhdrpo.Enabled = False Then
                Exit Sub
            End If

            If chkhdrpo.Checked = True Then
                updatePO("True")
            Else
                updatePO("False")
            End If

            initFlag = True
            rs_SCORDDTL_Summary = rs_SCORDDTL.Copy
            dgSummary.DataSource = rs_SCORDDTL_Summary.Tables("RESULT").DefaultView
            'rs_SCORDDTL_Summary.sort = sort_seq
            Display_Summary()
            initFlag = False
        End If
    End Sub

    Private Sub chkCloseOut_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkCloseOut.Click
        If chkReplacement.Checked = True And chkCloseOut.Enabled = True Then
            chkReplacement.Checked = True
        End If

        If txtItmno.Text <> "" And cboColPckInfo.Text <> "" Then
            'cboVenno_ChangeVenno()
            cboPrdVen_ChangePV()
            Me.Cursor = Windows.Forms.Cursors.Default
        End If

        reUpdateFlag = True
        recordStatus = True
    End Sub


    Private Sub chkReplacement_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkReplacement.Click
        If chkCloseOut.Checked = True And chkReplacement.Enabled = True Then
            chkCloseOut.Checked = False
        End If

        If txtItmno.Text <> "" And cboColPckInfo.Text <> "" Then
            If chkReplacement.Checked = True And gsFlgCst = "1" And gsFlgCstExt = "1" Then
                'txtFtyPrc.Enabled = True
                txtTtlCst.Enabled = False
                txtItmCst.Enabled = True
                enable_txtBOMCst()  'txtBOMCst.Enabled = True
                'cboVenno_ChangeVenno()
                cboPrdVen_ChangePV()
                Me.Cursor = Windows.Forms.Cursors.Default
            Else
                'txtftyprc.Enabled = False
                Replacement_Undo()
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    txtItmCst.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst"), "#0.0000")
                    txtBOMCst.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst"), "#0.0000")
                    txtTtlCst.Text = Format(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc"), "#0.0000")
                    '*** "sod_ftyprc" = sod_ttlcst ***
                End If
                'cboVenno_ChangeVenno()
                cboPrdVen_ChangePV()
                Me.Cursor = Windows.Forms.Cursors.Default
            End If
        Else
            txtTtlCst.Enabled = False
            txtItmCst.Enabled = False
            txtBOMCst.Enabled = False
        End If

        If chkReplacement.Checked = True Then
            txtZTNVBELN.Visible = True
            txtZTNPOSNR.Visible = True
            txtTentOrdno.Visible = False
            txtTentOrdSeq.Visible = False
            txtZTNVBELN.BringToFront()
            txtZTNPOSNR.BringToFront()
        Else
            txtZTNVBELN.Visible = False
            txtZTNPOSNR.Visible = False
            txtTentOrdno.Visible = True
            txtTentOrdSeq.Visible = True
            txtTentOrdno.BringToFront()
            txtTentOrdSeq.BringToFront()
        End If

        recordStatus = True
        reUpdateFlag = True
    End Sub

    Private Sub Replacement_Undo()
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 And chkReplacement.Enabled = True Then
            rs_SCORDDTL.Tables("RESULT").Columns("sod_ftyprc").ReadOnly = False
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ftyprc") = rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_orgfty")
            Next
        End If
    End Sub

    Private Sub chkCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkCancel.Click
        recordStatus = True
        If chkCancel.Enabled = True And txtSCVerNo.Text <> "1" Then
            MsgBox("Remember to Update PO ")
        End If
    End Sub

    Private Sub grdDis_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdDis.CellClick
        If cmdSave.Enabled = False Then
            Exit Sub
        End If

        If grdDis.SelectedCells.Count = 1 Then
            If grdDis.CurrentCell.ColumnIndex = dgvDisPre_Dele Then
                recordStatus = True
                rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_status").ReadOnly = False
                rs_SCDISPRM_D.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_status").ToString = " " Then
                    If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr").ToString <> "~*ADD*~" Then
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr") = "~*DEL*~"
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_status") = "Y"
                    ElseIf rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr").ToString = "~*ADD*~" Then
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr") = "~*NEW*~"
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_status") = "Y"
                    End If
                Else
                    If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr").ToString = "~*NEW*~" Then
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr") = "~*ADD*~"
                    Else
                        rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_creusr") = "~*UPD*~"
                    End If
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_status") = " "
                End If
            ElseIf grdDis.SelectedCells.Item(0).ColumnIndex = dgvDisPre_Code Then
                dropdownCombo(grdDis, "Discount")
            ElseIf grdDis.SelectedCells.Item(0).ColumnIndex = dgvDisPre_PctAmt Then
                If rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_pctamt") = "Percentage" Then
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_pctamt") = "Amount"
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_pct") = 0
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_amt") = 0
                    grdDis.Columns(8).ReadOnly = True
                    grdDis.Columns(9).ReadOnly = False
                    grdDis.Refresh()
                Else
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_pctamt") = "Percentage"
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_pct") = 0
                    rs_SCDISPRM_D.Tables("RESULT").Rows(grdDis.CurrentCell.RowIndex)("sdp_amt") = 0
                    grdDis.Columns(8).ReadOnly = False
                    grdDis.Columns(9).ReadOnly = True
                    grdDis.Refresh()
                End If
            End If
        End If
    End Sub

    Private Sub grdPre_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdPre.CellClick
        If cmdSave.Enabled = False Then
            Exit Sub
        End If

        If grdPre.SelectedCells.Count = 1 Then
            If grdPre.CurrentCell.ColumnIndex = 0 Then
                recordStatus = True
                rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_status").ReadOnly = False
                rs_SCDISPRM_P.Tables("RESULT").Columns("sdp_creusr").ReadOnly = False
                If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_status").ToString = " " Then
                    If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr").ToString <> "~*ADD*~" Then
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr") = "~*DEL*~"
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_status") = "Y"
                    ElseIf rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr").ToString = "~*ADD*~" Then
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr") = "~*NEW*~"
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_status") = "Y"
                    End If
                Else
                    If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr").ToString = "~*NEW*~" Then
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr") = "~*ADD*~"
                    Else
                        rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_creusr") = "~*UPD*~"
                    End If
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.SelectedCells.Item(0).RowIndex)("sdp_status") = " "
                End If
            ElseIf grdPre.CurrentCell.ColumnIndex = 5 Then
                dropdownCombo(grdPre, "Premium")
            ElseIf grdPre.CurrentCell.ColumnIndex = dgvDisPre_PctAmt Then
                If rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_pctamt") = "Percentage" Then
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_pctamt") = "Amount"
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_pct") = 0
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_amt") = 0
                    grdPre.Columns(8).ReadOnly = True
                    grdPre.Columns(9).ReadOnly = False
                    grdPre.Refresh()
                Else
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_pctamt") = "Percentage"
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_pct") = 0
                    rs_SCDISPRM_P.Tables("RESULT").Rows(grdPre.CurrentCell.RowIndex)("sdp_amt") = 0
                    grdPre.Columns(8).ReadOnly = False
                    grdPre.Columns(9).ReadOnly = True
                    grdPre.Refresh()
                End If
            End If
        End If
    End Sub

    Private Sub dropdownCombo(ByVal dgv As DataGridView, ByVal typ As String)
        Dim cboCell As New DataGridViewComboBoxCell
        Dim iCol As Integer = dgv.CurrentCell.ColumnIndex
        Dim iRow As Integer = dgv.CurrentCell.RowIndex

        Dim row As DataGridViewRow = dgv.CurrentRow

        'If Not TypeOf dgv.Rows(iRow).Cells(iCol) Is DataGridViewComboBoxCell Then
        Select Case typ
            Case "Discount"
                For i As Integer = 0 To lstDis.Count - 1
                    cboCell.Items.Add(lstDis.Item(i).ToString)
                Next
            Case "Premium"
                For i As Integer = 0 To lstPre.Count - 1
                    cboCell.Items.Add(lstPre.Item(i).ToString)
                Next
        End Select

        cboCell.DropDownWidth = 250
        cboCell.DisplayStyle = DataGridViewComboBoxDisplayStyle.ComboBox

        dgv.Rows(iRow).Cells(iCol) = cboCell
        dgv.Rows(iRow).Cells(iCol).ReadOnly = False
        'End If
    End Sub

    Private Sub textboxCombo(ByVal dgv As DataGridView, ByVal typ As String)
        Dim txtCell As New DataGridViewTextBoxCell
        Dim iCol As Integer = DisPreEditCellCol
        Dim iRow As Integer = DisPreEditCellRow

        Dim code As String = Split(dgv.Rows(iRow).Cells(iCol).Value, " - ")(0)
        Dim desc As String
        If Trim(dgv.Rows(iRow).Cells(iCol).Value.ToString) = "" Then
            desc = " "
        ElseIf dgv.Rows(iRow).Cells(iCol).Value.ToString.Length < 3 Then
            desc = dgv.Rows(iRow).Cells("sdp_dsc").Value
        Else
            desc = Split(dgv.Rows(iRow).Cells(iCol).Value, " - ")(1)
        End If
        Select Case typ
            Case "Discount"
                Dim drD() As DataRow = rs_SCDISPRM_D.Tables("RESULT").Select("sdp_seqno = '" & dgv.Rows(iRow).Cells("sdp_seqno").Value.ToString & "'")
                drD(0).Item("sdp_dsc") = desc
                drD(0).Item("sdp_cde") = code
            Case "Premium"
                Dim drP() As DataRow = rs_SCDISPRM_P.Tables("RESULT").Select("sdp_seqno = '" & dgv.Rows(iRow).Cells("sdp_seqno").Value.ToString & "'")
                drP(0).Item("sdp_dsc") = desc
                drP(0).Item("sdp_cde") = code
        End Select
        dgv.Rows(iRow).Cells(iCol) = txtCell
        dgv.Refresh()
        dgv.Rows(iRow).Cells(iCol).ReadOnly = False
    End Sub

    Private Sub grdDisPre_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles grdDis.DataError, grdPre.DataError
        'Intentionally Left Empty
    End Sub

    Private Sub CancelAllDtl()
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
                rs_SCORDDTL.Tables("RESULT").Columns(i).ReadOnly = False
            Next

            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                If txtSCVerNo.Text = "1" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty") = 0
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_selprc") = 0
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn") = 0
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_selprc") = 0
                Else
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty") = rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_shpqty")
                    Cal_DtlTotalCtn(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty"))
                    Cal_DtlPrcSubTTl(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_netuntprc"), rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_discnt"), Custfml, rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty"))

                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ttlctn") = lblTotalCtn.Text
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_selprc") = txtSelprc.Text
                End If
                If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*ADD*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*DEL*~" And _
                   rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" Then
                    rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*UPD*~"
                End If
            Next

            'For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
            '    rs_SCORDDTL.Tables("RESULT").Columns(i).ReadOnly = True
            'Next
        End If
        Cal_TotalAmt()
    End Sub

    Private Sub CloseOut_Assign_Vendor()
        Dim Vendor_Code As String
        If gsCompany = "UCPP" Then
            Vendor_Code = "P"
        Else
            Vendor_Code = "0001"
        End If

        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            Dim drCloseOut() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' ")
            If drCloseOut.Length > 0 Then
                For i As Integer = 0 To drCloseOut.Length - 1
                    drCloseOut(i).Item("sod_venno") = Vendor_Code
                    drCloseOut(i).Item("sod_venitm") = ""
                    drCloseOut(i).Item("sod_ftyprc") = 0
                    drCloseOut(i).Item("sod_fcurcde") = ""
                    drCloseOut(i).Item("sod_ftyunt") = ""
                    drCloseOut(i).Item("sod_venitm") = ""
                    drCloseOut(i).Item("sod_itmprc") = 0
                    drCloseOut(i).Item("sod_basprc") = 0
                    drCloseOut(i).Item("sod_subcde") = ""
                    drCloseOut(i).Item("sod_moq") = 0
                    drCloseOut(i).Item("sod_moa") = 0
                Next
            End If
        End If
    End Sub

    Private Function checkDTL_HLD(ByVal typ As String) As Boolean
        Dim S As String
        Dim rsTmp As New DataSet

        rs_SCORDDTL.Tables("RESULT").Columns("sod_apprve").ReadOnly = False
        rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False

        Select Case typ
            Case "Credit"
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    '****** Modify the cal over limit to remove the last time net amt first then add this time net amount to check******
                    If (CreditUse - beforeNetAmt + CDbl(txtNetAmt.Text) > CreditAmt) And CDbl(txtNetAmt.Text) <> 0 Then
                        checkDTL_HLD = False
                        If beforeNetAmt >= CDbl(txtNetAmt.Text) And beforeStatus = "ACT" Then
                            checkDTL_HLD = True
                            overlimit = False
                        ElseIf beforeNetAmt >= CDbl(txtNetAmt.Text) And Me.chkApprove.Checked = False Then
                            overlimit = False
                        Else
                            overlimit = True
                        End If
                        Exit Function
                    Else
                        overlimit = False
                        checkDTL_HLD = True
                    End If
                Else
                    overlimit = False
                    checkDTL_HLD = True
                End If

                '******************Check MOA /MOQ *****************************************************************************
            Case "MOQ"
                '----
                checkDTL_HLD = True
                '----

                ' Added by Mark Lau 20090205
                Dim intConftr As Integer

                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then

                    Dim drMOQ() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'", "sod_ordseq")
                    If drMOQ.Length > 0 Then
                        For i As Integer = 0 To drMOQ.Length - 1

                            '---- Frankie Cheung 20110719 ----

                            gspStr = "sp_select_SYCONFTR_SC '" & cboCoCde.Text & "','" & drMOQ(i).Item("sod_pckunt") & "','PC'"
                            rtnLong = execute_SQLStatement(gspStr, rsTmp, rtnStr)

                            If rtnLong <> RC_SUCCESS Then
                                MsgBox("Error on loading SCM00001 #066 sp_select_SYCONFTR_SC : " & rtnStr)
                            Else
                                If rsTmp.Tables("RESULT").Rows.Count > 0 Then
                                    intConftr = CInt(rsTmp.Tables("RESULT").Rows(0)("ycf_value"))
                                End If
                            End If

                            '--------------------------------

                            If drMOQ(i).Item("sod_tirtyp") = "1" And drMOQ(i).Item("sod_cusmoqchg") = "Y" And chkCloseOut.Checked = False And chkReplacement.Checked = False Then

                                If ((drMOQ(i).Item("sod_moq") > IIf(drMOQ(i).Item("sod_moqunttyp") = "CTN", drMOQ(i).Item("sod_ttlctn"), drMOQ(i).Item("sod_mtrctn") * intConftr * drMOQ(i).Item("sod_ttlctn"))) Or _
                                    CDbl(drMOQ(i).Item("sod_moa")) > CDbl(drMOQ(i).Item("sod_selprc"))) And (drMOQ(i).Item("sod_ordqty") <> drMOQ(i).Item("sod_shpqty")) And _
                                    drMOQ(i).Item("sod_ordqty") <> 0 And drMOQ(i).Item("sod_apprve") <> "Y" And chkReplacement.Checked = False And _
                                    drMOQ(i).Item("sod_moqchg") < drMOQ(i).Item("sod_orgmoqchg") Then

                                    drMOQ(i).Item("sod_apprve") = "W"
                                    MOQ_MOA = True
                                    checkDTL_HLD = False
                                    If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                        drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                                    End If
                                Else
                                    If drMOQ(i).Item("sod_apprve").ToString <> "Y" And drMOQ(i).Item("sod_apprve").ToString <> "N" Then
                                        drMOQ(i).Item("sod_apprve") = "N"
                                        If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                            drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                                        End If
                                    End If
                                End If
                            Else

                                If ((drMOQ(i).Item("sod_moq") > IIf(drMOQ(i).Item("sod_moqunttyp").ToString = "CTN", drMOQ(i).Item("sod_ttlctn"), drMOQ(i).Item("sod_mtrctn") * intConftr * drMOQ(i).Item("sod_ttlctn"))) Or _
                                    CDbl(drMOQ(i).Item("sod_moa")) > CDbl(drMOQ(i).Item("sod_selprc"))) _
                                    And (drMOQ(i).Item("sod_ordqty") <> drMOQ(i).Item("sod_shpqty")) _
                                    And drMOQ(i).Item("sod_ordqty") <> 0 And drMOQ(i).Item("sod_apprve").ToString <> "Y" _
                                    And chkReplacement.Checked = False Then

                                    drMOQ(i).Item("sod_apprve") = "W"
                                    If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                        drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                                    End If
                                    MOQ_MOA = True
                                    checkDTL_HLD = False
                                Else
                                    If drMOQ(i).Item("sod_apprve").ToString <> "Y" And drMOQ(i).Item("sod_apprve").ToString <> "W" Then
                                        drMOQ(i).Item("sod_apprve") = "N"
                                        If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                            drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                                        End If
                                    End If
                                End If
                            End If
                        Next

                    End If
                    MOQ_MOA = False
                End If

                '****************************Check Item Basic > Selling Price***************************************************
            Case "Price"
                '---
                checkDTL_HLD = True
                '---
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    Dim drPrice() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'")
                    If drPrice.Length > 0 Then
                        For i As Integer = 0 To drPrice.Length - 1

                            ' Use Minimum Markup Price to compare with Item Price
                            If drPrice(i)("sod_itmprc") > 0 And drPrice(i)("sod_itmprc") <> drPrice(i)("sod_basprc") Then
                                If (drPrice(i)("sod_itmprc") > drPrice(i)("sod_untprc") Or CDbl(drPrice(i).Item("sod_itmprc")) = 0 Or CDbl(drPrice(i).Item("sod_ftyprc")) = 0) _
                                     And (drPrice(i).Item("sod_ordqty") <> drPrice(i).Item("sod_shpqty")) _
                                     And drPrice(i).Item("sod_ordqty") <> 0 And drPrice(i).Item("sod_apprve").ToString <> "Y" _
                                     And chkReplacement.Checked = False Then
                                    drPrice(i).Item("sod_apprve") = "W"
                                    If drPrice(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                        drPrice(i).Item("sod_creusr") = "~*UPD*~"
                                    End If
                                    checkDTL_HLD = False
                                End If
                            Else
                                ' Use Basic Price to compare with Item Price
                                If ((Math.Truncate(CDbl(drPrice(i).Item("sod_itmprc")) * 100) / 100 > Math.Truncate(CDbl(drPrice(i).Item("sod_untprc")) * 100) / 100) Or _
                                     CDbl(drPrice(i).Item("sod_itmprc")) = 0 Or CDbl(drPrice(i).Item("sod_ftyprc")) = 0) _
                                     And (drPrice(i).Item("sod_ordqty") <> drPrice(i).Item("sod_shpqty")) _
                                     And drPrice(i).Item("sod_ordqty") <> 0 And drPrice(i).Item("sod_apprve").ToString <> "Y" _
                                     And chkReplacement.Checked = False Then
                                    drPrice(i).Item("sod_apprve") = "W"
                                    If drPrice(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                        drPrice(i).Item("sod_creusr") = "~*UPD*~"
                                    End If
                                    checkDTL_HLD = False
                                End If
                            End If
                        Next
                    End If
                End If

            Case "Period"
                Dim rs_vendors As DataSet
                gspStr = "sp_list_VNBASINF ''"
                execute_SQLStatement(gspStr, rs_vendors, rtnLong)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #106 sp_list_VNBASINF : " & rtnStr)
                    Return False
                End If
                '---
                checkDTL_HLD = True
                '---
                If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
                    Dim drPeriod() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'")
                    If drPeriod.Length > 0 Then
                        Dim drVendor As DataRow()
                        For i As Integer = 0 To drPeriod.Length - 1
                            drVendor = Nothing
                            drVendor = rs_vendors.Tables("RESULT").Select("vbi_venno = '" & drPeriod(i).Item("sod_venno") & "'")
                            If drVendor.Length > 0 Then
                                If drVendor(0).Item("vbi_ventyp") <> "E" Then
                                    If ((drPeriod(i).Item("sod_qutdat") <> drPeriod(i).Item("sod_imqutdat")) _
                                      And (drPeriod(i).Item("sod_qutdat") > "01/01/1900" And drPeriod(i).Item("sod_imqutdat") > "01/01/1900") _
                                      And (drPeriod(i).Item("sod_apprve").ToString <> "Y" Or drPeriod(i).Item("sod_imqutdatchg").ToString = "Y")) Then
                                        drPeriod(i).Item("sod_apprve") = "W"
                                        If drPeriod(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                            drPeriod(i).Item("sod_creusr") = "~*UPD*~"
                                        End If
                                        checkDTL_HLD = False
                                    End If
                                End If
                            End If
                        Next
                    End If
                End If

        End Select

    End Function

    Private Sub Approve_Dtl(ByVal typ As String)

        ' Added by Mark Lau 20090205
        Dim intConftr As Integer
        Dim rsTmp As New DataSet
        Dim S As String

        rs_SCORDDTL.Tables("RESULT").Columns("sod_apprve").ReadOnly = False
        rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False

        Select Case typ
            Case "MOQ"

                ' Added by Mark Lau 20090205
                gspStr = "sp_select_SYCONFTR_SC '" & cboCoCde.Text & "','" & txtUM.Text & "','PC'"

                'Fixing global company code problem at 20100420
                gsCompany = Trim(cboCoCde.Text)
                Update_gs_Value(gsCompany)

                rtnLong = execute_SQLStatement(gspStr, rsTmp, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #067 sp_select_SYCONFTR_SC : " & rtnStr)
                Else
                    If rsTmp.Tables("RESULT").Rows.Count > 0 Then
                        intConftr = CInt(rsTmp.Tables("RESULT").Rows(0)("ycf_value"))
                    End If
                End If

                Dim drMOQ() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'", "sod_ordseq")
                If drMOQ.Length > 0 Then
                    For i As Integer = 0 To drMOQ.Length - 1
                        If ((drMOQ(i).Item("sod_moq") > IIf(txtMOQUnttyp.Text = "CTN", drMOQ(i).Item("sod_ttlctn"), drMOQ(i).Item("sod_mtrctn") * intConftr * drMOQ(i).Item("sod_ttlctn"))) Or CDbl(drMOQ(i).Item("sod_moa")) > CDbl(drMOQ(i).Item("sod_selprc"))) _
                            And (drMOQ(i).Item("sod_ordqty") <> drMOQ(i).Item("sod_shpqty")) _
                            And drMOQ(i).Item("sod_ordqty") <> 0 And drMOQ(i).Item("sod_apprve").ToString = "W" _
                            And chkReplacement.Checked = False Then

                            ' Notes rs_SCORDDTL("sod_apprve").Value must be to = "W". otherwise, item not meet MOQ with surcharge will be set to "Y"
                            drMOQ(i).Item("sod_apprve") = "Y"
                            If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                            End If
                        End If

                        If drMOQ(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                            drMOQ(i).Item("sod_creusr") = "~*UPD*~"
                        End If
                    Next
                End If


            Case "SELPRC"
                Dim drSelPrc() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'")
                If drSelPrc.Length > 0 Then
                    For i As Integer = 0 To drSelPrc.Length - 1
                        If ((CDbl(drSelPrc(i).Item("sod_itmprc")) > CDbl(drSelPrc(i).Item("sod_untprc"))) Or _
                            CDbl(drSelPrc(i).Item("sod_itmprc")) = 0 Or CDbl(drSelPrc(i).Item("sod_ftyprc")) = 0) _
                            And (drSelPrc(i).Item("sod_ordqty") <> drSelPrc(i).Item("sod_shpqty")) _
                            And drSelPrc(i).Item("sod_ordqty") <> 0 And drSelPrc(i).Item("sod_apprve").ToString <> "Y" Then
                            drSelPrc(i).Item("sod_apprve") = "Y"
                            If drSelPrc(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                drSelPrc(i).Item("sod_creusr") = "~*UPD*~"
                            End If
                        End If
                        If drSelPrc(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                            drSelPrc(i).Item("sod_creusr") = "~*UPD*~"
                        End If
                    Next
                End If

                'Frankie Cheung 20110310
            Case "Period"

                Dim drPeriod() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~'")
                If drPeriod.Length > 0 Then
                    For i As Integer = 0 To drPeriod.Length - 1
                        If ((drPeriod(i).Item("sod_qutdat") <> drPeriod(i).Item("sod_imqutdat")) _
                            And drPeriod(i).Item("sod_apprve").ToString <> "Y") Then
                            drPeriod(i).Item("sod_apprve") = "Y"
                            If drPeriod(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                                drPeriod(i).Item("sod_creusr") = "~*UPD*~"
                            End If
                        End If
                        If drPeriod(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                            drPeriod(i).Item("sod_creusr") = "~*UPD*~"
                        End If
                    Next
                End If

        End Select
    End Sub

    Private Sub Apply_CanDat()
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            Dim drCanDat() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' ")
            If drCanDat.Length > 0 Then
                rs_SCORDDTL.Tables("RESULT").Columns("sod_candat").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False

                For i As Integer = 0 To drCanDat.Length - 1
                    drCanDat(i).Item("sod_candat") = IIf(txtCancelDat.Text = "  /  /", "", txtCancelDat.Text)
                    If drCanDat(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                        drCanDat(i).Item("sod_creusr") = "~*UPD*~"
                    End If
                Next
            End If
        End If

    End Sub
    Private Sub Apply_ShpDat()
        If rs_SCORDDTL.Tables("RESULT").Rows.Count > 0 Then
            Dim drShpDat() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_creusr <> '~*DEL*~' and sod_creusr <> '~*NEW*~' ")

            If drShpDat.Length > 0 Then
                rs_SCORDDTL.Tables("RESULT").Columns("sod_shpstr").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_shpend").ReadOnly = False
                rs_SCORDDTL.Tables("RESULT").Columns("sod_creusr").ReadOnly = False

                For i As Integer = 0 To drShpDat.Length - 1
                    drShpDat(i).Item("sod_shpstr") = txtStartShipDat.Text
                    drShpDat(i).Item("sod_shpend") = txtEndShipDat.Text
                    clearMore("SHP", drShpDat(i).Item("sod_ordseq"))
                    If drShpDat(i).Item("sod_creusr").ToString <> "~*ADD*~" Then
                        drShpDat(i).Item("sod_creusr") = "~*UPD*~"
                    End If
                Next
            End If
        End If
    End Sub

    Private Sub Update_SCASSINF_TABLE(ByVal Mode As String, ByVal dr As DataRow)

        Dim rs As New DataSet

        Select Case Mode
            Case "ADD"
                Dim drSCORDDTL() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_ordseq = '" & dr.Item("sai_ordseq") & "'")
                Dim sod_ordqty As String
                If drSCORDDTL.Length > 0 Then
                    sod_ordqty = drSCORDDTL(0).Item("sod_ordqty").ToString
                Else
                    sod_ordqty = "0"
                End If

                gspStr = "sp_insert_SCASSINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sai_ordseq2") & "','" & _
                         UCase(dr.Item("sai_itmno").ToString) & "','" & dr.Item("sai_assitm") & "','" & _
                         Replace(UCase(dr.Item("sai_assdsc").ToString), "'", "''") & "','" & Replace(dr.Item("sai_cusitm").ToString, "'", "''") & _
                         "','" & dr.Item("sai_colcde") & "','" & Replace(dr.Item("sai_coldsc").ToString, "'", "''") & "','" & _
                         Replace(dr.Item("sai_cussku").ToString, "'", "''") & "','" & Replace(dr.Item("sai_upcean").ToString, "'", "''") & "','" & _
                         Replace(dr.Item("sai_cusrtl").ToString, "'", "''") & "','" & dr.Item("sai_untcde") & "','" & dr.Item("sai_inrqty") & _
                         "','" & dr.Item("sai_mtrqty") & "','" & _
                         IIf(Trim(dr.Item("sai_imperiod")) = "" Or IsDBNull(dr.Item("sai_imperiod")), "1900-01-01", dr.Item("sai_imperiod") & "-01") & _
                         "','" & Replace(dr.Item("sai_cusstyno").ToString, "'", "''") & "','" & dr.Item("sai_tordno") & "','" & _
                         dr.Item("sai_tordseq") & "','" & sod_ordqty & "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #085 sp_insert_SCASSINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

            Case "UPDATE"
                Dim drSCASSINF_ori() As DataRow = rs_SCASSINF_ori.Tables("RESULT").Select("sai_ordseq = '" & dr.Item("sai_ordseq") & "' and sai_itmno = '" & dr.Item("sai_assitm") & "'")
                Dim old_toordno As String
                Dim old_toordseq As String
                If drSCASSINF_ori.Length > 0 Then
                    old_toordno = drSCASSINF_ori(0).Item("sai_tordno").ToString
                    old_toordseq = drSCASSINF_ori(0).Item("sai_tordseq").ToString
                Else
                    old_toordno = ""
                    old_toordseq = "0"
                End If

                Dim drSCORDDTL() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_ordseq = '" & dr.Item("sai_ordseq") & "'")
                Dim sod_ordqty As String
                If drSCORDDTL.Length > 0 Then
                    sod_ordqty = drSCORDDTL(0).Item("sod_ordqty").ToString
                Else
                    sod_ordqty = "0"
                End If

                Dim drSCORDDTL_ori() As DataRow = rs_SCORDDTL_ori.Tables("RESULT").Select("sod_ordseq = '" & dr.Item("sai_ordseq") & "'")
                Dim old_ordqty As String
                If drSCORDDTL_ori.Length > 0 Then
                    old_ordqty = drSCORDDTL_ori(0).Item("sod_ordqty").ToString
                Else
                    old_ordqty = "0"
                End If

                gspStr = "sp_update_SCASSINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sai_ordseq") & "','" & _
                        UCase(dr.Item("sai_itmno").ToString) & "','" & dr.Item("sai_assitm") & "','" & _
                        Replace(dr.Item("sai_assdsc").ToString, "'", "''") & "','" & Replace(dr.Item("sai_cusitm").ToString, "'", "''") & "','" & _
                        dr.Item("sai_colcde") & "','" & Replace(dr.Item("sai_coldsc").ToString, "'", "''") & "','" & _
                        Replace(dr.Item("sai_cussku").ToString, "'", "''") & "','" & Replace(dr.Item("sai_upcean").ToString, "'", "''") & "','" & _
                        Replace(dr.Item("sai_cusrtl").ToString, "'", "''") & "','" & dr.Item("sai_untcde") & "','" & dr.Item("sai_inrqty") & "','" & _
                        dr.Item("sai_mtrqty") & "','" & _
                        IIf(Trim(dr.Item("sai_imperiod")) = "" Or IsDBNull(dr.Item("sai_imperiod")), "1900-01-01", dr.Item("sai_imperiod") & "-01") & _
                        "','" & Replace(dr.Item("sai_cusstyno").ToString, "'", "''") & "','" & dr.Item("sai_tordno") & "','" & _
                        dr.Item("sai_tordseq") & "','" & sod_ordqty & "','" & old_toordno & "','" & old_toordseq & "','" & old_ordqty & "','" & (gsUsrID) & "'"

                'gspStr = "sp_update_SCASSINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sai_ordseq") & "','" & _
                '        UCase(dr.Item("sai_itmno").ToString) & "','" & dr.Item("sai_assitm") & "','" & _
                '        Replace(dr.Item("sai_assdsc").ToString, "'", "''") & "','" & Replace(dr.Item("sai_cusitm").ToString, "'", "''") & "','" & _
                '        dr.Item("sai_colcde") & "','" & Replace(dr.Item("sai_coldsc").ToString, "'", "''") & "','" & _
                '        Replace(dr.Item("sai_cussku").ToString, "'", "''") & "','" & Replace(dr.Item("sai_upcean").ToString, "'", "''") & "','" & _
                '        Replace(dr.Item("sai_cusrtl").ToString, "'", "''") & "','" & dr.Item("sai_untcde") & "','" & dr.Item("sai_inrqty") & "','" & _
                '        dr.Item("sai_mtrqty") & "','" & _
                '        IIf(Trim(dr.Item("sai_imperiod")) = "" Or IsDBNull(dr.Item("sai_imperiod")), "1900-01-01", dr.Item("sai_imperiod") & "-01") & _
                '        "','" & Replace(dr.Item("sai_cusstyno").ToString, "'", "''") & "','" & dr.Item("sai_tordno") & "','" & _
                '        dr.Item("sai_tordseq") & "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #086 sp_upddate_SCASSINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

            Case "DELETE"
                gspStr = "sp_Physical_Delete_SCASSINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sai_ordseq") & _
                         "','" & UCase(dr.Item("sai_itmno").ToString) & "','" & dr.Item("sai_assitm") & "','" & dr.Item("sai_colcde") & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on deleting SCM00001 #087 sp_Physical_Delete_SCASSINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

        End Select
    End Sub

    Private Sub Update_SCBOMINF_TABLE(ByVal Mode As String, ByVal dr As DataRow)

        Dim rs As New DataSet


        Select Case Mode
            Case "ADD"

                gspStr = "sp_insert_SCBOMINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sbi_ordseq2") & "','" & _
                         UCase(dr.Item("sbi_itmno").ToString) & "','" & dr.Item("sbi_assitm") & "','" & dr.Item("sbi_assinrqty") & "','" & _
                         dr.Item("sbi_assmtrqty") & "','" & dr.Item("sbi_bomitm") & "','" & dr.Item("sbi_venno") & "','" & _
                         Replace(UCase(dr.Item("sbi_bomdsce").ToString), "'", "''") & "','" & Replace(dr.Item("sbi_bomdscc"), "'", "''") & "','" & _
                         UCase(dr.Item("sbi_colcde").ToString) & "','" & Replace(dr.Item("sbi_coldsc"), "'", "''") & "','" & _
                         dr.Item("sbi_pckunt") & "','" & dr.Item("sbi_ordqty") & "','" & dr.Item("sbi_fcurcde") & "','" & dr.Item("sbi_ftyprc") & _
                         "','" & dr.Item("sbi_bcurcde") & "','" & dr.Item("sbi_bomcst") & "','" & dr.Item("sbi_obcurcde") & "','" & _
                         dr.Item("sbi_obomcst") & "','" & dr.Item("sbi_obomprc") & "','" & dr.Item("sbi_bompoflg") & "','" & _
                         IIf(Trim(dr.Item("sbi_imperiod").ToString) = "" Or IsDBNull(dr.Item("sbi_imperiod")), "", dr.Item("sbi_imperiod") & "-01") & _
                         "','" & LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #089 sp_insert_SCBOMINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

            Case "UPDATE"

                gspStr = "sp_update_SCBOMINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sbi_ordseq") & "','" & _
                         UCase(dr.Item("sbi_itmno").ToString) & "','" & dr.Item("sbi_assitm") & "','" & dr.Item("sbi_assinrqty") & "','" & _
                         dr.Item("sbi_assmtrqty") & "','" & dr.Item("sbi_bomitm") & "','" & dr.Item("sbi_venno") & "','" & _
                         Replace(UCase(dr.Item("sbi_bomdsce").ToString), "'", "''") & "','" & Replace(dr.Item("sbi_bomdscc"), "'", "''") & _
                         "','" & UCase(dr.Item("sbi_colcde").ToString) & "','" & Replace(dr.Item("sbi_coldsc"), "'", "''") & "','" & _
                         dr.Item("sbi_pckunt") & "','" & dr.Item("sbi_ordqty") & "','" & dr.Item("sbi_fcurcde") & "','" & dr.Item("sbi_ftyprc") & _
                         "','" & dr.Item("sbi_bcurcde") & "','" & dr.Item("sbi_bomcst") & "','" & dr.Item("sbi_obcurcde") & "','" & _
                         dr.Item("sbi_obomcst") & "','" & dr.Item("sbi_obomprc") & "','" & dr.Item("sbi_bompoflg") & "','" & _
                         IIf(Trim(dr.Item("sbi_imperiod")) = "" Or IsDBNull(dr.Item("sbi_imperiod")), "", dr.Item("sbi_imperiod") & "-01") & "','" & _
                         LCase(gsUsrID) & "'"

                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on saving SCM00001 #090 sp_update_SCBOMINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

            Case "DELETE"

                'gspStr = "㊣SCBOMINF※P※" & UCase(txtSCNo.Text) & "','" & dr.Item("sbi_ordseq") & "','" & UCase(dr.Item("sbi_itmno").ToString) & _
                '         "','" & dr.Item("sbi_assitm") & "','" & dr.Item("sbi_bomitm") & "','" & dr.Item("sbi_colcde") & "'"
                gspStr = "sp_physical_delete_SCBOMINF '" & cboCoCde.Text & "','" & UCase(txtSCNo.Text) & "','" & dr.Item("sbi_ordseq") & "','" & _
                         UCase(dr.Item("sbi_itmno").ToString) & "','" & dr.Item("sbi_assitm") & "','" & dr.Item("sbi_bomitm") & "','" & _
                         dr.Item("sbi_colcde") & "'"
                If gspStr <> "" Then  '*** if there is something to do with s ...
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                    If rtnLong <> RC_SUCCESS Then  '*** An error has occured
                        MsgBox("Error on deleting SCM00001 #091 sp_Physical_Delete_SCBOMINF : " & rtnStr)
                        isUpdated = False
                    Else
                        isUpdated = True
                    End If
                End If

        End Select
    End Sub


    Private Sub cmdUpdItmPckInfo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdUpdItmPckInfo.Click
        Dim colcde As String
        Dim um As String
        Dim inner As String
        Dim master As String
        Dim CFT As String
        Dim CBM As String
        Dim HKPrcTrm As String
        Dim FtyPrcTrm As String
        Dim TranTrm As String
        Dim cus1no As String = ""
        Dim cus2no As String = ""

        Dim rs As New DataSet


        If Trim(cboColPckInfo.Text) <> "" Then
            colcde = Split(cboColPckInfo.Text, " / ")(0)
            um = Split(cboColPckInfo.Text, " / ")(1)
            inner = Split(cboColPckInfo.Text, " / ")(2)
            master = Split(cboColPckInfo.Text, " / ")(3)
            CFT = Split(cboColPckInfo.Text, " / ")(4)
            CBM = Split(cboColPckInfo.Text, " / ")(5)
            FtyPrcTrm = Split(cboColPckInfo.Text, " / ")(6)
            HKPrcTrm = Split(cboColPckInfo.Text, " / ")(7)
            TranTrm = Split(cboColPckInfo.Text, " / ")(8)
        End If

        If UCase(txtPrcGrp.Text) <> "STANDARD" Then
            cus1no = Split(txtPrcGrp.Text, " / ")(0)
            If Split(txtPrcGrp.Text, " / ").Length >= 2 Then
                cus2no = Split(txtPrcGrp.Text, " / ")(1)
            End If
        End If

        gspStr = "sp_select_IMPCKINF_SC '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & um & "','" & inner & _
                 "','" & master & "','" & IIf(txtConftr.Text = "", 1, txtConftr.Text) & "','" & cus1no & "','" & cus2no & _
                 "','" & Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #101 sp_select_IMPCKINF_SC : " & rtnStr)
            Exit Sub
        Else
            rs_IMPCKINF = rs.Copy()
        End If

        If rs_IMPCKINF.Tables("RESULT").Rows.Count > 1 Then
            MsgBox("More than one same UM, Inner & Master found in Item Master, Record will not be updated !")
            Exit Sub
        Else
            If rs_IMPCKINF.Tables("RESULT").Rows.Count = 0 Then
                MsgBox("No Such Packing Information in Item Master !")
                Exit Sub
            Else
                CFT = Format(rs_IMPCKINF.Tables("RESULT").Rows(0)("IPI_CFT"), "#0.0000")
                CBM = Format(rs_IMPCKINF.Tables("RESULT").Rows(0)("IPI_CBM"), "#0.0000")
            End If
        End If

        cboColPckInfo.Items.Clear()
        cboColPckInfo.Items.Add(colcde & " / " & um & " / " & inner & " / " & master & " / " & CFT & " / " & CBM & " / " & FtyPrcTrm & " / " & HKPrcTrm & " / " & TranTrm)
        cboColPckInfo.SelectedIndex = 0
        recordStatus_dtl = True
        chkUpdatePO.Checked = True

    End Sub

    Private Sub cmdOrgScCst_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdOrgScCst.Click
        Enq_right = Enq_right_local
        recordStatus = True

        If Org_SCCst Is Nothing Then
            Org_SCCst = New SCM00001_OrgSCst
            Org_SCCst.myOwner = Me
        End If

        rs_SCORDDTL_SUB = rs_SCORDDTL.Copy()

        Org_SCCst.ShowDialog()
        recordStatus_dtl = True
    End Sub

    Private Sub cmdMoreShp_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdMoreShp.Click
        'Enq_right = Enq_right_local
        'recordStatus = True

        'If SCShip_SUB Is Nothing Then
        '    SCShip_SUB = New frmSCShip
        '    SCShip_SUB.myOwner = Me
        'End If

        'SCShip_SUB.ShowDialog()
        'recordStatus_dtl = True

        freeze_TabControl(tabFrame_Detail)
        grpDetail.Enabled = False
        panDtlShpDat.Width = 926
        panDtlShpDat.Height = 286
        panDtlShpDat.Location = New Point(15, 75)
        loadPanDtlShpDat(Split(cboSCStatus.Text, " - ")(0))
        panDtlShpDat.BringToFront()
        initFlag = True
        panDtlShpDat.Visible = True
        initFlag = False
        dgSCShpDat.ClearSelection()
        recordStatus_dtl = True
    End Sub

    Public Sub UpdBOMItm()
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        ITEMBOM_Check()
        Me.Cursor = Windows.Forms.Cursors.Default
    End Sub

    Public Sub UpdASSItm()
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        ITEMASS_Check()
        Me.Cursor = Windows.Forms.Cursors.Default
    End Sub

    Private Sub check_integer_input(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtStartCarton.KeyPress, txtEndCarton.KeyPress, txtOrdQty.KeyPress, txtPC.KeyPress, txtDept.KeyPress
        If Asc(e.KeyChar) = 46 Then
            e.KeyChar = Chr(0)
        ElseIf Asc(e.KeyChar) = 8 Then
            Return
        ElseIf Not IsNumeric(e.KeyChar) Then
            e.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub txtPC_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPC.TextChanged
        If Not (chkPC.Checked = True And chkPC.Visible = True) Then Exit Sub
        If Trim(Me.txtPC.Text) = "" Then
            Me.txtOrdQty.Text = ""
            Exit Sub
        End If
        If Not IsNumeric(Me.txtPC.Text) Then Exit Sub

        If Not IsNumeric(Me.txtConftr.Text) Then
            MsgBox("Invalid Conversion Factor", vbInformation + vbOKOnly, "Assortment Item")
            Exit Sub
        End If

        Try
            If Me.txtPC.Text <> "" Then
                Me.txtOrdQty.Text = Math.Round(CDbl(Me.txtPC.Text) / CDbl(Me.txtConftr.Text), 0)
            Else
                Me.txtOrdQty.Text = ""
            End If
        Catch ex As Exception
            MsgBox(ex.Message & Environment.NewLine & "Please check order qty.")
        End Try
    End Sub

    Private Sub txtPCPrc_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPCPrc.TextChanged
        If Not (chkPC.Checked = True And chkPC.Visible = True) Then Exit Sub
        If Not IsNumeric(Me.txtPCPrc.Text) Then Exit Sub

        If Not IsNumeric(Me.txtConftr.Text) Then
            MsgBox("Invalid Conversion Factor", MsgBoxStyle.Information, "Assortment Item")
            Exit Sub
        End If

        Me.txtUntPrc.Text = Format(CDbl(Me.txtPCPrc.Text) * CInt(Me.txtConftr.Text), "########0.0000")
    End Sub

    Private Sub check_percent_input(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDuty.KeyPress
        If Asc(e.KeyChar) = 46 Then
            If sender.Text.Contains(".") Then
                e.KeyChar = Chr(0)
            End If
        ElseIf Asc(e.KeyChar) = 8 Then
            Return
        ElseIf Not IsNumeric(e.KeyChar) Then
            e.KeyChar = Chr(0)
        Else
            If InStr(sender.Text, ".") > 0 Then
                If sender.Text.Substring(sender.Text.Length - (sender.Text.Length - InStr(sender.Text, ".")), sender.Text.Length - InStr(sender.Text, ".")).Length >= 3 And sender.SelectionStart >= InStr(sender.Text, ".") Then
                    If sender.SelectionLength = 0 Then
                        e.KeyChar = Chr(0)
                    End If
                ElseIf sender.Text.Substring(0, InStr(sender.Text, ".")).Length > 3 And sender.SelectionStart < InStr(sender.Text, ".") Then
                    If sender.SelectionLength = 0 Then
                        e.KeyChar = Chr(0)
                    End If
                End If
            Else
                If sender.Text.Length >= 3 Then
                    e.KeyChar = Chr(0)
                End If
            End If
        End If
    End Sub

    Private Sub check_UPCEAN(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtCdeMer.KeyPress, txtCdeInr.KeyPress, txtCdeCtn.KeyPress
        If Asc(e.KeyChar) = 46 Then
            e.KeyChar = Chr(0)
        ElseIf Asc(e.KeyChar) = 8 Then
            Return
        ElseIf IsNumeric(e.KeyChar) Then
            Return
        ElseIf sender.Text.Length >= 25 Then
            e.KeyChar = Chr(0)
        Else
            e.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub imu_key_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles imu_key.GotFocus
        imu_key.Width = 250
        imu_key.Height = 100
        imu_key.BringToFront()
        imu_key.Location = New Point(imu_key.Location.X - 205, imu_key.Location.Y - 80)
        imu_key.SelectionStart = 0
        imu_key.SelectionLength = 0

    End Sub

    Private Sub imu_key_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles imu_key.LostFocus
        imu_key.Width = 90
        imu_key.Height = 20
        imu_key.Location = New Point(imu_key.Location.X + 205, imu_key.Location.Y + 80)
    End Sub


    Private Sub chkPC_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkPC.CheckedChanged
        recordStatus_dtl = True
        recordStatus = True
        If chkPC.Checked = True Then
            If Mid(gsUsrGrp, 1, 3) = "PKG" Then
                txtPCPrc.Visible = False
                lblPCPrc.Visible = False
                lblPCPrcCur.Visible = False
            Else
                txtPCPrc.Visible = True
                lblPCPrc.Visible = True
                lblPCPrcCur.Visible = True
            End If

            txtUntPrc.ReadOnly = True
            lblPeriod.Visible = False    'Frankie 20110411
            txtOrdQty.ReadOnly = True
            txtPC.Visible = True
            lblPC.Visible = True
            If Len(Me.txtUntPrc.Text) > 0 And Len(Me.txtConftr.Text) > 0 Then
                Me.txtPCPrc.Text = Math.Round(CDbl(Me.txtUntPrc.Text) / CInt(Me.txtConftr.Text), 4)
            End If
            If Len(Me.txtOrdQty.Text) > 0 And Len(Me.txtConftr.Text) > 0 Then
                Me.txtPC.Text = Math.Round(CDbl(Me.txtOrdQty.Text) * CInt(Me.txtConftr.Text), 0)
            End If
        Else
            txtUntPrc.ReadOnly = False
            txtPCPrc.Visible = False
            lblPCPrc.Visible = False
            lblPCPrcCur.Visible = False
            lblPeriod.Visible = True    'Frankie 20110411
            txtOrdQty.ReadOnly = False
            txtPC.Visible = False
            lblPC.Visible = False
        End If
    End Sub

    Private Sub grdSummary_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSummary.CellClick
        If e.RowIndex >= 0 And e.ColumnIndex >= 0 Then
            If e.ColumnIndex = dgSummary_OnePrc Then
                If OptOnePrcN.Enabled = True And OptOnePrcY.Enabled = True Then
                    comboBoxCell(dgSummary, "OneTimePrc")
                End If
            ElseIf e.ColumnIndex = dgSummary_CusUSDCur Then
                If cboRetailUSDCur.Enabled = True Then
                    comboBoxCell(dgSummary, "CusUSDCur")
                End If
            ElseIf e.ColumnIndex = dgSummary_CusCADCur Then
                If cboRetailCADCur.Enabled = True Then
                    comboBoxCell(dgSummary, "CusCADCur")
                End If
            ElseIf e.ColumnIndex = dgSummary_CustUM Then
                If cboCustUM.Enabled = True Then
                    comboBoxCell(dgSummary, "CustUM")
                End If
            End If
        End If
    End Sub

    Private Sub dgSummary_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSummary.RowEnter
        If initFlag = True Then
            Exit Sub
        End If

        If e.RowIndex >= 0 Then
            currentRow = e.RowIndex
            currentOrdSeq = dgSummary.Rows(e.RowIndex).Cells("sod_ordseq").Value
            recordMove("SKIP")

            Dim dr() As DataRow

            ' Previous Job Item
            If txtPJobNo.Enabled = True And txtPJobNo.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_PJobNo).ReadOnly = False
                dgSummary.Columns(dgSummary_PJobNo).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_PJobNo).ReadOnly = True
            End If
            ' Customer Item Number
            If txtCustItmno.Enabled = True And txtCustItmno.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_CusItm).ReadOnly = False
                dgSummary.Columns(dgSummary_CusItm).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_CusItm).ReadOnly = True
            End If
            ' Customer SKU
            If txtSKUNo.Enabled = True And txtSKUNo.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_CusSKU).ReadOnly = False
                dgSummary.Columns(dgSummary_CusSKU).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_CusSKU).ReadOnly = True
            End If
            ' Secondary Customer Item Number
            If txtSecCusItm.Enabled = True And txtSecCusItm.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_SecCusItm).ReadOnly = False
                dgSummary.Columns(dgSummary_SecCusItm).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_SecCusItm).ReadOnly = True
            End If
            ' Order Quantity
            If txtOrdQty.Enabled = True And txtOrdQty.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_OrdQty).ReadOnly = False
                dgSummary.Columns(dgSummary_OrdQty).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_OrdQty).ReadOnly = True
            End If
            ' Selling Price
            If txtUntPrc.Enabled = True And txtUntPrc.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_SelPrc).ReadOnly = False
                dgSummary.Columns(dgSummary_SelPrc).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_SelPrc).ReadOnly = True
            End If
            ' Carton No Start
            If txtStartCarton.Enabled = True And txtStartCarton.ReadOnly = False Then
                dr = Nothing
                dr = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & dgSummary_OrdSeq & "' and sds_status <> 'Y'")
                If dr.Length = 0 Then
                    'dgSummary.Columns(dgSummary_CtnStr).ReadOnly = False
                    dgSummary.Columns(dgSummary_CtnStr).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_CtnStr).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_CtnStr).ReadOnly = True
            End If
            ' Carton No End
            If txtEndCarton.Enabled = True And txtEndCarton.ReadOnly = False Then
                dr = Nothing
                dr = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & dgSummary_OrdSeq & "' and sds_status <> 'Y'")
                If dr.Length = 0 Then
                    'dgSummary.Columns(dgSummary_CtnEnd).ReadOnly = False
                    dgSummary.Columns(dgSummary_CtnEnd).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_CtnEnd).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_CtnEnd).ReadOnly = True
            End If
            'PV Item Cost
            If txtItmCst.Enabled = True And txtItmCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_FtyCst).ReadOnly = False
                    dgSummary.Columns(dgSummary_FtyCst).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_FtyCst).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_FtyCst).ReadOnly = True
            End If
            'PV BOM Cost
            If txtBOMCst.Enabled = True And txtBOMCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_BOMCst).ReadOnly = False
                    dgSummary.Columns(dgSummary_BOMCst).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_BOMCst).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_BOMCst).ReadOnly = True
            End If
            'PV Total Cost
            If txtTtlCst.Enabled = True And txtTtlCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_FtyPrc).ReadOnly = False
                    dgSummary.Columns(dgSummary_FtyPrc).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_FtyPrc).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_FtyPrc).ReadOnly = True
            End If
            'DV Item Cost
            If txtDVItmCst.Enabled = True And txtDVItmCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_DVFtyCst).ReadOnly = False
                    dgSummary.Columns(dgSummary_DVFtyCst).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_DVFtyCst).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_DVFtyCst).ReadOnly = True
            End If
            'DV BOM Cost
            If txtDVBOMCst.Enabled = True And txtDVBOMCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_DVBOMCst).ReadOnly = False
                    dgSummary.Columns(dgSummary_DVBOMCst).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_DVBOMCst).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_DVBOMCst).ReadOnly = True
            End If
            'DV Total Cost
            If txtDVTtlCst.Enabled = True And txtDVTtlCst.ReadOnly = False Then
                If gsFlgCst = "1" And gsFlgCstExt = "1" Then
                    'dgSummary.Columns(dgSummary_DVFtyPrc).ReadOnly = False
                    dgSummary.Columns(dgSummary_DVFtyPrc).ReadOnly = True
                Else
                    dgSummary.Columns(dgSummary_DVFtyPrc).ReadOnly = True
                End If
            Else
                dgSummary.Columns(dgSummary_DVFtyPrc).ReadOnly = True
            End If
            ' HSTU / Tariff
            If cboHSTU.Enabled = True Then
                'dgSummary.Columns(dgSummary_HrmCde).ReadOnly = False
                dgSummary.Columns(dgSummary_HrmCde).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_HrmCde).ReadOnly = True
            End If
            ' Duty Rate
            If txtDuty.Enabled = True And txtDuty.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_DtyRat).ReadOnly = False
                dgSummary.Columns(dgSummary_DtyRat).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_DtyRat).ReadOnly = True
            End If
            ' UPC / EAN (M)
            If txtCdeMer.Enabled = True And txtCdeMer.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_Code1).ReadOnly = False
                dgSummary.Columns(dgSummary_Code1).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_Code1).ReadOnly = True
            End If
            ' UPC / EAN (I)
            If txtCdeInr.Enabled = True And txtCdeInr.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_Code2).ReadOnly = False
                dgSummary.Columns(dgSummary_Code2).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_Code2).ReadOnly = True
            End If
            ' UPC / EAN (C)
            If txtCdeCtn.Enabled = True And txtCdeCtn.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_Code3).ReadOnly = False
                dgSummary.Columns(dgSummary_Code3).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_Code3).ReadOnly = True
            End If
            ' Customer Retail 1 Amount
            If txtRetailUSD.Enabled = True And txtRetailUSD.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_CusUSD).ReadOnly = False
                dgSummary.Columns(dgSummary_CusUSD).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_CusUSD).ReadOnly = True
            End If
            ' Customer Retail 2 Amount
            If txtRetailCAD.Enabled = True And txtRetailCAD.ReadOnly = False Then
                'dgSummary.Columns(dgSummary_CusCAD).ReadOnly = False
                dgSummary.Columns(dgSummary_CusCAD).ReadOnly = True
            Else
                dgSummary.Columns(dgSummary_CusCAD).ReadOnly = True
            End If
        End If
    End Sub

    Private Sub dgSummary_ColumnHeaderMouseClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs) Handles dgSummary.ColumnHeaderMouseClick
        If e.RowIndex < 0 Then
            Dim dv As DataView = rs_SCORDDTL.Tables("RESULT").DefaultView
            dv.Sort = sender.SortedColumn.Name & " " & IIf(sender.SortOrder.ToString = "Ascending", "ASC", "DESC")
            rs_SCORDDTL.Tables.Remove("RESULT")
            rs_SCORDDTL.Tables.Add(dv.ToTable)

            currentRow = 0
            currentOrdSeq = dgSummary.Rows(0).Cells("sod_ordseq").Value
            recordMove("TAB")
        End If
    End Sub

    Private Sub grdDisPre_CellEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdDis.CellEnter
        If sender.Name.ToString = "grdDis" Then
            If e.ColumnIndex = 8 Or e.ColumnIndex = 9 Then
                If grdDis.Rows(e.RowIndex).Cells(7).Value = "Percentage" Then
                    grdDis.Columns(8).ReadOnly = False
                    grdDis.Columns(9).ReadOnly = True
                Else
                    grdDis.Columns(8).ReadOnly = True
                    grdDis.Columns(9).ReadOnly = False
                End If
            End If
        End If
    End Sub

    Private Function checkUpdateDetail(ByVal ordseq As Integer, ByVal drSCORDDTL As DataRow) As Boolean
        Dim drSCORDDTL_ori() As DataRow = rs_SCORDDTL_ori.Tables("RESULT").Select("sod_ordseq = '" & ordseq & "'")
        If drSCORDDTL_ori.Length > 0 Then
            For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Columns.Count - 1
                'If i = 5 Then
                '    If Split(drSCORDDTL.Item(i), " - ")(0) <> Split(drSCORDDTL_ori(0).Item(i), " - ")(0) Then
                '        Return True
                '    End If
                'If i = 5 Or i = 74 Then
                If i = 156 Then
                    Continue For
                Else
                    Select Case drSCORDDTL.Item(i).GetType.ToString
                        Case "System.Decimal"
                            If drSCORDDTL.Item(i) <> drSCORDDTL_ori(0).Item(i) Then
                                Return True
                            End If
                        Case "System.Int32"
                            If drSCORDDTL.Item(i) <> drSCORDDTL_ori(0).Item(i) Then
                                Return True
                            End If
                        Case "System.String"
                            If Trim(drSCORDDTL.Item(i).ToString) <> Trim(drSCORDDTL_ori(0).Item(i).ToString) Then
                                Return True
                            End If
                        Case "System.DateTime"
                            If Format(drSCORDDTL.Item(i), "MM/dd/yyyy") <> Format(drSCORDDTL_ori(0).Item(i), "MM/dd/yyyy") Then
                                Return True
                            End If
                        Case Else
                            If drSCORDDTL.Item(i).GetType.ToString <> drSCORDDTL_ori(0).Item(i).GetType.ToString And drSCORDDTL.Item(i).GetType.ToString = "System.DBNull" Then
                                Return True
                            End If
                    End Select
                    'If drSCORDDTL.Item(i).ToString <> drSCORDDTL_ori(0).Item(i).ToString Then
                    '    Return True
                    'End If
                End If
            Next
            Return False
        Else
            Return False
        End If
    End Function

    Private Sub checkDate_Validating(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtStartShipDat.Validating, txtEndShipDat.Validating, txtCancelDat.Validating, txtCustPoDat.Validating, txtPOHdrCanDat.Validating, txtPanCopyCustStartShipDat.Validating, txtPanCopyCustEndShipDat.Validating, txtPanCopyCustCancelDat.Validating, txtPOHdrCanDatTo.Validating
        If cmdExit.Focused = True Or cmdPanCopy_CustCancel.Focused = True Then
            Exit Sub
        End If

        Select Case sender.Name.ToString
            Case "txtStartShipDat"
                If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                    MsgBox("Ship Start Date is invalid (MM/DD/YYYY)")
                    e.Cancel = True
                    Exit Sub
                End If

                If CDate(txtStartShipDat.Text) < Date.Today Then
                    If MsgBox("Ship Start Date has already past. Confirm to use the elapsed date", MsgBoxStyle.YesNo, "Confirmation") = MsgBoxResult.No Then
                        e.Cancel = True
                        Exit Sub
                    End If
                End If
            Case "txtEndShipDat"
                If txtStartShipDat.Text = "  /  /" Then
                    MsgBox("Ship Start Date must be entered first")
                    txtEndShipDat.Text = "  /  /"
                    txtStartShipDat.Focus()
                    txtStartShipDat.SelectAll()
                    Exit Sub
                End If

                If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                    MsgBox("Ship End Date is invalid (MM/DD/YYYY)")
                    e.Cancel = True
                    Exit Sub
                End If

                If CDate(txtEndShipDat.Text) < Date.Today Then
                    If MsgBox("Ship End Date has already past. Confirm to use the elapsed date", MsgBoxStyle.YesNo, "Confirmation") = MsgBoxResult.No Then
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                If CDate(txtEndShipDat.Text) < CDate(txtStartShipDat.Text) Then
                    MsgBox("Ship End Date < Ship Start Date")
                    e.Cancel = True
                    Exit Sub
                End If
            Case "txtCancelDat"
                If txtCancelDat.Text <> "  /  /" Then
                    If txtStartShipDat.Text = "  /  /" Then
                        MsgBox("Ship Start Date must be entered first")
                        txtCancelDat.Text = "  /  /"
                        txtStartShipDat.Focus()
                        txtStartShipDat.SelectAll()
                        Exit Sub
                    End If

                    If sender.Text.Length <> 10 Or IsDate(txtCancelDat.Text) = False Then
                        MsgBox("Cancel Date is invalid (MM/DD/YYYY)")
                        e.Cancel = True
                        If tabFrame.SelectedIndex <> 0 Then
                            tabFrame.SelectTab(0)
                        End If
                        Exit Sub
                    Else
                        If txtEndShipDat.Text = "  /  /" Then
                            MsgBox("Ship End Date must not be empty")
                            e.Cancel = True
                            Exit Sub
                        End If

                        If CDate(txtCancelDat.Text) < CDate(txtEndShipDat.Text) Then
                            MsgBox("Cancel Date < Ship End Date")
                            e.Cancel = True
                            Exit Sub
                        End If
                    End If
                End If
            Case "txtCustPoDat"
                If txtCustPoDat.Text <> "  /  /" Then
                    If sender.Text.Length <> 10 Or IsDate(txtCustPoDat.Text) = False Then
                        MsgBox("Customer PO Date is invalid")
                        e.Cancel = True
                        sender.Text = hdr_CustPODat
                        If tabFrame.SelectedIndex <> 0 Then
                            tabFrame.SelectTab(0)
                        End If
                        Exit Sub
                    ElseIf (CDate(txtCustPoDat.Text) < DateAdd(DateInterval.Day, -365, Date.Today)) Or (CDate(txtCustPoDat.Text) > DateAdd(DateInterval.Day, 365, Date.Today)) Then
                        e.Cancel = True
                        MsgBox("Customer PO Date out of allowed range (+/- 365 days)")
                        If tabFrame.SelectedIndex <> 0 Then
                            tabFrame.SelectTab(0)
                        End If
                        Exit Sub
                    ElseIf sender.Text <> hdr_CustPODat And hdr_CustPODat <> "" Then
                        Dim answer As Integer = MsgBox("All Detail Record will be Delete", MsgBoxStyle.YesNo)
                        If answer = MsgBoxResult.Yes Then
                            hdr_CustPODat = sender.Text
                            If txtSCVerNo.Text = "1" And (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And txtSCNo.Text <> "" Then
                                ' delete detail
                                For i As Integer = 0 To rs_SCORDDTL.Tables("RESULT").Rows.Count - 1
                                    If rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*ADD*~" And rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") <> "~*NEW*~" Then
                                        rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*DEL*~"
                                    ElseIf rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*ADD*~" Then
                                        rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_creusr") = "~*NEW*~"
                                    End If
                                Next
                                Cal_TotalAmt()
                            ElseIf txtSCVerNo.Text = "1" And txtSCNo.Text = "" Then
                                clearDetail()
                                setDtlStatus("INIT")
                                Display_Dtl("INIT")
                                txtItmno.Text = ""
                                Cal_TotalAmt()
                            End If
                        Else
                            e.Cancel = True
                            txtCustPoDat.Text = hdr_CustPODat
                            sender.SelectAll()
                        End If
                    ElseIf sender.Text = hdr_CustPODat Then
                        Exit Sub
                    Else
                        hdr_CustPODat = sender.Text
                    End If
                Else
                    e.Cancel = True
                    MsgBox("Customer PO Date Cannot be Empty")
                    sender.Text = hdr_CustPODat
                    txtCustPoDat.SelectAll()
                    Exit Sub
                End If
            Case "txtPOHdrCanDat"
                If txtPOHdrCanDat.Text <> "  /  /" Then
                    If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                        MsgBox("PO Cancel Date is invalid")
                        e.Cancel = True
                        Exit Sub
                    Else
                        'If CDate(txtPOHdrCanDat.Text) < CDate(txtPOHdrEndShip.Text) Then
                        '    MsgBox("PO Cancel Date < PO Ship End Date")
                        '    e.Cancel = True
                        '    Exit Sub
                        'End If
                    End If
                Else
                    MsgBox("PO Cancel Date cannot be empty")
                    e.Cancel = True
                    Exit Sub
                End If
            Case "txtPOHdrCanDatTo"
                If txtPOHdrCanDatTo.Text <> "  /  /" Then
                    If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                        MsgBox("PO Cancel Date is invalid")
                        e.Cancel = True
                    End If
                End If
            Case "txtPanCopyCustStartShipDat"
                If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                    MsgBox("Ship Start Date is invalid (MM/DD/YYYY)")
                    e.Cancel = True
                    Exit Sub
                End If

                If CDate(sender.Text) < Date.Today Then
                    If MsgBox("Ship Start Date has already past. Confirm to use the elapsed date", MsgBoxStyle.YesNo, "Confirmation") = MsgBoxResult.No Then
                        e.Cancel = True
                        Exit Sub
                    End If
                End If
            Case "txtPanCopyCustEndShipDat"
                If txtPanCopyCustStartShipDat.Text = "  /  /" Then
                    MsgBox("Ship Start Date must be entered first")
                    sender.Text = "  /  /"
                    txtPanCopyCustStartShipDat.Focus()
                    txtPanCopyCustStartShipDat.SelectAll()
                    Exit Sub
                End If

                If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                    MsgBox("Ship End Date is invalid (MM/DD/YYYY)")
                    e.Cancel = True
                    Exit Sub
                End If

                If CDate(sender.Text) < Date.Today Then
                    If MsgBox("Ship End Date has already past. Confirm to use the elapsed date", MsgBoxStyle.YesNo, "Confirmation") = MsgBoxResult.No Then
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                If CDate(sender.Text) < CDate(txtPanCopyCustStartShipDat.Text) Then
                    MsgBox("Ship End Date < Ship Start Date")
                    e.Cancel = True
                    Exit Sub
                End If
            Case "txtPanCopyCustCancelDat"
                If sender.Text <> "  /  /" Then
                    If txtPanCopyCustStartShipDat.Text = "  /  /" Then
                        MsgBox("Ship Start Date must be entered first")
                        sender.Text = "  /  /"
                        txtPanCopyCustStartShipDat.Focus()
                        txtPanCopyCustStartShipDat.SelectAll()
                        Exit Sub
                    End If

                    If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                        MsgBox("Cancel Date is invalid (MM/DD/YYYY)")
                        e.Cancel = True
                        Exit Sub
                    Else
                        If txtPanCopyCustEndShipDat.Text = "  /  /" Then
                            MsgBox("Ship End Date must not be empty")
                            e.Cancel = True
                            Exit Sub
                        End If

                        If CDate(sender.Text) < CDate(txtPanCopyCustEndShipDat.Text) Then
                            MsgBox("Cancel Date < Ship End Date")
                            e.Cancel = True
                            Exit Sub
                        End If
                    End If
                End If
        End Select
    End Sub

    Private Sub txtRemark_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRemark.GotFocus
        'sender.BringtoFront()
        'sender.Height = sender.Height + 60
        ''sender.Location = New Point(sender.Location.X, sender.Location.Y - 70)
    End Sub

    Private Sub txtRemark_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRemark.LostFocus
        'sender.Height = sender.Height - 60
        ''sender.Location = New Point(sender.Location.X, sender.Location.Y + 70)
    End Sub

    Private Sub txtEngDsc_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEngDsc.GotFocus, txtChiDsc.GotFocus, txtEngRmk.GotFocus
        sender.BringtoFront()
        sender.Height = sender.Height + 60
    End Sub

    Private Sub txtEngDsc_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEngDsc.LostFocus, txtChiDsc.LostFocus, txtEngRmk.LostFocus
        sender.Height = sender.Height - 60
    End Sub

    Private Sub txtChiRmk_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtChiRmk.GotFocus
        sender.BringtoFront()
        sender.Height = sender.Height + 60
        sender.Location = New Point(sender.Location.X, sender.Location.Y - 60)
    End Sub

    Private Sub txtChiRmk_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtChiRmk.LostFocus
        sender.Height = sender.Height - 60
        sender.Location = New Point(sender.Location.X, sender.Location.Y + 60)
    End Sub

    Private Sub check_date_dtl(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtCanDat.Validating, txtPOCanDat.Validating
        If cmdClear.Focused = True Or cmdExit.Focused = True Then
            Exit Sub
        End If

        Select Case sender.Name.ToString
            Case "txtCanDat"
                If sender.Text.Length <> 10 And sender.Text <> "  /  /" Then
                    e.Cancel = True
                    MsgBox("Invalid Date Format (MM/DD/YYYY)", , "SCM00001 - Header Cancel Date")
                    'ElseIf IsDate(sender.Text) = False And sender.Text <> "  /  /" Then
                ElseIf (IsDate(sender.Text) = False And sender.Text <> "  /  /") Or sender.Text = "01/01/1900" Then
                    e.Cancel = True
                    MsgBox("SC Cancel Date is Invalid")
                End If
            Case "txtPOCanDat"
                If sender.Text.Length <> 10 And sender.Text <> "  /  /" Then
                    e.Cancel = True
                    MsgBox("Invalid Date Format (MM/DD/YYYY)", , "SCM00001 - PO Cancel Date")
                    sender.SelectAll()
                ElseIf IsDate(sender.Text) = False And sender.Text <> "  /  /" Then
                    e.Cancel = True
                    MsgBox("PO Cancel Date is Invalid")
                End If
        End Select
    End Sub

    Private Sub Reset_PO()
        cboPONo.Items.Clear()

        txtPOVenno.Text = ""
        cboPOStatus.Text = ""

        cboPOContactPerson.Items.Clear()
        cboPOPrcTrm.Items.Clear()
        cboPOPayTrm.Items.Clear()
        txtPODiscount.Text = ""
        txtPOHdrRmk.Text = ""
        txtPOHdrStartShip.Text = ""
        txtPOHdrEndShip.Text = ""
        txtPOHdrCanDat.Text = ""
        txtPOHdrCanDatTo.Text = ""
        txtPOHdrStartShip.Enabled = False
        txtPOHdrEndShip.Enabled = False
        txtPOHdrCanDat.Enabled = False
        txtPOHdrCanDatTo.Enabled = False

        optPOMain.Checked = False
        optPOInner.Checked = False
        optPOSide.Checked = False
        txtPOShpmrk.Text = ""

        txtPOShpmrkChnDsc.Text = ""
        txtPOShpmrkChnRmk.Text = ""
        txtPOShpmrkEngDsc.Text = ""
        txtPOShpmrkEngRmk.Text = ""

        txtPOSeq.Text = ""
        txtPOSCSeq.Text = ""
        txtPOJobNo.Text = ""
        txtPOStartShip1.Text = ""
        txtPOEndShip1.Text = ""
        txtPODtlRmk.Text = ""
        txtPODtlChnRmk.Text = ""
    End Sub

    Private Sub display_UpdatePO()

        Dim drAccess() As DataRow = rs_SYUSRGRP_right.Tables("RESULT").Select("yug_usrfun = 'POM00001' and yug_usrgrp = '" & gsUsrGrp & "'")
        Dim readOnlyPO As Boolean = True

        If drAccess.Length = 0 Then
            gspStr = "sp_select_POORDHDR_SC 'XXX','XXX'"
        Else
            If drAccess(0)("yug_assrig").ToString.Substring(0, 3) = "ENQ" Then
                readOnlyPO = True
            Else
                readOnlyPO = False
            End If
            gspStr = "sp_select_POORDHDR_SC '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        End If

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_POORDHDR, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Me.Cursor = Windows.Forms.Cursors.Default
            MsgBox("Error on loading SCM00001 #107 sp_select_POORDHDR_SC : " & rtnStr)
            Exit Sub
        End If

        For i As Integer = 0 To rs_POORDHDR.Tables("RESULT").Columns.Count - 1
            rs_POORDHDR.Tables("RESULT").Columns(i).ReadOnly = False
        Next

        rs_POORDHDR_ori = rs_POORDHDR.Copy()

        If rs_POORDHDR.Tables("RESULT").Rows.Count = 0 Then
            Me.Cursor = Windows.Forms.Cursors.Default
            grpUpdatePO.Enabled = False
            Exit Sub
        Else
            grpUpdatePO.Enabled = True
            Dim drPOORDHDR_OPE() As DataRow = rs_POORDHDR.Tables("RESULT").Select("poh_pursts = 'OPE'")
            If drPOORDHDR_OPE.Length = 0 Or readOnlyPO = True Then
                cmdSavePO.Enabled = False
            Else
                cmdSavePO.Enabled = True
            End If

            drAccess = Nothing
            drAccess = rs_SYUSRGRP_right.Tables("RESULT").Select("yug_usrfun = 'SHR00003' and yug_usrgrp = '" & gsUsrGrp & "'")
            If drAccess.Length = 0 Then
                cmdReleasePO.Enabled = False
            Else
                cmdReleasePO.Enabled = True
            End If
        End If

        gspStr = "sp_select_POSHPMRK_SC '" & cboCoCde.Text & "','" & txtSCNo.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_POSHPMRK, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #108 sp_select_POSHPMRK_SC : " & rtnStr)
            Exit Sub
        End If

        For i As Integer = 0 To rs_POSHPMRK.Tables("RESULT").Columns.Count - 1
            rs_POSHPMRK.Tables("RESULT").Columns(i).ReadOnly = False
        Next

        rs_POSHPMRK_ori = rs_POSHPMRK.Copy()

        If rs_POSHPMRK.Tables("RESULT").Rows.Count = 0 Then
            grpUpdPO_Shpmrk.Enabled = False
        Else
            grpUpdPO_Shpmrk.Enabled = True
        End If

        fillUpdPO_Header()
        fillUpdPO_POStatus()
        fillPOcboPrcTrm()
        fillPOcboPayTrm()

        cboPONo.SelectedIndex = 0
    End Sub

    Private Sub fillUpdPO_Header()
        cboPONo.Items.Clear()
        For i As Integer = 0 To rs_POORDHDR.Tables("RESULT").Rows.Count - 1
            If cboPONo.Items.Contains(rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord")) = False Then
                cboPONo.Items.Add(rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord"))
            End If
        Next
    End Sub

    Private Sub fillUpdPO_ContactPerson()
        cboPOContactPerson.Items.Clear()
        cboPOContactPerson.Items.Add("")
        gspStr = "sp_list_CVNCNTINF '" & cboCoCde.Text & "','" & Split(txtPOVenno.Text, " - ")(0) & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_CVNCNTINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading POM00001 FillContactPerson rs_CVNCNTINF : " & rtnStr)
            Exit Sub
        End If

        If rs_CVNCNTINF.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_CVNCNTINF.Tables("RESULT").Rows.Count - 1
                cboPOContactPerson.Items.Add(rs_CVNCNTINF.Tables("RESULT").Rows(i).Item("vci_cntctp"))
            Next
        End If
    End Sub

    Private Sub fillUpdPO_POStatus()
        cboPOStatus.Items.Clear()
        cboPOStatus.Items.Add("OPE - OPEN")
        cboPOStatus.Items.Add("REL - Released")
        cboPOStatus.Items.Add("CLO - Closed")
        cboPOStatus.Items.Add("CAN - Cancelled")
    End Sub

    Private Sub fillPOcboPrcTrm()
        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ ='03'")
        If dr.Length > 0 Then
            cboPOPrcTrm.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPOPrcTrm.Items.Add(dr(i).Item("ysi_cde"))
            Next
            cboPOPrcTrm.Sorted = True
        End If
    End Sub

    Private Sub fillPOcboPayTrm()
        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ ='04'")
        If dr.Length > 0 Then
            cboPOPayTrm.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPOPayTrm.Items.Add(dr(i).Item("ysi_cde") & " - " & dr(i).Item("ysi_dsc"))
            Next
            cboPOPayTrm.Sorted = True
        End If
    End Sub

    Private Sub cboPONo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPONo.SelectedIndexChanged
        optPOMain.Checked = False
        optPOInner.Checked = False
        optPOSide.Checked = False

        If cboPONo.Text = "" Then
            grpUpdPO_Header.Enabled = False
            grpUpdPO_Shpmrk.Enabled = False
            Exit Sub
        Else
            grpUpdPO_Header.Enabled = True
            grpUpdPO_Shpmrk.Enabled = True
        End If

        Dim dr_POORDHDR() As DataRow = rs_POORDHDR.Tables("RESULT").Select("poh_purord = '" & cboPONo.Text & "'")
        If dr_POORDHDR.Length > 0 Then
            txtPOVenno.Text = dr_POORDHDR(0).Item("poh_venno") & " - " & dr_POORDHDR(0).Item("vbi_vensna")
            display_combo(dr_POORDHDR(0).Item("poh_pursts"), cboPOStatus)

            fillUpdPO_ContactPerson()
            display_combo(dr_POORDHDR(0).Item("poh_porctp"), cboPOContactPerson)

            If cboPOContactPerson.Text <> dr_POORDHDR(0).Item("poh_porctp").ToString Then
                '                MsgBox("PO Contact Person not found in Customer Master")
                cboPOContactPerson.Items.Add(dr_POORDHDR(0).Item("poh_porctp"))
                display_combo(dr_POORDHDR(0).Item("poh_porctp"), cboPOContactPerson)
            End If

            display_combo(dr_POORDHDR(0).Item("poh_prctrm"), cboPOPrcTrm)
            display_combo(dr_POORDHDR(0).Item("poh_paytrm"), cboPOPayTrm)

            txtPOHdrRmk.Text = dr_POORDHDR(0).Item("poh_rmk")
            txtPODiscount.Text = dr_POORDHDR(0).Item("poh_discnt")
            txtPOHdrStartShip.Text = Format(dr_POORDHDR(0).Item("poh_shpstr"), "MM/dd/yyyy")
            txtPOHdrEndShip.Text = Format(dr_POORDHDR(0).Item("poh_shpend"), "MM/dd/yyyy")
            'txtPOHdrCanDat.Text = Format(dr_POORDHDR(0).Item("poh_pocdat"), "MM/dd/yyyy")
            If dr_POORDHDR(0).Item("poh_pocdat") = "  /  /" Or dr_POORDHDR(0).Item("poh_pocdat") = "01/01/1900" Then
                txtPOHdrCanDat.Text = "  /  /"
            Else
                txtPOHdrCanDat.Text = Format(CDate(dr_POORDHDR(0).Item("poh_pocdat")), "MM/dd/yyyy")
            End If
            If dr_POORDHDR(0).Item("poh_pocdatend") = "  /  /" Or dr_POORDHDR(0).Item("poh_pocdatend") = "01/01/1900" Then
                txtPOHdrCanDatTo.Text = "  /  /"
            Else
                txtPOHdrCanDatTo.Text = Format(CDate(dr_POORDHDR(0).Item("poh_pocdatend")), "MM/dd/yyyy")
            End If

            optPOMain.Checked = True

            If Split(cboPOStatus.Text, " - ")(0) = "OPE" Then
                cboPOContactPerson.Enabled = True
                cboPOPrcTrm.Enabled = True
                cboPOPayTrm.Enabled = True
                txtPOHdrRmk.ReadOnly = False
                txtPODiscount.ReadOnly = False
                txtPOShpmrkEngDsc.ReadOnly = False
                txtPOShpmrkChnDsc.ReadOnly = False
                txtPOShpmrkEngRmk.ReadOnly = False
                txtPOShpmrkChnRmk.ReadOnly = False
                cmdHdrPORmk.Enabled = True
                'txtPOHdrCanDat.Enabled = False
                'txtPOHdrCanDatTo.Enabled = False
                txtPOHdrCanDat.Enabled = True
                txtPOHdrCanDatTo.Enabled = True
            Else
                cboPOContactPerson.Enabled = False
                cboPOPrcTrm.Enabled = False
                cboPOPayTrm.Enabled = False
                txtPOHdrRmk.ReadOnly = True
                txtPODiscount.ReadOnly = True
                txtPOShpmrkEngDsc.ReadOnly = True
                txtPOShpmrkChnDsc.ReadOnly = True
                txtPOShpmrkEngRmk.ReadOnly = True
                txtPOShpmrkChnRmk.ReadOnly = True
                cmdHdrPORmk.Enabled = False
                txtPOHdrCanDat.Enabled = False
                txtPOHdrCanDatTo.Enabled = False
            End If
        End If
    End Sub

    Private Sub display_POShpmrk(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optPOMain.CheckedChanged, optPOInner.CheckedChanged, optPOSide.CheckedChanged
        If sender.Checked = False Then
            Exit Sub
        End If

        Dim dr_POSHPMRK() As DataRow

        If optPOMain.Checked = True Then
            dr_POSHPMRK = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and " & "psm_shptyp = 'M'")
        ElseIf optPOInner.Checked = True Then
            dr_POSHPMRK = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and " & "psm_shptyp = 'I'")
        ElseIf optPOSide.Checked = True Then
            dr_POSHPMRK = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and " & "psm_shptyp = 'S'")
        End If

        If dr_POSHPMRK.Length > 0 Then
            txtPOShpmrk.Text = dr_POSHPMRK(0).Item("psm_imgnam")
            txtPOShpmrkEngDsc.Text = dr_POSHPMRK(0).Item("psm_engdsc")
            txtPOShpmrkChnDsc.Text = dr_POSHPMRK(0).Item("psm_chndsc")
            txtPOShpmrkEngRmk.Text = dr_POSHPMRK(0).Item("psm_engrmk")
            txtPOShpmrkChnRmk.Text = dr_POSHPMRK(0).Item("psm_chnrmk")
        Else
            txtPOShpmrk.Text = ""
            txtPOShpmrkEngDsc.Text = ""
            txtPOShpmrkChnDsc.Text = ""
            txtPOShpmrkEngRmk.Text = ""
            txtPOShpmrkChnRmk.Text = ""
        End If

    End Sub

    Private Sub validate_numeric(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtPODiscount.Validating
        If IsNumeric(sender.Text) = False And sender.Text <> "" Then
            e.Cancel = True
            MsgBox("PO Discount can only contain numeric values")
        Else
            If sender.Text = "" Then
                sender.Text = "0.0000"
            Else
                sender.Text = roundup(CDbl(sender.Text))
            End If
        End If
    End Sub

    Private Sub txtPOShpmrk_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOShpmrkEngDsc.GotFocus, txtPOShpmrkEngDsc.GotFocus, txtPOShpmrkEngRmk.GotFocus
        sender.BringToFront()
        sender.Height = sender.Height + 45
        sender.SelectionStart = 0
        sender.SelectionLength = 0
    End Sub

    Private Sub txtPOShpmrk_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOShpmrkEngDsc.LostFocus, txtPOShpmrkEngDsc.LostFocus, txtPOShpmrkEngRmk.LostFocus
        sender.Height = sender.Height - 45
    End Sub

    Private Sub txtPOShpmrkBottom_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOShpmrkChnRmk.GotFocus
        sender.BringToFront()
        sender.Height = sender.Height + 45
        sender.Location = New Point(sender.Location.X, sender.Location.Y - 45)
        sender.SelectionStart = 0
        sender.SelectionLength = 0
    End Sub

    Private Sub txtPOShpmrkBottom_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOShpmrkChnRmk.LostFocus
        sender.Height = sender.Height - 45
        sender.Location = New Point(sender.Location.X, sender.Location.Y + 45)
    End Sub

    Private Sub apply_POChanges(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPOPrcTrm.Validated, cboPOContactPerson.Validated, cboPOPayTrm.Validated, txtPOShpmrkEngRmk.Validated, txtPOShpmrkEngDsc.Validated, txtPOShpmrkChnRmk.Validated, txtPOShpmrkChnDsc.Validated, txtPOHdrRmk.Validated, txtPODiscount.Validated, txtPOHdrCanDat.Validated, txtPOHdrCanDatTo.Validated
        Dim dr_POHeader() As DataRow = rs_POORDHDR.Tables("RESULT").Select("poh_purord = '" & cboPONo.Text & "'")
        If dr_POHeader.Length > 0 Then
            dr_POHeader(0).Item("poh_porctp") = cboPOContactPerson.Text
            dr_POHeader(0).Item("poh_prctrm") = cboPOPrcTrm.Text
            dr_POHeader(0).Item("poh_paytrm") = cboPOPayTrm.Text
            dr_POHeader(0).Item("poh_rmk") = txtPOHdrRmk.Text
            dr_POHeader(0).Item("poh_discnt") = txtPODiscount.Text
            If txtPOHdrCanDat.Text = "  /  /" Then
                dr_POHeader(0).Item("poh_pocdat") = "01/01/1900"
            Else
                dr_POHeader(0).Item("poh_pocdat") = txtPOHdrCanDat.Text
            End If
            If txtPOHdrCanDatTo.Text = "  /  /" Then
                dr_POHeader(0).Item("poh_pocdatend") = "01/01/1900"
            Else
                dr_POHeader(0).Item("poh_pocdatend") = txtPOHdrCanDatTo.Text
            End If
        End If

        Dim dr_POShpmrk() As DataRow
        If optPOMain.Checked = True Then
            dr_POShpmrk = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and psm_shptyp = 'M'")
        ElseIf optPOInner.Checked = True Then
            dr_POShpmrk = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and psm_shptyp = 'I'")
        ElseIf optPOSide.Checked = True Then
            dr_POShpmrk = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & cboPONo.Text & "' and psm_shptyp = 'S'")
        End If
        If dr_POShpmrk.Length > 0 Then
            dr_POShpmrk(0).Item("psm_imgnam") = txtPOShpmrk.Text
            dr_POShpmrk(0).Item("psm_engdsc") = txtPOShpmrkEngDsc.Text
            dr_POShpmrk(0).Item("psm_chndsc") = txtPOShpmrkChnDsc.Text
            dr_POShpmrk(0).Item("psm_engrmk") = txtPOShpmrkEngRmk.Text
            dr_POShpmrk(0).Item("psm_chnrmk") = txtPOShpmrkChnRmk.Text
        End If
    End Sub

    Private Sub cmdShpmrkAttchmnt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdShpmrkAttchmnt.Click
        If ShipmrkAttchmnt Is Nothing Then
            ShipmrkAttchmnt = New SCM00001_ShpmrkAtchmt
        End If

        ShipmrkAttchmnt.setCompanyCode(cboCoCde.Text, txtCoNam.Text)
        ShipmrkAttchmnt.setSCNo(txtSCNo.Text)

        ShipmrkAttchmnt.ShowDialog()
    End Sub

    Private Sub cmdReleasePO_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdReleasePO.Click
        PO_Release = New SHR00003
        PO_Release.init_fromFactory = cboPONo.Text
        PO_Release.init_toFactory = cboPONo.Text
        PO_Release.ShowDialog()
    End Sub

    Private Sub cmdCalPODat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPOCalDat.Click
        Dim rs_POSHPDAT As DataSet
        gspStr = "sp_select_POSHPDAT_SC '" & cboCoCde.Text & "','" & Split(cboCusVen.Text, " - ")(0) & "','" & _
                 txtStartShip.Text & "','" & txtEndShip.Text & "','" & txtCanDat.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_POSHPDAT, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #109 sp_select_POSHPDAT : " & rtnStr)
            Exit Sub
        End If

        If rs_POSHPDAT.Tables("RESULT").Rows.Count > 0 Then
            If rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posstr") <= CDate("01/01/1900") Then
                txtPOStartShip.Text = "  /  /"
            Else
                txtPOStartShip.Text = Format(rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posstr"), "MM/dd/yyyy")
            End If

            If rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posend") <= CDate("01/01/1900") Then
                txtPOEndShip.Text = "  /  /"
            Else
                txtPOEndShip.Text = Format(rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posend"), "MM/dd/yyyy")
            End If

            If rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_poscan") <= CDate("01/01/1900") Then
                txtPOCanDat.Text = "  /  /"
            Else
                txtPOCanDat.Text = Format(rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_poscan"), "MM/dd/yyyy")
            End If

            recordStatus_dtl = True
        End If
    End Sub


    'Private Sub focus_Highlight(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOStartShip.Enter, txtStartShip.Enter, txtPOEndShip.Enter, txtPOCanDat.Enter, txtEndShip.Enter, txtCanDat.Enter
    '    sender.SelectionStart = 0
    '    sender.Refresh()
    '    sender.SelectAll()
    'End Sub

    Private Sub cmdMatBrkDwn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdMatBrkdwn.Click
        freeze_TabControl(tabFrame_Detail)
        grpDetail.Enabled = False
        panMatBrkdwn.Width = 439
        panMatBrkdwn.Height = 168
        panMatBrkdwn.Location = New Point(11, 260)
        panMatBrkdwn.BringToFront()
        loadPanMatBrkDwn()
        panMatBrkdwn.Visible = True
    End Sub

    Private Sub cmdPanMatBrkdwnInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanMatBrkdwnInsRow.Click
        Dim newRow As DataRow = rs_SCCPTBKD_tmp.Tables("RESULT").NewRow
        newRow.Item("scb_status") = ""
        newRow.Item("scb_ordno") = txtSCNo.Text
        newRow.Item("scb_ordseq") = currentOrdSeq
        If dgMatBrkdwn.Rows.Count = 0 Then
            newRow.Item("scb_cptseq") = 1
        Else
            Dim dr() As DataRow = rs_SCCPTBKD_tmp.Tables("RESULT").Select("scb_ordseq = '" & currentOrdSeq & "'", "scb_cptseq")
            If dr.Length > 0 Then
                newRow.Item("scb_cptseq") = dr(dr.Length - 1).Item("scb_cptseq") + 1
            End If
        End If

        newRow.Item("scb_itmno") = Trim(UCase(txtItmno.Text))
        newRow.Item("scb_cpt") = ""
        newRow.Item("scb_curcde") = Trim(UCase(lblBasprcCur.Text))
        newRow.Item("scb_cst") = 0
        newRow.Item("scb_cstpct") = 0
        newRow.Item("scb_pct") = 0
        newRow.Item("scb_creusr") = "~*ADD*~"
        rs_SCCPTBKD_tmp.Tables("RESULT").Rows.Add(newRow)
    End Sub

    Private Sub cmdPanMatBrkdwnOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanMatBrkdwnOK.Click
        Dim dr() As DataRow = rs_SCCPTBKD_tmp.Tables("RESULT").Select("scb_ordseq = '" & currentOrdSeq & "' and scb_cpt = '' and scb_status <> 'Y'")
        If dr.Length > 0 Then
            MsgBox("Material Name cannot be empty")
            Exit Sub
        End If

        dr = Nothing
        dr = rs_SCCPTBKD_tmp.Tables("RESULT").Select("scb_ordseq = '" & currentOrdSeq & "' and scb_status <> 'Y'")
        If dr.Length > 0 Then
            Dim cstPct As Double = 0
            Dim wgtPct As Double = 0
            Dim cst As Double = 0
            For i As Integer = 0 To dr.Length - 1
                cst += dr(i)("scb_cst")
                cstPct += dr(i)("scb_cstpct")
                wgtPct += dr(i)("scb_pct")
            Next

            If cstPct <> 100 And cstPct <> 0 Then
                MsgBox("Cost Percentage not equal to 100%", MsgBoxStyle.Information, "SCM00001 - Material Breakdown")
                Exit Sub
            ElseIf wgtPct <> 100 And wgtPct <> 0 Then
                MsgBox("Weight Percentage not equal to 100%", MsgBoxStyle.Information, "SCM00001 - Material Breakdown")
                Exit Sub
            ElseIf cstPct = 0 And wgtPct = 0 Then
                MsgBox("Cost Percentage and Weight Percentage cannot both be zero", MsgBoxStyle.Information, "SCM00001 - Material Breakdown")
                Exit Sub
            End If

            If roundup(cst) > CDbl(txtUntPrc.Text) Then
                If MsgBox("Total Cost is greater than Selling Price." & Environment.NewLine & "Confirm to save?", MsgBoxStyle.Information + MsgBoxStyle.YesNo, "SCM00001 - Material Breakdown") = MsgBoxResult.No Then
                    Exit Sub
                End If
            End If
        End If

        rs_SCCPTBKD_tmp.Tables("RESULT").DefaultView.RowFilter = ""
        rs_SCCPTBKD = rs_SCCPTBKD_tmp.Copy()
        cmdPanMatBrkdwnCancel.PerformClick()
    End Sub

    Private Sub cmdPanMatBrkdwnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanMatBrkdwnCancel.Click
        release_TabControl()
        grpDetail.Enabled = True
        panMatBrkdwn.Visible = False
    End Sub

    Private Sub loadPanMatBrkDwn()
        rs_SCCPTBKD_tmp = rs_SCCPTBKD.Copy()
        rs_SCCPTBKD_tmp.Tables("RESULT").DefaultView.RowFilter = "scb_ordseq = '" & currentOrdSeq & "'"
        dgMatBrkdwn.Enabled = True
        If Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD" Then
            cmdPanMatBrkdwnInsRow.Enabled = True
            cmdPanMatBrkdwnOK.Enabled = True
            display_Component(False)
        Else
            cmdPanMatBrkdwnInsRow.Enabled = False
            cmdPanMatBrkdwnOK.Enabled = False
            display_Component(True)
        End If
        cmdPanMatBrkdwnCancel.Enabled = True
    End Sub

    Private Sub freeze_TabControl(ByVal tabpageno As Integer)
        dispPOFlag = tabFrame.TabPages(tabFrame_UpdatePO).Enabled
        dispSaveFlag = cmdSave.Enabled
        dispCopyFlag = cmdCopy.Enabled
        dispInsFlag = cmdInsRow.Enabled
        dispDelFlag = cmdDelRow.Enabled
        dispPriCusFlag = cboPriCust.Enabled
        dispSecCusFlag = cboSecCust.Enabled
        dispApplyPOFlag = chkhdrpo.Enabled
        dispClsOutFlag = chkCloseOut.Enabled
        dispRplmntFlag = chkReplacement.Enabled
        dispCanFlag = chkCancel.Enabled
        dispAprvFlag = chkApprove.Enabled

        cmdSave.Enabled = False
        cmdCopy.Enabled = False
        cmdClear.Enabled = False
        cmdInsRow.Enabled = False
        cmdDelRow.Enabled = False
        cmdExit.Enabled = False

        SetComboStatus(cboPriCust, "Disable")
        SetComboStatus(cboSecCust, "Disable")

        chkhdrpo.Enabled = False
        chkCloseOut.Enabled = False
        chkReplacement.Enabled = False
        chkCancel.Enabled = False
        chkApprove.Enabled = False

        cboContactPerson.DropDownStyle = ComboBoxStyle.DropDownList
        cboSalesRep.DropDownStyle = ComboBoxStyle.DropDownList
        cboPrcTrm.DropDownStyle = ComboBoxStyle.DropDownList
        cboPayTrm.DropDownStyle = ComboBoxStyle.DropDownList
        cboHSTU.DropDownStyle = ComboBoxStyle.DropDownList

        Dim i As Integer
        For i = 0 To tabFrame.TabPages.Count - 1
            If i = tabpageno Then
                Me.tabFrame.TabPages(i).Enabled = True
            Else
                Me.tabFrame.TabPages(i).Enabled = False
            End If
        Next i
    End Sub

    Private Sub release_TabControl()
        'If dispSaveFlag = True Then
        '    cmdSave.Enabled = True
        'Else
        '    cmdSave.Enabled = False
        'End If

        'If dispCopyFlag = True Then
        '    cmdCopy.Enabled = True
        'Else
        '    cmdCopy.Enabled = False
        'End If

        'cmdClear.Enabled = True

        'If dispInsFlag = True Then
        '    cmdInsRow.Enabled = True
        'Else
        '    cmdInsRow.Enabled = False
        'End If

        'If dispDelFlag = True Then
        '    cmdDelRow.Enabled = True
        'Else
        '    cmdDelRow.Enabled = False
        'End If

        'cmdExit.Enabled = True

        'If dispApplyPOFlag = True Then
        '    chkhdrpo.Enabled = True
        'Else
        '    chkhdrpo.Enabled = False
        'End If

        'If dispClsOutFlag = True Then
        '    chkCloseOut.Enabled = True
        'Else
        '    chkCloseOut.Enabled = False
        'End If

        'If dispRplmntFlag = True Then
        '    chkReplacement.Enabled = True
        'Else
        '    chkReplacement.Enabled = False
        'End If

        'If dispCanFlag = True Then
        '    chkCancel.Enabled = True
        'Else
        '    chkCancel.Enabled = False
        'End If

        'If dispAprvFlag = True Then
        '    chkApprove.Enabled = True
        'Else
        '    chkApprove.Enabled = False
        'End If

        cmdSave.Enabled = dispSaveFlag
        cmdCopy.Enabled = dispCopyFlag
        cmdClear.Enabled = True
        cmdInsRow.Enabled = dispInsFlag
        cmdDelRow.Enabled = dispDelFlag
        cmdExit.Enabled = True
        chkhdrpo.Enabled = dispApplyPOFlag
        chkCloseOut.Enabled = dispClsOutFlag
        chkReplacement.Enabled = dispRplmntFlag
        chkCancel.Enabled = dispCanFlag
        chkApprove.Enabled = dispAprvFlag


        If dispPriCusFlag = True Then
            SetComboStatus(cboPriCust, "Enable")
        Else
            SetComboStatus(cboPriCust, "Disable")
        End If
        If dispSecCusFlag = True Then
            SetComboStatus(cboSecCust, "Enable")
        Else
            SetComboStatus(cboSecCust, "Disable")
        End If

        cboContactPerson.DropDownStyle = ComboBoxStyle.DropDown
        cboSalesRep.DropDownStyle = ComboBoxStyle.DropDown
        cboPrcTrm.DropDownStyle = ComboBoxStyle.DropDown
        cboPayTrm.DropDownStyle = ComboBoxStyle.DropDown
        cboHSTU.DropDownStyle = ComboBoxStyle.DropDown

        Dim i As Integer
        For i = 0 To tabFrame.TabPages.Count - 1
            tabFrame.TabPages(i).Enabled = True
        Next i

        If dispPOFlag = False Then
            tabFrame.TabPages(tabFrame_UpdatePO).Enabled = False
        End If
    End Sub

    Private Sub display_Component(ByVal read As Boolean)
        dgMatBrkdwn.DataSource = rs_SCCPTBKD_tmp.Tables("RESULT").DefaultView

        With dgMatBrkdwn
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        dgMatBrkDwn_Del = i
                        .Columns(i).HeaderText = "Del"
                        .Columns(i).Width = 40
                        '.Columns(i).ReadOnly = True
                        .Columns(i).ReadOnly = read
                    Case 6
                        dgMatBrkDwn_Mat = i
                        .Columns(i).HeaderText = "Material"
                        .Columns(i).Width = 150
                        '.Columns(i).ReadOnly = False
                        .Columns(i).ReadOnly = read
                    Case 7
                        dgMatBrkDwn_Cur = i
                        .Columns(i).HeaderText = "CCY"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                    Case 8
                        dgMatBrkDwn_CstAmt = i
                        .Columns(i).HeaderText = "Cost $"
                        .Columns(i).Width = 50
                        .Columns(i).ReadOnly = True
                    Case 9
                        dgMatBrkDwn_CstPer = i
                        .Columns(i).HeaderText = "Cost %"
                        .Columns(i).Width = 50
                        '.Columns(i).ReadOnly = False
                        .Columns(i).ReadOnly = read
                    Case 10
                        dgMatBrkDwn_Wgt = i
                        .Columns(i).HeaderText = "WGT %"
                        .Columns(i).Width = 50
                        '.Columns(i).ReadOnly = False
                        .Columns(i).ReadOnly = read
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub cmdSumPODates_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSumPODates.Click
        freeze_TabControl(tabFrame_Summary)
        grpSummary.Enabled = False
        panSumPODates.Width = 310
        panSumPODates.Height = 180
        panSumPODates.Location = New Point(320, 130)

        txtPanSumPODatesSeqFrom.Text = ""
        txtPanSumPODatesSeqTo.Text = ""
        txtPanSumPODatesStart.Text = "  /  /"
        txtPanSumPODatesEnd.Text = "  /  /"
        txtPanSumPODatesCancel.Text = "  /  /"

        panSumPODates.Visible = True
    End Sub

    Private Sub cmdPanSumPODatesUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanSumPODatesUpdate.Click
        If (txtPanSumPODatesSeqFrom.Text) = "" Then
            MsgBox("Custom Vendor Range cannot be empty")
            txtPanSumPODatesSeqFrom.Focus()
            txtPanSumPODatesSeqFrom.SelectAll()
        End If

        If (txtPanSumPODatesSeqTo.Text) = "" Then
            MsgBox("Custom Vendor Range cannot be empty")
            txtPanSumPODatesSeqTo.Focus()
            txtPanSumPODatesSeqTo.SelectAll()
        End If

        If Trim(txtPanSumPODatesSeqFrom.Text) > Trim(txtPanSumPODatesSeqTo.Text) Then
            MsgBox("CV From cannot be greater than CV To")
            txtPanSumPODatesSeqFrom.Focus()
            txtPanSumPODatesSeqFrom.SelectAll()
        End If

        If IsDate(txtPanSumPODatesStart.Text) = False Then
            MsgBox("Invalid PO Start Ship Date")
            txtPanSumPODatesStart.Focus()
            txtPanSumPODatesStart.SelectAll()
            Exit Sub
        End If

        If IsDate(txtPanSumPODatesEnd.Text) = False Then
            MsgBox("Invalid PO End Ship Date")
            txtPanSumPODatesEnd.Focus()
            txtPanSumPODatesEnd.SelectAll()
            Exit Sub
        End If

        If IsDate(txtPanSumPODatesCancel.Text) = False And txtPanSumPODatesCancel.Text <> "  /  /" Then
            MsgBox("Invalid PO Cancel Date")
            txtPanSumPODatesEnd.Focus()
            txtPanSumPODatesEnd.SelectAll()
            Exit Sub
        End If

        If CDate(txtPanSumPODatesStart.Text) > CDate(txtPanSumPODatesEnd.Text) Then
            MsgBox("PO Start Ship Date cannot be greater than PO End Ship Date")
            txtPanSumPODatesStart.Focus()
            txtPanSumPODatesStart.SelectAll()
        End If

        Dim dr() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_cusven >= '" & txtPanSumPODatesSeqFrom.Text & "' and " & _
                                                                  "sod_cusven <= '" & txtPanSumPODatesSeqTo.Text & "'")
        If dr.Length > 0 Then
            Dim drSCDTLSHP() As DataRow
            For i As Integer = 0 To dr.Length - 1
                drSCDTLSHP = Nothing
                drSCDTLSHP = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & dr(i)("sod_ordseq") & "' and sds_status <> 'Y'")
                If drSCDTLSHP.Length = 0 Then
                    dr(i).Item("sod_posstr") = IIf(txtPanSumPODatesStart.Text = "  /  /", "", txtPanSumPODatesStart.Text)
                    dr(i).Item("sod_posend") = IIf(txtPanSumPODatesEnd.Text = "  /  /", "", txtPanSumPODatesEnd.Text)
                    dr(i).Item("sod_poscan") = IIf(txtPanSumPODatesCancel.Text = "  /  /", "", txtPanSumPODatesCancel.Text)
                    If addFlag = True Or dr(i).Item("sod_creusr") = "~*ADD*~" Then
                        dr(i).Item("sod_creusr") = "~*ADD*~"
                    Else
                        dr(i).Item("sod_creusr") = "~*UPD*~"
                    End If

                End If
            Next

            rs_SCORDDTL.AcceptChanges()
            initFlag = True
            rs_SCORDDTL_Summary = rs_SCORDDTL.Copy
            dgSummary.DataSource = rs_SCORDDTL_Summary.Tables("RESULT").DefaultView
            Display_Summary()
            initFlag = False
            Display_Dtl("SCORDDTL")
        End If

        cmdPanSumPODatesCancel.PerformClick()
    End Sub

    Private Sub cmdPanSumPODatesCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanSumPODatesCancel.Click
        release_TabControl()
        grpSummary.Enabled = True
        panSumPODates.Visible = False
    End Sub

    Private Sub check_date_Summary(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtPanSumPODatesStart.Validating, txtPanSumPODatesEnd.Validating, txtPanSumPODatesCancel.Validating
        If IsDate(sender.Text) = False And sender.Text <> "  /  /" And cmdPanSumPODatesCancel.Focused = False Then
            e.Cancel = True
            MsgBox("Date is invalid")
        End If
    End Sub

    Private Sub fillcboRetailCur()
        cboRetailUSDCur.Items.Clear()
        cboRetailCADCur.Items.Clear()

        cboRetailUSDCur.Text = ""
        cboRetailCADCur.Text = ""

        cboRetailUSDCur.Items.Add("AUD")
        cboRetailUSDCur.Items.Add("CAD")
        cboRetailUSDCur.Items.Add("CNY")
        cboRetailUSDCur.Items.Add("EUR")
        cboRetailUSDCur.Items.Add("JPY")
        cboRetailUSDCur.Items.Add("USD")

        cboRetailCADCur.Items.Add("AUD")
        cboRetailCADCur.Items.Add("CAD")
        cboRetailCADCur.Items.Add("CNY")
        cboRetailCADCur.Items.Add("EUR")
        cboRetailCADCur.Items.Add("JPY")
        cboRetailCADCur.Items.Add("USD")
    End Sub

    Private Sub fillcboSeason()
        cboSeason.Items.Clear()

        Dim dr() As DataRow = rs_SYSETINF.Tables("RESULT").Select("ysi_typ = '19'")
        If dr.Length > 0 Then
            cboSeason.Items.Add("")
            For i As Integer = 0 To dr.Length - 1
                cboSeason.Items.Add(dr(i).Item("ysi_dsc"))
            Next
        End If
    End Sub

    Private Sub verify_RetailPrice(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtRetailUSD.Validating, txtRetailCAD.Validating
        If sender.Text.ToString <> "" Then
            If IsNumeric(sender.Text.ToString) = False Then
                MsgBox("Retail Price must be numeric", , "SCM00001 Error - " & sender.Text.ToString)
                e.Cancel = True
                sender.SelectAll()
            End If
        Else
            sender.Text = "0.00"
        End If
    End Sub

    Private Sub cboSalesRep_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboSalesRep.SelectedIndexChanged
        If Split(cboSalesRep.Text, " - ")(0) <> "" Then
            Dim drSalRep() As DataRow = rs_CUBASINF_SalRep.Tables("RESULT").Select("ssr_salrep = '" & Split(cboSalesRep.Text, " - ")(0) & "' and " & _
                                                                                   "ssr_saltem = '" & Split(Split(cboSalesRep.Text, "TEAM ")(1), ")")(0) & "'")
            If drSalRep.Length > 0 Then
                txtSalDivTem.Text = drSalRep(0).Item("saldivtem")
            Else
                txtSalDivTem.Text = ""
            End If
        End If
    End Sub

    Private Sub cmdHdrRmk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdHdrSCRmk.Click
        freeze_TabControl(tabFrame_Header)
        grpHeader.Enabled = False
        panHdrSCRmk.Width = 315
        panHdrSCRmk.Height = 250
        panHdrSCRmk.Location = New Point(485, 200)
        panHdrSCRmk.BringToFront()
        panHdrSCRmk.Visible = True
    End Sub

    Private Sub cmdPanHdrRmkClrAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrSCRmkClrAll.Click
        clearPanHdrRmk()
    End Sub

    Private Sub cmdPanHdrRmkIns_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrSCRmkIns.Click
        Dim preset As String = ""

        If chkHdrSCRmk1.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk1.Text, "&&", "&")
        End If
        If chkHdrSCRmk2.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk2.Text, "&&", "&")
        End If
        If chkHdrSCRmk3.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk3.Text, "&&", "&")
        End If
        If chkHdrSCRmk4.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk4.Text, "&&", "&")
        End If
        If chkHdrSCRmk5.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk5.Text, "&&", "&")
        End If
        If chkHdrSCRmk6.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk6.Text, "&&", "&")
        End If
        If chkHdrSCRmk7.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk7.Text, "&&", "&")
        End If
        If chkHdrSCRmk8.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrSCRmk8.Text, "&&", "&")
        End If

        txtRemark.Text = preset & IIf(txtRemark.Text = "", "", Environment.NewLine) & txtRemark.Text
        cmdPanHdrSCRmkCancel.PerformClick()
    End Sub

    Private Sub cmdPanHdrRmkCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrSCRmkCancel.Click
        clearPanHdrRmk()
        release_TabControl()
        grpHeader.Enabled = True
        panHdrSCRmk.Visible = False
    End Sub

    Private Sub clearPanHdrRmk()
        chkHdrSCRmk1.Checked = False
        chkHdrSCRmk2.Checked = False
        chkHdrSCRmk3.Checked = False
        chkHdrSCRmk4.Checked = False
        chkHdrSCRmk5.Checked = False
        chkHdrSCRmk6.Checked = False
        chkHdrSCRmk7.Checked = False
        chkHdrSCRmk8.Checked = False
    End Sub

    Private Sub cmdRplSeq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRplSeq.Click
        If DtlInputisVaild() = True Then
            rplSeq_SCShpStr = txtStartShip.Text
            rplSeq_SCShpEnd = txtEndShip.Text
            rplSeq_SCCanDat = txtCanDat.Text
            rplSeq_POShpStr = txtPOStartShip.Text
            rplSeq_POShpEnd = txtPOEndShip.Text
            rplSeq_POCanDat = txtPOCanDat.Text
            rplSeq_SCRmk = txtDtlSCRmk.Text
            rplSeq_PORmk = txtDtlPORmk.Text

            If txtSCVerNo.Text <> "1" Then
                'If txtShipped.Text > 0 Or txtPC.Text > 0 Then
                If txtShipped.Text > 0 Then
                    MsgBox("Shipped Qty > 0", , "SCM00001 - Replace Order Sequence")
                    Exit Sub
                Else
                    txtOrdQty.Text = 0
                    txtPC.Text = 0
                End If
            End If
            updateDetailRS()
            chkDelDtl.Checked = True

            recordStatus_dtl = True
            rplSeqFlag = True
            cmdInsRow.PerformClick()
            Dim e1 As New System.Windows.Forms.KeyPressEventArgs(Chr(13))
            txtItmno_KeyPress(sender, e1)
        End If

    End Sub

    Private Sub loadPanDtlShpDat(ByVal mode As String)
        rs_SCDTLSHP_tmp = rs_SCDTLSHP.Copy()
        rs_SCDTLSHP_tmp.Tables("RESULT").DefaultView.RowFilter = "sds_seq = '" & currentOrdSeq & "'"
        dgSCShpDat.Enabled = True
        display_DtlShpDat(mode)
        txtPanDtlShpDatTtlCtn.Enabled = True
        txtPanDtlShpDatTtlCtn.ReadOnly = True
        cmdPanDtlShpDatCancel.Enabled = True
        If mode = "ACT" Or mode = "" Then
            cmdPanDtlShpDatInsRow.Enabled = True
            cmdPanDtlShpDatOK.Enabled = True
        Else
            cmdPanDtlShpDatInsRow.Enabled = False
            cmdPanDtlShpDatOK.Enabled = False
        End If
    End Sub

    Private Sub display_DtlShpDat(ByVal mode As String)
        Dim read_only As Boolean
        If mode = "ACT" Or mode = "" Then
            read_only = False
        Else
            read_only = True
        End If

        dgSCShpDat.DataSource = rs_SCDTLSHP_tmp.Tables("RESULT").DefaultView

        With dgSCShpDat
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        dgDtlShpDat_Del = i
                        .Columns(i).HeaderText = "Del"
                        .Columns(i).Width = 40
                        .Columns(i).ReadOnly = True
                    Case 5
                        dgDtlShpDat_SCFrom = i
                        .Columns(i).HeaderText = "SC Date From"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = read_only
                    Case 6
                        dgDtlShpDat_SCTo = i
                        .Columns(i).HeaderText = "SC Date To"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = read_only
                    Case 7
                        dgDtlShpDat_POFrom = i
                        .Columns(i).HeaderText = "PO Date From"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = read_only
                    Case 8
                        dgDtlShpDat_POTo = i
                        .Columns(i).HeaderText = "PO Date To"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = read_only
                    Case 9
                        dgDtlShpDat_OrdQty = i
                        .Columns(i).HeaderText = "Ord Qty"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = read_only
                    Case 10
                        dgDtlShpDat_CtnStr = i
                        .Columns(i).HeaderText = "Ctn Str"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = read_only
                    Case 11
                        dgDtlShpDat_CtnEnd = i
                        .Columns(i).HeaderText = "Ctn End"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = read_only
                    Case 12
                        .Columns(i).HeaderText = "# of Ctn"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = True
                    Case 13
                        dgDtlShpDat_Dest = i
                        .Columns(i).HeaderText = "Destination"
                        .Columns(i).Width = 200
                        .Columns(i).ReadOnly = read_only
                    Case 14
                        dgDtlShpDat_Rmk = i
                        .Columns(i).HeaderText = "Remark"
                        .Columns(i).Width = 200
                        .Columns(i).ReadOnly = read_only
                        ' Remove when PODTLSHP remark is ready
                        .Columns(i).Visible = False
                    Case 15
                        dgDtlShpDat_CBM = i
                        .Columns(i).HeaderText = "CBM"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next

            Dim totalCtn As Integer = 0
            Dim cbm As Double = 0
            If IsNumeric(Split(cboColPckInfo.Text, " / ")(5)) = True Then
                cbm = CDbl(Split(cboColPckInfo.Text, " / ")(5))
            End If

            For i As Integer = 0 To .Rows.Count - 1
                .Rows(i).Cells("sds_cbm").Value = .Rows(i).Cells("sds_ttlctn").Value * cbm

                If .Rows(i).Cells("sds_status").Value <> "Y" Then
                    totalCtn = totalCtn + .Rows(i).Cells("sds_ttlctn").Value
                End If
            Next
            txtPanDtlShpDatTtlCtn.Text = totalCtn
        End With
    End Sub

    Private Sub cmdPanDtlShpDatInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlShpDatInsRow.Click
        ' Highlight empty row SC From Date Field
        Dim drSCDTLSHP() As DataRow = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and sds_ordqty = '0'")
        If drSCDTLSHP.Length > 0 Then
            For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
                If dgSCShpDat.Rows(i).Cells("sds_shpseq").Value = drSCDTLSHP(0)("sds_shpseq") Then
                    dgSCShpDat.ClearSelection()
                    dgSCShpDat.Rows(i).Cells("sds_scfrom").Selected = True
                    dgSCShpDat.Focus()
                    dgSCShpDat.CurrentCell = dgSCShpDat.Rows(i).Cells("sds_scfrom")
                    Exit Sub
                End If
            Next
        End If

        Dim newRow As DataRow = rs_SCDTLSHP_tmp.Tables("RESULT").NewRow
        newRow.Item("sds_status") = " "
        newRow.Item("sds_seq") = currentOrdSeq
        If dgSCShpDat.Rows.Count = 0 Then
            newRow.Item("sds_shpseq") = 1
        Else
            Dim dr() As DataRow = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "'", "sds_shpseq")
            If dr.Length > 0 Then
                newRow.Item("sds_shpseq") = dr(dr.Length - 1).Item("sds_shpseq") + 1
            End If
        End If

        If txtStartShip.Text <> "  /  /" Then
            newRow.Item("sds_scfrom") = txtStartShip.Text
        Else
            newRow.Item("sds_scfrom") = Format(Date.Now, "MM/dd/yyyy")
        End If
        If txtEndShip.Text <> "  /  /" Then
            newRow.Item("sds_scto") = txtEndShip.Text
        Else
            newRow.Item("sds_scto") = Format(DateAdd(DateInterval.Day, 1, Date.Now), "MM/dd/yyyy")
        End If
        newRow.Item("sds_pofrom") = ""
        newRow.Item("sds_poto") = ""
        newRow.Item("sds_ordqty") = 0
        newRow.Item("sds_ctnstr") = 0
        newRow.Item("sds_ctnend") = 0
        newRow.Item("sds_ttlctn") = 0
        newRow.Item("sds_dest") = ""
        newRow.Item("sds_rmk") = ""
        newRow.Item("sds_cbm") = 0.0
        newRow.Item("sds_creusr") = "~*ADD*~"
        newRow.Item("sds_credat") = Date.Now
        newRow.Item("sds_upddat") = Date.Now
        rs_SCDTLSHP_tmp.Tables("RESULT").Rows.Add(newRow)

        dgSCShpDat_CalcTtlCtn()

        ' Highlight empty row SC From Date Field
        drSCDTLSHP = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_ordqty = '0'")
        If drSCDTLSHP.Length > 0 Then
            For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
                If dgSCShpDat.Rows(i).Cells("sds_shpseq").Value = drSCDTLSHP(0)("sds_shpseq") Then
                    dgSCShpDat.ClearSelection()
                    dgSCShpDat.Rows(i).Cells("sds_scfrom").Selected = True
                    dgSCShpDat.Focus()
                    dgSCShpDat.CurrentCell = dgSCShpDat.Rows(i).Cells("sds_scfrom")
                    Exit Sub
                End If
            Next
        End If

        dgSCShpDat.Focus()
    End Sub

    Private Sub cmdPanDtlShpDatOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlShpDatOK.Click
        rs_SCDTLSHP_tmp.AcceptChanges()
        dgSCShpDat.ClearSelection()

        Dim dr() As DataRow = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y' and sds_ordqty = '0'")
        If dr.Length > 0 Then
            MsgBox("Order Quantity cannot be zero", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
            For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
                If dgSCShpDat.Rows(i).Cells("sds_shpseq").Value = dr(0)("sds_shpseq") Then
                    dgSCShpDat.Rows(i).Selected = True
                End If
            Next
            Exit Sub
        End If

        dr = Nothing
        dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'")
        If dr.Length > 0 Then
            For i As Integer = 0 To dr.Length - 1
                If dr(i)("sds_ttlctn") <> dr(i)("sds_ctnend") - dr(i)("sds_ctnstr") + 1 Then
                    MsgBox("Number of Carton must match Carton Start/Carton End", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                    For j As Integer = 0 To dgSCShpDat.Rows.Count - 1
                        If dgSCShpDat.Rows(j).Cells("sds_shpseq").Value = dr(i)("sds_shpseq") Then
                            dgSCShpDat.Rows(j).Selected = True
                        End If
                    Next
                    Exit Sub
                End If
            Next
        End If

        dr = Nothing
        dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'")
        If lblTotalCtn.Text <> txtPanDtlShpDatTtlCtn.Text And dr.Length > 0 Then
            MsgBox("Total Ship Carton not equal to Total Carton", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
            Exit Sub
        End If

        If dr.Length > 0 Then
            Dim total As Integer
            For i As Integer = 0 To dr.Length - 1
                total = total + dr(i).Item("sds_ordqty")
            Next

            If total.ToString <> txtOrdQty.Text Then
                MsgBox("Total Ship Qty not equal to Total Order Qty", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                Exit Sub
            End If

            rs_SCDTLSHP_tmp.AcceptChanges()
            Dim drPODates() As DataRow = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and sds_status <> 'Y' and sds_pofrom <> ''")
            If dr.Length <> drPODates.Length Then
                drPODates = Nothing
                drPODates = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and sds_status <> 'Y' and sds_pofrom = ''")
                If dr.Length <> drPODates.Length Then
                    MsgBox("PO Dates must be all completed or all left blank", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                    Exit Sub
                End If
            End If
        End If

        If dgSCShpDat_CheckDupShipDate() = True Then
            If dgSCShpDat_CheckDupCarton() = True Then
                rs_SCDTLSHP_tmp.Tables("RESULT").DefaultView.RowFilter = ""
                rs_SCDTLSHP = rs_SCDTLSHP_tmp.Copy()

                ' Update Detail Tab SC Ship Date
                dr = Nothing
                Dim tmp_date As String
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'", "sds_scfrom")
                If dr.Length > 0 Then
                    tmp_date = Format(CDate(dr(0)("sds_scfrom")), "MM/dd/yyyy")
                    For i As Integer = 0 To dr.Length - 1
                        If CDate(tmp_date) > CDate(dr(i)("sds_scfrom")) Then
                            tmp_date = Format(CDate(dr(i)("sds_scfrom")), "MM/dd/yyyy")
                        End If
                    Next
                    'txtStartShip.Text = Format(CDate(dr(0)("sds_scfrom")), "MM/dd/yyyy")
                    txtStartShip.Text = Format(CDate(tmp_date), "MM/dd/yyyy")
                    txtStartShip.Enabled = False
                    'txtCanDat.Enabled = False
                    txtPOStartShip.Enabled = False
                    'txtPOCanDat.Enabled = False
                    cmdPOCalDat.Enabled = False
                Else
                    txtStartShip.Enabled = True
                    'txtCanDat.Enabled = True
                    txtPOStartShip.Enabled = True
                    'txtPOCanDat.Enabled = True
                    cmdPOCalDat.Enabled = True
                End If

                dr = Nothing
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'", "sds_scto")
                If dr.Length > 0 Then
                    tmp_date = Format(CDate(dr(0)("sds_scto")), "MM/dd/yyyy")
                    For i As Integer = 0 To dr.Length - 1
                        If CDate(tmp_date) < CDate(dr(i)("sds_scto")) Then
                            tmp_date = Format(CDate(dr(i)("sds_scto")), "MM/dd/yyyy")
                        End If
                    Next
                    'txtEndShip.Text = Format(CDate(dr(dr.Length - 1)("sds_scto")), "MM/dd/yyyy")
                    txtEndShip.Text = Format(CDate(tmp_date), "MM/dd/yyyy")
                    txtEndShip.Enabled = False
                    'txtCanDat.Enabled = False
                    txtPOEndShip.Enabled = False
                    'txtPOCanDat.Enabled = False
                Else
                    txtEndShip.Enabled = True
                    'txtCanDat.Enabled = True
                    txtPOEndShip.Enabled = True
                    'txtPOCanDat.Enabled = True
                End If

                ' Update Detail Tab PO Ship Date
                dr = Nothing
                tmp_date = ""
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'", "sds_pofrom")
                If dr.Length > 0 Then
                    If dr(0)("sds_pofrom") = "" Then
                        txtPOStartShip.Text = "  /  /"
                    Else
                        tmp_date = Format(CDate(dr(0)("sds_pofrom")), "MM/dd/yyyy")
                        For i As Integer = 0 To dr.Length - 1
                            If CDate(tmp_date) > CDate(dr(i)("sds_pofrom")) Then
                                tmp_date = Format(CDate(dr(i)("sds_pofrom")), "MM/dd/yyyy")
                            End If
                        Next
                        txtPOStartShip.Text = Format(CDate(tmp_date), "MM/dd/yyyy")
                    End If
                End If

                dr = Nothing
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'", "sds_poto")
                If dr.Length > 0 Then
                    If dr(0)("sds_poto") = "" Then
                        txtPOEndShip.Text = "  /  /"
                    Else
                        tmp_date = Format(CDate(dr(0)("sds_poto")), "MM/dd/yyyy")
                        For i As Integer = 0 To dr.Length - 1
                            If CDate(tmp_date) < CDate(dr(i)("sds_poto")) Then
                                tmp_date = Format(CDate(dr(i)("sds_poto")), "MM/dd/yyyy")
                            End If
                        Next
                        txtPOEndShip.Text = Format(CDate(tmp_date), "MM/dd/yyyy")
                    End If
                End If

                ' Update Detail Tab Carton Number
                Dim min As Integer = 0
                Dim max As Integer = 0

                dr = Nothing
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & "sds_status <> 'Y'")
                If dr.Length > 0 Then
                    For i As Integer = 0 To dr.Length - 1
                        If i = 0 Then
                            min = Integer.Parse(Trim(dr(i)("sds_ctnstr")))
                            max = Integer.Parse(Trim(dr(i)("sds_ctnend")))
                        Else
                            If min > Integer.Parse(Trim(dr(i)("sds_ctnstr"))) Then
                                min = Integer.Parse(Trim(dr(i)("sds_ctnstr")))
                            End If

                            If max < Integer.Parse(Trim(dr(i)("sds_ctnend"))) Then
                                max = Integer.Parse(Trim(dr(i)("sds_ctnend")))
                            End If
                        End If
                    Next

                    txtStartCarton.Text = min
                    txtStartCarton.Enabled = False
                    txtEndCarton.Text = max
                    txtEndCarton.Enabled = False
                Else
                    txtStartCarton.Enabled = True
                    txtEndCarton.Enabled = True
                End If

                cmdPanDtlShpDatCancel.PerformClick()
            End If
        End If
    End Sub

    Private Sub cmdPanDtlShpDatCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlShpDatCancel.Click
        rs_SCDTLSHP_tmp = Nothing
        release_TabControl()
        grpDetail.Enabled = True
        panDtlShpDat.Visible = False
    End Sub

    Private Sub dgSCShpDat_CellValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgSCShpDat.CellValidating
        If cmdPanDtlShpDatCancel.Focused Or initFlag = True Then
            Exit Sub
        End If

        If e.ColumnIndex = dgDtlShpDat_SCFrom Then
            If IsDate(e.FormattedValue) = False Or e.FormattedValue.ToString.Length <> 10 Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid Start Date (MM/DD/YYYY)")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_scfrom").Value = "01/01/1900"
                End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_SCTo Then
            If IsDate(e.FormattedValue) = False Or e.FormattedValue.ToString.Length <> 10 Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid End Date (MM/DD/YYYY)")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_scto").Value = "01/01/1900"
                End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_POFrom Then
            If (IsDate(e.FormattedValue) = False Or e.FormattedValue.ToString.Length <> 10) And e.FormattedValue.ToString <> "" Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid Start Date (MM/DD/YYYY)")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value = "01/01/1900"
                End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_POTo Then
            If (IsDate(e.FormattedValue) = False Or e.FormattedValue.ToString.Length <> 10) And e.FormattedValue.ToString <> "" Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid End Date (MM/DD/YYYY)")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_poto").Value = "01/01/1900"
                End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_OrdQty Then
            If Integer.TryParse(e.FormattedValue, Nothing) = False Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid Order Quantity")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_ordqty").Value = "0"
                End If
            Else
                dgSCShpDat.CurrentRow.Cells("sds_ordqty").Value = e.FormattedValue
                dgSCShpDat.CurrentRow.Cells("sds_ttlctn").Value = e.FormattedValue / Split(cboColPckInfo.Text, " / ")(3)
                dgSCShpDat.CurrentRow.Cells("sds_cbm").Value = dgSCShpDat.CurrentRow.Cells("sds_ttlctn").Value * CDbl(Split(cboColPckInfo.Text, " / ")(5))
                dgSCShpDat_CalcTtlCtn()
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_CtnStr Then
            If Integer.TryParse(e.FormattedValue, Nothing) = False Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid Carton Start")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_ctnstr").Value = "0"
                End If
            Else
                'If Integer.TryParse(dgSCShpDat.CurrentRow.Cells("sds_ctnend").Value, Nothing) = True Then
                '    dgSCShpDat.CurrentRow.Cells("sds_ttlctn").Value = dgSCShpDat.CurrentRow.Cells("sds_ctnend").Value - e.FormattedValue + 1
                '    dgSCShpDat.CurrentRow.Cells("sds_ctnstr").Value = e.FormattedValue
                '    dgSCShpDat_CalcTtlCtn()
                'End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_CtnEnd Then
            If Integer.TryParse(e.FormattedValue, Nothing) = False Then
                If panDtlShpDat.Visible = True Then
                    e.Cancel = True
                    MsgBox("Invalid Carton End")
                    Exit Sub
                Else
                    dgSCShpDat.CurrentRow.Cells("sds_ctnend").Value = "0"
                End If
            Else
                'If Integer.TryParse(dgSCShpDat.CurrentRow.Cells("sds_ctnstr").Value, Nothing) = True Then
                '    dgSCShpDat.CurrentRow.Cells("sds_ttlctn").Value = e.FormattedValue - dgSCShpDat.CurrentRow.Cells("sds_ctnstr").Value + 1
                '    dgSCShpDat.CurrentRow.Cells("sds_ctnend").Value = e.FormattedValue
                '    dgSCShpDat_CalcTtlCtn()
                'End If
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_Dest Then
            If e.FormattedValue.ToString.Length > 30 Then
                e.Cancel = True
                MsgBox("Destination Field exceed maximum length of 30 characters", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                Exit Sub
            End If
        ElseIf e.ColumnIndex = dgDtlShpDat_Rmk Then
            If e.FormattedValue.ToString.Length > 50 Then
                e.Cancel = True
                MsgBox("Remark Field exceed maximum length of 50 characters", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                Exit Sub
            End If
        End If
    End Sub

    Private Sub dgSCShpDat_CellValidated(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSCShpDat.CellValidated
        Select Case dgSCShpDat.CurrentCell.ColumnIndex
            Case dgDtlShpDat_CtnStr

            Case dgDtlShpDat_CtnEnd

        End Select
    End Sub

    Private Sub dgSCShpDat_RowValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles dgSCShpDat.RowValidating
        If cmdPanDtlShpDatCancel.Focused Or panDtlShpDat.Visible = False Or initFlag = True Then
            Exit Sub
        End If

        If e.RowIndex >= 0 Then
            If CDate(dgSCShpDat.CurrentRow.Cells("sds_scfrom").Value) > CDate(dgSCShpDat.CurrentRow.Cells("sds_scto").Value) Then
                e.Cancel = True
                MsgBox("SC Start Date > SC End Date")
                Exit Sub
            End If

            If IsDBNull(dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value) Then
                dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value = ""
            End If

            If IsDBNull(dgSCShpDat.CurrentRow.Cells("sds_poto").Value) Then
                dgSCShpDat.CurrentRow.Cells("sds_poto").Value = ""
            End If

            If dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value <> "" Or dgSCShpDat.CurrentRow.Cells("sds_poto").Value <> "" Then
                If dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value <> "" And dgSCShpDat.CurrentRow.Cells("sds_poto").Value = "" Then
                    e.Cancel = True
                    MsgBox("PO End Date cannot be empty")
                    Exit Sub
                ElseIf dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value = "" And dgSCShpDat.CurrentRow.Cells("sds_poto").Value <> "" Then
                    e.Cancel = True
                    MsgBox("PO Start Date cannot be empty")
                    Exit Sub
                ElseIf CDate(dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value) > CDate(dgSCShpDat.CurrentRow.Cells("sds_scto").Value) Then
                    e.Cancel = True
                    MsgBox("PO Start Date > SC End Date")
                ElseIf CDate(dgSCShpDat.CurrentRow.Cells("sds_pofrom").Value) > CDate(dgSCShpDat.CurrentRow.Cells("sds_poto").Value) Then
                    e.Cancel = True
                    MsgBox("PO Start Date > PO End Date")
                    Exit Sub
                End If
            End If

            If dgSCShpDat.CurrentRow.Cells("sds_ctnstr").Value > dgSCShpDat.CurrentRow.Cells("sds_ctnend").Value Then
                e.Cancel = True
                MsgBox("Carton Start > Carton End")
                Exit Sub
            End If

            If dgSCShpDat.CurrentRow.Cells("sds_seq").Value.ToString = lblDtlSeq.Text Then
                If CInt(dgSCShpDat.CurrentRow.Cells("sds_ordqty").Value) Mod CInt(Split(cboColPckInfo.Text, " / ")(3)) <> 0 Then
                    e.Cancel = True
                    MsgBox("Order Quantity is not divisible by Master Quantity", MsgBoxStyle.Information, "SCM00001 - Detail Multiple Shipment")
                    Exit Sub
                End If
            End If 
        End If
    End Sub

    Private Sub dgSCShpDat_CalcTtlCtn()
        Dim count As Integer = 0
        For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
            If dgSCShpDat.Rows(i).Cells("sds_status").Value <> "Y" Then
                count = count + dgSCShpDat.Rows(i).Cells("sds_ttlctn").Value
            End If
        Next
        txtPanDtlShpDatTtlCtn.Text = count
    End Sub

    Private Sub dgSCShpDat_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSCShpDat.CellClick
        If e.RowIndex >= 0 Then
            If e.ColumnIndex >= 0 Then
                If e.ColumnIndex = dgDtlShpDat_Del Then
                    If dgSCShpDat.CurrentRow.Cells("sds_status").Value = "" Then
                        dgSCShpDat.CurrentRow.Cells("sds_status").Value = "Y"
                    Else
                        dgSCShpDat.CurrentRow.Cells("sds_status").Value = ""
                    End If
                    dgSCShpDat_CalcTtlCtn()
                End If
            End If
        End If
    End Sub

    Private Function dgSCShpDat_CheckDupShipDate() As Boolean
        Dim dr() As DataRow

        For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
            If dgSCShpDat.Rows(i).Cells("sds_status").Value <> "Y" Then
                dr = Nothing
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & _
                                                             "sds_shpseq <> " & dgSCShpDat.Rows(i).Cells("sds_shpseq").Value & " and " & _
                                                             "sds_status <> 'Y'")
                If dr.Length > 0 Then
                    For j As Integer = 0 To dr.Length - 1
                        If CDate(dgSCShpDat.Rows(i).Cells("sds_scfrom").Value) >= CDate(dr(j).Item("sds_scfrom")) And CDate(dgSCShpDat.Rows(i).Cells("sds_scfrom").Value) <= CDate(dr(j).Item("sds_scto")) Then
                            If MsgBox("WARNING" & Environment.NewLine & "Duplicate Ship Date Found. Confirm to continue?", MsgBoxStyle.YesNo, "SCM00001 - Duplicate Ship Date") = MsgBoxResult.No Then
                                Return False
                            Else
                                Return True
                            End If
                        End If
                    Next
                End If
            End If
        Next

        Return True
    End Function

    Private Function dgSCShpDat_CheckDupCarton() As Boolean
        Dim dr() As DataRow

        For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
            If dgSCShpDat.Rows(i).Cells("sds_status").Value <> "Y" Then
                dr = Nothing
                dr = rs_SCDTLSHP_tmp.Tables("RESULT").Select("sds_seq = '" & currentOrdSeq & "' and " & _
                                                             "sds_shpseq <> " & dgSCShpDat.Rows(i).Cells("sds_shpseq").Value & " and " & _
                                                             "sds_ctnstr <= " & dgSCShpDat.Rows(i).Cells("sds_ctnstr").Value & " and " & _
                                                             "sds_ctnend >= " & dgSCShpDat.Rows(i).Cells("sds_ctnstr").Value & " and " & _
                                                             "sds_status <> 'Y'")
                If dr.Length > 0 Then
                    If MsgBox("WARNING" & Environment.NewLine & "Duplicate Carton No. Found. Confirm to continue?", MsgBoxStyle.YesNo, "SCM00001 - Duplicate Carton No.") = MsgBoxResult.No Then
                        Return False
                    Else
                        Return True
                    End If
                End If
            End If
        Next

        Return True
    End Function

    Private Sub dgMatBrkdwn_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMatBrkdwn.CellClick
        If e.RowIndex >= 0 Then
            If e.ColumnIndex = dgMatBrkDwn_Del Then
                If dgMatBrkdwn.CurrentRow.Cells("scb_status").Value = "" Then
                    dgMatBrkdwn.CurrentRow.Cells("scb_status").Value = "Y"
                Else
                    dgMatBrkdwn.CurrentRow.Cells("scb_status").Value = ""
                End If
            End If
        End If
    End Sub

    Private Sub dgMatBrkdwn_CellValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgMatBrkdwn.CellValidating
        If cmdPanMatBrkdwnCancel.Focused = True Or panMatBrkdwn.Visible = False Then
            Exit Sub
        End If

        If e.ColumnIndex = dgMatBrkDwn_Mat Then
            If Trim(e.FormattedValue) = "" Then
                e.Cancel = True
                MsgBox("Material Name cannot be empty")
            End If
            'ElseIf e.ColumnIndex = dgMatBrkDwn_Cur Then
            '    If Trim(e.FormattedValue) = "" Then
            '        e.Cancel = True
            '        MsgBox("Currency cannot be empty")
            '    End If
            'ElseIf e.ColumnIndex = dgMatBrkDwn_CstAmt Then
            '    If IsNumeric(e.FormattedValue) = False Then
            '        e.Cancel = True
            '        MsgBox("Cost Amount must be numeric")
            '    End If
        ElseIf e.ColumnIndex = dgMatBrkDwn_CstPer Then
            If IsNumeric(e.FormattedValue) = False Then
                e.Cancel = True
                MsgBox("Cost Percentage must be numeric")
            Else
                If CDbl(e.FormattedValue) > 100 Then
                    e.Cancel = True
                    MsgBox("Cost Percentage must not be over 100%")
                ElseIf CDbl(e.FormattedValue) < 0 Then
                    e.Cancel = True
                    MsgBox("Cost Percentage must not be less than 0%")
                End If
            End If
        ElseIf e.ColumnIndex = dgMatBrkDwn_Wgt Then
            If IsNumeric(e.FormattedValue) = False Then
                e.Cancel = True
                MsgBox("Weight Percentage must be numeric")
            Else
                If CDbl(e.FormattedValue) > 100 Then
                    e.Cancel = True
                    MsgBox("Weight Percentage must not be over 100%")
                ElseIf CDbl(e.FormattedValue) < 0 Then
                    e.Cancel = True
                    MsgBox("Weight Percentage must not be less than 0%")
                End If
            End If
        End If
    End Sub

    Private Sub fillColPckTrm(ByVal typ As String)
        Select Case typ

            Case "IMBASINF"

            Case "CUITMPRC"
                Dim temp As String

                cboColPckInfo.Items.Clear()
                If rs_CUITMPRC.Tables("RESULT").Rows.Count > 0 Then
                    temp = rs_CUITMPRC.Tables("RESULT").Rows(0)("cis_colpck")
                    cboColPckInfo.Items.Add(rs_CUITMPRC.Tables("RESULT").Rows(0)("cis_colpck").ToString)
                    If rs_CUITMPRC.Tables("RESULT").Rows.Count > 1 Then
                        For i As Integer = 1 To rs_CUITMPRC.Tables("RESULT").Rows.Count - 1
                            If temp <> rs_CUITMPRC.Tables("RESULT").Rows(i)("cis_colpck") Then
                                cboColPckInfo.Items.Add(rs_CUITMPRC.Tables("RESULT").Rows(i)("cis_colpck"))
                                temp = rs_CUITMPRC.Tables("RESULT").Rows(i)("cis_colpck")
                            End If
                        Next
                    End If
                End If
        End Select
    End Sub

    Private Sub cmdPanDtlASSCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlASSCancel.Click
        rs_SCASSINF_tmp = Nothing
        release_TabControl()
        grpDetail.Enabled = True
        panDtlASS.Visible = False
    End Sub

    Private Sub cmdPanDtlASSUpdateOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlASSOK.Click
        Dim dr() As DataRow = rs_SCASSINF_tmp.Tables("RESULT").Select("sai_tordno <> '' and sai_tordseq = ''")
        If dr.Length > 0 Then
            MsgBox("Tentative Order has not been matched yet", MsgBoxStyle.Information, "Assorted Item")
            Exit Sub
        End If

        rs_SCASSINF_tmp.Tables("RESULT").DefaultView.RowFilter = ""
        rs_SCASSINF = rs_SCASSINF_tmp.Copy()
        cmdPanDtlASSCancel.PerformClick()
    End Sub

    Private Sub cmdPanDtlASSUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlASSUpdate.Click
        If rs_SCASSINF_tmp.Tables.Count > 0 Then
            If rs_SCASSINF_tmp.Tables("RESULT").Rows.Count > 0 Then
                For i As Integer = 0 To rs_SCASSINF_ori.Tables("RESULT").Rows.Count - 1
                    If rs_SCASSINF_ori.Tables("RESULT").Rows(i)("sai_tordno").ToString <> "" Then
                        MsgBox("An assorted item is related to a Tentative Order.")
                        Exit Sub
                    End If
                Next

                UpdASSItm()
                rs_SCASSINF_tmp = Nothing
                rs_SCASSINF_tmp = rs_SCASSINF.Copy()

                rs_SCASSINF_tmp.Tables("RESULT").DefaultView.RowFilter = "sai_ordseq = " & currentOrdSeq
                dgAssort.DataSource = rs_SCASSINF_tmp.Tables("RESULT").DefaultView

                chkUpdatePO.Checked = True
                display_Assortment()
            End If
        End If
    End Sub

    Private Sub loadPanDtlASS()
        rs_SCASSINF_tmp = rs_SCASSINF.Copy()

        rs_SCASSINF_tmp.Tables("RESULT").DefaultView.RowFilter = "sai_ordseq = " & currentOrdSeq
        dgAssort.DataSource = rs_SCASSINF_tmp.Tables("RESULT").DefaultView

        dgAssort.Enabled = True
        display_Assortment()
        If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And cmdSave.Enabled = True Then
            cmdPanDtlASSOK.Enabled = True

            If (gsUsrRank <= 4 And Enq_right_local) Or gsUsrGrp = "MGT-S" Then
                cmdPanDtlASSUpdate.Enabled = True
            Else
                cmdPanDtlASSUpdate.Enabled = False
            End If
        Else
            cmdPanDtlASSOK.Enabled = False
            cmdPanDtlASSUpdate.Enabled = False

            ' Lock Datagrid
            dgAssort.ReadOnly = True
        End If
        cmdPanDtlASSCancel.Enabled = True
    End Sub

    Private Sub display_Assortment()
        With dgAssort
            For i As Integer = 0 To rs_SCASSINF_tmp.Tables("RESULT").Columns.Count - 1
                rs_SCASSINF_tmp.Tables("RESULT").Columns(i).ReadOnly = False
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Select Case i
                    Case 3
                        .Columns(i).HeaderText = "Assorted Item #"
                        .Columns(i).Width = 140
                        .Columns(i).ReadOnly = True
                    Case 4
                        .Columns(i).HeaderText = "Item Description"
                        .Columns(i).Width = 200
                        .Columns(i).ReadOnly = False
                    Case 5
                        .Columns(i).HeaderText = "Cust Item #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = False
                    Case 6
                        .Columns(i).HeaderText = "Color Code"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 7
                        .Columns(i).HeaderText = "Color Description"
                        .Columns(i).Width = 140
                        .Columns(i).ReadOnly = False
                    Case 8
                        .Columns(i).HeaderText = "SKU #"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = False
                    Case 9
                        .Columns(i).HeaderText = "Customer Sty No"
                        .Columns(i).Width = 105
                        .Columns(i).ReadOnly = False
                    Case 10
                        .Columns(i).HeaderText = "UPC#/EAN#"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = False
                    Case 11
                        dgAssort_CusRtl = i
                        .Columns(i).HeaderText = "Cust. Retail"
                        .Columns(i).Width = 90
                        .Columns(i).ReadOnly = False
                    Case 12
                        .Columns(i).HeaderText = "ASSd IM Period"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 13
                        .Columns(i).HeaderText = "UM"
                        .Columns(i).Width = 60
                        .Columns(i).ReadOnly = True
                    Case 14
                        .Columns(i).HeaderText = "Qty Per Inner"
                        .Columns(i).Width = 100
                        .Columns(i).ReadOnly = True
                    Case 15
                        .Columns(i).HeaderText = "Qty Per Master"
                        .Columns(i).Width = 105
                        .Columns(i).ReadOnly = True
                    Case 18
                        dgAssort_TOOrdno = i
                        .Columns(i).HeaderText = "Tentative #"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = False
                    Case 19
                        dgAssort_TOOrdSeq = i
                        .Columns(i).HeaderText = "Tentative Seq"
                        .Columns(i).Width = 80
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub dgAssort_CellValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgAssort.CellValidating
        If sender.Visible = True Then
            If e.ColumnIndex = dgAssort_CusRtl Then
                If IsNumeric(e.FormattedValue) = False Then
                    e.Cancel = True
                    MsgBox("Customer Retail Must be numeric")
                    Exit Sub
                End If
            ElseIf e.ColumnIndex = dgAssort_TOOrdno Then
                'If e.FormattedValue <> "" And dgAssort.Rows(e.RowIndex).Cells("sai_tordseq").Value.ToString = "" Then
                '    e.Cancel = True
                '    MsgBox("Tentative Order No. has not been matched yet")
                '    Exit Sub
                'End If

                'ElseIf e.ColumnIndex = dgAssort_TOOrdSeq Then
                '    If Integer.TryParse(e.FormattedValue, Nothing) = False Then
                '        e.Cancel = True
                '        MsgBox("TO Order Sequence must be integer")
                '        Exit Sub
                '    End If
            End If
        End If
    End Sub

    Private Sub cmdDtlSCRmk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDtlSCRmk.Click
        freeze_TabControl(tabFrame_Detail)
        grpDetail.Enabled = False
        panDtlSCRmk.Width = 315
        panDtlSCRmk.Height = 250
        panDtlSCRmk.Location = New Point(530, 150)
        panDtlSCRmk.BringToFront()
        panDtlSCRmk.Visible = True
        cmdPanDtlSCRmkClrAll.PerformClick()
    End Sub

    Private Sub cmdPanDtlSCRmkCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlSCRmkCancel.Click
        cmdPanDtlSCRmkClrAll.PerformClick()
        release_TabControl()
        grpDetail.Enabled = True
        panDtlSCRmk.Visible = False

        ''--------------
        'SetInputBoxesStatus("EnableAll")
        'cmdMatBrkdwn.Enabled = True
        'cmdMoreShp.Enabled = True
        'cmdAss.Enabled = True
        'ABUASSORT("SHOW")
        ''------------------
    End Sub

    Private Sub cmdPanDtlSCRmkClrAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlSCRmkClrAll.Click
        chkDtlSCRmk1.Checked = False
        chkDtlSCRmk2.Checked = False
        chkDtlSCRmk3.Checked = False
        chkDtlSCRmk4.Checked = False
        chkDtlSCRmk5.Checked = False
        chkDtlSCRmk6.Checked = False
        chkDtlSCRmk7.Checked = False
        chkDtlSCRmk8.Checked = False
    End Sub

    Private Sub cmdPanDtlSCRmkIns_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlSCRmkIns.Click
        Dim preset As String = ""

        If chkDtlSCRmk1.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk1.Text, "&&", "&")
        End If
        If chkDtlSCRmk2.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk2.Text, "&&", "&")
        End If
        If chkDtlSCRmk3.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk3.Text, "&&", "&")
        End If
        If chkDtlSCRmk4.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk4.Text, "&&", "&")
        End If
        If chkDtlSCRmk5.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk5.Text, "&&", "&")
        End If
        If chkDtlSCRmk6.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk6.Text, "&&", "&")
        End If
        If chkDtlSCRmk7.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk7.Text, "&&", "&")
        End If
        If chkDtlSCRmk8.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlSCRmk8.Text, "&&", "&")
        End If

        txtDtlSCRmk.Text = preset & IIf(txtDtlSCRmk.Text = "", "", Environment.NewLine) & txtDtlSCRmk.Text
        recordStatus = True
        recordStatus_dtl = True
        cmdPanDtlSCRmkCancel.PerformClick()
    End Sub

    Private Sub cmdDtlPORmk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDtlPORmk.Click
        freeze_TabControl(tabFrame_Detail)
        grpDetail.Enabled = False
        panDtlPORmk.Width = 315
        panDtlPORmk.Height = 115
        panDtlPORmk.Location = New Point(530, 290)
        panDtlPORmk.BringToFront()
        panDtlPORmk.Visible = True
        cmdPanDtlPORmkClrAll.PerformClick()
    End Sub

    Private Sub cmdPanDtlPORmkClrAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlPORmkClrAll.Click
        chkDtlPORmk1.Checked = False
        chkDtlPORmk2.Checked = False
    End Sub

    Private Sub cmdPanDtlPORmkIns_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlPORmkIns.Click
        Dim preset As String = ""

        If chkDtlPORmk1.Checked = True Then
            preset = preset & Replace(chkDtlPORmk1.Text, "&&", "&")
        End If

        If chkDtlPORmk2.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkDtlPORmk2.Text, "&&", "&")
        End If

        txtDtlPORmk.Text = preset & IIf(txtDtlPORmk.Text = "", "", Environment.NewLine) & txtDtlPORmk.Text
        recordStatus = True
        recordStatus_dtl = True
        cmdPanDtlPORmkCancel.PerformClick()
    End Sub

    Private Sub cmdPanDtlPORmkCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtlPORmkCancel.Click
        cmdPanDtlPORmkClrAll.PerformClick()
        release_TabControl()
        grpDetail.Enabled = True
        panDtlPORmk.Visible = False
    End Sub

    Private Sub cmdHdrPORmk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdHdrPORmk.Click
        freeze_TabControl(tabFrame_UpdatePO)
        grpUpdatePO.Enabled = False
        panHdrPORmk.Width = 340
        panHdrPORmk.Height = 372
        panHdrPORmk.Location = New Point(105, 155)
        panHdrPORmk.BringToFront()
        panHdrPORmk.Visible = True
        cmdPanHdrPORmkClrAll.PerformClick()
    End Sub

    Private Sub cmdPanHdrPORmkClrAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrPORmkClrAll.Click
        chkHdrPORmk1.Checked = False
        chkHdrPORmk2.Checked = False
        chkHdrPORmk3.Checked = False
        chkHdrPORmk4.Checked = False
        chkHdrPORmk5.Checked = False
        chkHdrPORmk6.Checked = False
        chkHdrPORmk7.Checked = False
        chkHdrPORmk8.Checked = False
        chkHdrPORmk9.Checked = False
        chkHdrPORmk10.Checked = False
        chkHdrPORmk11.Checked = False
        chkHdrPORmk12.Checked = False
        chkHdrPORmk13.Checked = False
    End Sub

    Private Sub cmdPanHdrPORmkIns_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrPORmkIns.Click
        Dim preset As String = ""

        If chkHdrPORmk1.Checked = True Then
            preset = preset & Replace(chkHdrPORmk1.Text, "&&", "&")
        End If
        If chkHdrPORmk2.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk2.Text, "&&", "&")
        End If
        If chkHdrPORmk3.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk3.Text, "&&", "&")
        End If
        If chkHdrPORmk4.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk4.Text, "&&", "&")
        End If
        If chkHdrPORmk5.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk5.Text, "&&", "&")
        End If
        If chkHdrPORmk6.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk6.Text, "&&", "&")
        End If
        If chkHdrPORmk7.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk7.Text, "&&", "&")
        End If
        If chkHdrPORmk8.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk8.Text, "&&", "&")
        End If
        If chkHdrPORmk9.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk9.Text, "&&", "&")
        End If
        If chkHdrPORmk10.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk10.Text, "&&", "&")
        End If
        If chkHdrPORmk11.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk11.Text, "&&", "&")
        End If
        If chkHdrPORmk12.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk12.Text, "&&", "&")
        End If
        If chkHdrPORmk13.Checked = True Then
            preset = preset & IIf(preset = "", "", Environment.NewLine) & Replace(chkHdrPORmk13.Text, "&&", "&")
        End If

        txtPOHdrRmk.Text = preset & IIf(txtPOHdrRmk.Text = "", "", Environment.NewLine) & txtPOHdrRmk.Text
        cmdPanHdrPORmkCancel.PerformClick()
    End Sub

    Private Sub cmdPanHdrPORmkCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanHdrPORmkCancel.Click
        cmdPanHdrPORmkClrAll.PerformClick()
        release_TabControl()
        grpUpdatePO.Enabled = True
        panHdrPORmk.Visible = False
    End Sub

    Private Function fillVendorPrices(ByVal mode As String, Optional ByVal cih As DataSet = Nothing) As Boolean
        fillVendorList(txtItmno.Text)

        txtDVItmCst.Enabled = True
        txtDVTtlCst.Enabled = False

        If gsUsrRank <= 4 Then
            txtDVItmCst.Enabled = True
            txtDVBOMCst.Enabled = True
        Else
            txtDVItmCst.Enabled = False
            txtDVBOMCst.Enabled = False
        End If

        If (strDVBOMCst = "0" Or CDbl(strDVBOMCst) = 0) And CDbl(txtBOMCst.Text) = 0 Then
            txtDVBOMCst.Enabled = False
        End If

        ' Added by Mark Lau 20080826
        If cboSCStatus.Text <> "" Then
            If cboSCStatus.Text.Substring(0, 3) <> "ACT" Then
                txtDVItmCst.Enabled = False
                txtDVBOMCst.Enabled = False
            End If
        End If

        If chkDelDtl.Checked = True Then
            txtDVItmCst.Enabled = False
            txtDVBOMCst.Enabled = False
        End If

        If UCase(mode) = "CUITMPRC" Then
            Dim vendor As DataSet

            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            gspStr = "sp_select_VNBASINF '','" & rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_venno") & "'"
            Me.Cursor = Windows.Forms.Cursors.Default
            rtnLong = execute_SQLStatement(gspStr, vendor, rtnStr)

            If vendor.Tables("RESULT").Rows.Count > 0 Then
                txtVenno.Text = vendor.Tables("RESULT").Rows(0)("vbi_venno") & " - " & vendor.Tables("RESULT").Rows(0)("vbi_vensna")
            Else
                txtVenno.Text = ""
            End If

            fillcboCusVen(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_cusven"))
            fillcboPrdVen(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_prdven"))
            fillcboTradeVen(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_tradeven"))
            fillcboexamven(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_examven"))

            lblVenItm.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("ivi_venitm")

            If rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_itmventyp") = "E" Then
                lblDVItmCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                txtDVItmCst.Text = "9999.0000"
                txtDVBOMCst.Text = "9999.0000"
                txtDVTtlCst.Text = "9999.0000"
                lblDVFtyUnt.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde")

                lblFtyCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                txtFtyCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftycst")

                lblItmCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                'txtItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftycst")
                'txtBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                'txtTtlCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                txtTtlCst.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc") + rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst"), "#0.0000")
                lblFtyUnt.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde")

                If gsFlgCstExt = "1" Then
                    'setDtlStatus("Cost")
                    setDtlStatus("NoDVCost")
                Else
                    setDtlStatus("NoCost")
                End If
            Else
                lblDVItmCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                'txtDVItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftycst")
                'txtDVBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                'txtDVTtlCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtDVItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtDVBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                txtDVTtlCst.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc") + rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst"), "#0.0000")
                lblDVFtyUnt.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde")

                lblFtyCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                txtFtyCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftycst")

                lblItmCstCur.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_fcurcde")
                'txtItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftycst")
                'txtBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                'txtTtlCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtItmCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc")
                txtBOMCst.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst")
                txtTtlCst.Text = Format(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_ftyprc") + rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_bomcst"), "#0.0000")
                lblFtyUnt.Text = rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_untcde")

                If gsFlgCstExt = "1" Then
                    setDtlStatus("Cost")
                Else
                    setDtlStatus("NoCost")
                End If
            End If

            Return True
        ElseIf UCase(mode) = "SCORDDTL" Then
            Dim vendor As DataSet

            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            gspStr = "sp_select_VNBASINF '','" & rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dv") & "'"
            Me.Cursor = Windows.Forms.Cursors.Default
            rtnLong = execute_SQLStatement(gspStr, vendor, rtnStr)

            If vendor.Tables("RESULT").Rows.Count > 0 Then
                txtVenno.Text = vendor.Tables("RESULT").Rows(0)("vbi_venno") & " - " & vendor.Tables("RESULT").Rows(0)("vbi_vensna")
            Else
                txtVenno.Text = ""
            End If

            If cboColPckInfo.Text <> "" Then
                fillcboCusVen(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_cusven"))
                fillcboPrdVen(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno"))
                fillcboTradeVen(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_tradeven"))
                fillcboexamven(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_examven"))

                'Ignore Error Message when trying to tab out of an imcomplete Detail page
                Try
                    If vendor.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
                        lblDVItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                        txtDVItmCst.Text = "9999.0000"
                        txtDVBOMCst.Text = "9999.0000"
                        txtDVTtlCst.Text = "9999.0000"
                        lblDVFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")

                        lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                        txtItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst")
                        txtBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst")
                        txtTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc")
                        lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")

                        If gsFlgCstExt = "1" Then
                            'setDtlStatus("Cost")
                            setDtlStatus("NoDVCost")
                        Else
                            setDtlStatus("NoCost")
                        End If
                    Else
                        lblDVItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvfcurcde")
                        txtDVItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftycst")
                        txtDVBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvbomcst")
                        txtDVTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyprc")
                        lblDVFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_dvftyunt")


                        lblItmCstCur.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_fcurcde")
                        txtItmCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftycst")
                        txtBOMCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_bomcst")
                        txtTtlCst.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyprc")
                        lblFtyUnt.Text = rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_ftyunt")

                        If gsFlgCstExt = "1" Then
                            setDtlStatus("Cost")
                        Else
                            setDtlStatus("NoCost")
                        End If
                    End If
                Catch ex As Exception
                    MsgBox("Detail Item has not been completed")
                End Try
            End If
        ElseIf UCase(mode) = "CHANGEPV" Then
            If Not cih Is Nothing Then
                ' -- Only External Prices may be affected from PV Change --
                lblVenItm.Text = cih.Tables("RESULT").Rows(0)("ivi_venitm")

                If cih.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cis_itmventyp") = "E" Then
                    lblDVItmCstCur.Text = cih.Tables("RESULT").Rows(0)("cip_fcurcde")
                    txtDVItmCst.Text = "9999.0000"
                    txtDVBOMCst.Text = "9999.0000"
                    txtDVTtlCst.Text = "9999.0000"
                    lblDVFtyUnt.Text = cih.Tables("RESULT").Rows(0)("cis_untcde")

                    lblFtyCstCur.Text = cih.Tables("RESULT").Rows(0)("cip_fcurcde")
                    txtFtyCst.Text = cih.Tables("RESULT").Rows(0)("cip_ftycst")

                    lblItmCstCur.Text = cih.Tables("RESULT").Rows(0)("cip_fcurcde")
                    'txtItmCst.Text = cih.Tables("RESULT").Rows(0)("cip_ftycst")
                    'txtBOMCst.Text = cih.Tables("RESULT").Rows(0)("cip_bomcst")
                    'txtTtlCst.Text = cih.Tables("RESULT").Rows(0)("cip_ftyprc")
                    txtItmCst.Text = cih.Tables("RESULT").Rows(0)("cip_ftyprc")
                    txtBOMCst.Text = cih.Tables("RESULT").Rows(0)("cip_bomcst")
                    txtTtlCst.Text = Format(cih.Tables("RESULT").Rows(0)("cip_ftyprc") + cih.Tables("RESULT").Rows(0)("cip_bomcst"), "#0.0000")
                    lblFtyUnt.Text = cih.Tables("RESULT").Rows(0)("cis_untcde")

                    If gsFlgCstExt = "1" Then
                        setDtlStatus("NoDVCost")
                    Else
                        setDtlStatus("NoCost")
                    End If
                End If
            Else
                MsgBox("Error Occurred on loading from CIH", MsgBoxStyle.Information, "SCM00001 - Change PV")
            End If
        End If
    End Function

    Private Sub fillVendorList(ByVal itmno As String)
        Dim rs As DataSet

        gspStr = "sp_select_VNBASINF_SC '" & cboCoCde.Text & "','" & Trim(txtItmno.Text) & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #112 sp_select_VNBASINF_SC : " & rtnStr)
            Exit Sub
        Else
            rs_VNBASINF_SC = rs.Copy()

            gspStr = "sp_list_VNBASINF ''"
            rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #140 sp_list_VNBASINF :" & rtnStr)
                Exit Sub
            End If
        End If
    End Sub

    Private Sub cboPrdVen_ChangePV()
        Dim vn As DataSet
        Dim cu As DataSet
        Dim CUITMPRC_PV As DataSet

        gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & Split(cboPrdVen.Text, " - ")(0) & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, vn, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #114 sp_select_VNBASINF : " & rtnStr)
            Exit Sub
        End If

        If vn.Tables("RESULT").Rows.Count = 0 Then
            MsgBox("PV Not found in Item Master", MsgBoxStyle.Information, "SCM00001 - Change PV")
            Exit Sub
        Else
            ' Update Vendor MOQ Charge Flag
            If vn.Tables("RESULT").Rows(0)("vbi_moqchg") = "Y" Then
                VENMOQChgFlag = True
            Else
                VENMOQChgFlag = False
            End If

            If vn.Tables("RESULT").Rows(0)("vbi_ventyp") = "E" Then
                VendorType = "E"
                If gsFlgCstExt = "1" Then
                    'setDtlStatus("Cost")
                    setDtlStatus("NoDVCost")
                Else
                    setDtlStatus("NoCost")
                End If

                '-- Check CIH Pricing if exist --
                'gspStr = "sp_select_CUITMPRC_SC_PV '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & Split(cboPriCust.Text, " - ")(0) & _
                '         "','" & Split(cboSecCust.Text, " - ")(0) & "','" & Split(cboColPckInfo.Text, " / ")(0) & "','" & _
                '         Split(cboColPckInfo.Text, " / ")(1) & "','" & Split(cboColPckInfo.Text, " / ")(2) & "','" & _
                '         Split(cboColPckInfo.Text, " / ")(3) & "','" & Split(cboColPckInfo.Text, " / ")(6) & "','" & _
                '         Split(cboColPckInfo.Text, " / ")(7) & "','" & Split(cboColPckInfo.Text, " / ")(8) & "','" & _
                '         Split(txtVenno.Text, " - ")(0) & "','" & Split(cboPrdVen.Text, " - ")(0) & "','" & _
                '         Format(rs_SCORDHDR.Tables("RESULT").Rows(currentRow)("soh_cpodat"), "MM/dd/yyyy") & " 23:59','" & LCase(gsUsrID) & "'"
                gspStr = "sp_select_CUITMPRC_SC_PV '" & cboCoCde.Text & "','" & txtItmno.Text & "','" & Split(cboPriCust.Text, " - ")(0) & _
                         "','" & Split(cboSecCust.Text, " - ")(0) & "','" & Split(cboColPckInfo.Text, " / ")(0) & "','" & _
                         Split(cboColPckInfo.Text, " / ")(1) & "','" & Split(cboColPckInfo.Text, " / ")(2) & "','" & _
                         Split(cboColPckInfo.Text, " / ")(3) & "','" & Split(cboColPckInfo.Text, " / ")(6) & "','" & _
                         Split(cboColPckInfo.Text, " / ")(7) & "','" & Split(cboColPckInfo.Text, " / ")(8) & "','" & _
                         Split(txtVenno.Text, " - ")(0) & "','" & Split(cboPrdVen.Text, " - ")(0) & "','" & _
                         Format(CDate(txtCustPoDat.Text), "MM/dd/yyyy") & " 23:59','" & LCase(gsUsrID) & "'"
                Me.Cursor = Windows.Forms.Cursors.WaitCursor
                rtnLong = execute_SQLStatement(gspStr, CUITMPRC_PV, rtnStr)
                Me.Cursor = Windows.Forms.Cursors.Default
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #115 sp_select_CUITMPRC_SC_PV : " & rtnStr)
                    Exit Sub
                Else
                    If CUITMPRC_PV.Tables("RESULT").Rows.Count = 0 Then
                        MsgBox("PV not found in CIH", MsgBoxStyle.Information, "SCM00001 - Change PV")
                        'display_combo(IIf(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~", rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno"), rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_prdven")), cboPrdVen)
                        If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" Then
                            display_combo(rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_venno"), cboPrdVen)
                        Else
                            display_combo(rs_CUITMPRC.Tables("RESULT").Rows(cboColPckInfo.SelectedIndex)("cip_prdven"), cboPrdVen)
                        End If
                        Exit Sub
                    End If
                End If

                If CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_latest") = "N" Then
                    MsgBox("CIH price is not the most recent record", MsgBoxStyle.Information, "SCM00001 - CIH Warning")
                End If

                Dim drCust_P As DataRow() = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")
                '****************Cal Item Basic Price*************************************************
                If CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_minprc") > 0 And CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_minprc") <> CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_basprc") Then
                    ' Determine Basic Price
                    SalRate(drCust_P(0).Item("cpi_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_basprc"), "IM")
                    txtItmBasPrc.Text = txtItmPrc.Text
                    ' Determine Mininum Price
                    lblBasprc.Text = "Min MU Price"
                    SalRate(drCust_P(0).Item("cpi_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_minprc"), "IM")
                Else
                    lblBasprc.Text = "Basic Price"
                    SalRate(drCust_P(0).Item("cpi_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_basprc"), "IM")
                    txtItmBasPrc.Text = txtItmPrc.Text
                End If
                'SalRate(drCust_P(0).Item("cpi_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_basprc"), "IM")

                '***************Cal CUITMSUM Selprc and untprc**************************
                SalRate(drCust_P(0).Item("cpi_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_curcde"), CUITMPRC_PV.Tables("RESULT").Rows(0)("cis_selprc"), "SC")
                'SalRate(drCust_P(0).Item("cpi_curcde"), "USD", CUITMPRC_PV.Tables("RESULT").Rows(0)("cis_selprc"), "SC")

                txtEffectiveCPO.Text = CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_effcpo")
                txtEffDat.Text = Format(CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_effdat"), "MM/dd/yyyy")
                txtExpDat.Text = Format(CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_expdat"), "MM/dd/yyyy")
                txtCIHPrd.Text = Format(CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_qutdat"), "yyyy-MM")
                If CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_cus1no") <> "" Then
                    txtPrcGrp.Text = CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_cus1no")
                    If CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_cus2no") <> "" Then
                        txtPrcGrp.Text = txtPrcGrp.Text & " / " & CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_cus2no")
                    End If
                Else
                    txtPrcGrp.Text = "STANDARD"
                End If

                fillVendorPrices("CHANGEPV", CUITMPRC_PV)
            Else
                VendorType = vn.Tables("RESULT").Rows(0)("vbi_ventyp")
                If gsFlgCst = "1" Then
                    setDtlStatus("Cost")
                Else
                    setDtlStatus("NoCost")
                End If
            End If

            If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") And chkCloseOut.Checked = False Then
                If rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_creusr") <> "~*ADD*~" Then
                    If txtSCVerNo.Text <> "1" Then
                        chkChgFty.Checked = True
                    Else
                        chkChgFty.Checked = False
                    End If
                Else
                    chkUpdatePO.Checked = True
                End If

                If currentRow < rs_SCORDDTL.Tables("RESULT").Rows.Count Then
                    If VendorType = "E" Then
                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgfty") = Format(CUITMPRC_PV.Tables("RESULT").Rows(0)("cip_ftycst"), "#0.0000")
                    Else
                        rs_SCORDDTL.Tables("RESULT").Rows(currentRow)("sod_orgfty") = Format(CDbl(txtDVTtlCst.Text), "#0.0000")
                    End If
                End If
            End If
        End If

        If Trim(txtOrdQty.Text) <> "" Then
            If txtOrdQty.Text <> 0 Then
                If txtOrdQty.Enabled = True And txtOrdQty.Text <> "" And txtDiscount.Text <> "" And txtUntPrc.Text <> "" Then
                    Cal_DtlTotalCtn(txtOrdQty.Text)
                    Cal_DtlPrcSubTTl(txtNetUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text)
                    Cal_DtlPrcNetSelPrc(txtUntPrc.Text, txtDiscount.Text, Custfml, txtOrdQty.Text + 0, txtMOQChg.Text)
                Else
                    Cal_DtlTotalCtn(0)
                    Cal_DtlPrcSubTTl(0, 0, Custfml, 0)
                    Cal_DtlPrcNetSelPrc(0, 0, Custfml, 0, 0)
                    OrgMOQChg = 0
                    txtMOQChg.Text = 0
                    txtMOQChg.Enabled = False
                End If
            End If
        End If
    End Sub

    'Private Sub cboPrdVen_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPrdVen.SelectedIndexChanged
    '    cboPrdVen_ChangePV()
    'End Sub

    Private Sub cboPrdVen_SelectionChangeCommitted(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPrdVen.SelectionChangeCommitted
        'cboVenno_ChangeVenno()
        cboPrdVen_ChangePV()
        recordStatus_dtl = True
    End Sub

    Private Sub cboPriCust_Validated(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPriCust.Validated
        '-- Determine CusMOQMOA
        gspStr = "sp_select_CUPRCINF '" & cboCoCde.Text & "','" & Split(cboPriCust.Text, " - ")(0) & "'"
        rs = Nothing
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #116 sp_select_CUPRCINF : " & rtnStr)
            Exit Sub
        Else
            If rs.Tables("RESULT").Rows.Count > 0 Then
                If rs.Tables("RESULT").Rows(0)("cpi_moqchgflg") = "Y" Then
                    CUSMOQChgFlag = True
                Else
                    CUSMOQChgFlag = False
                End If

                If rs.Tables("RESULT").Rows(0)("cpi_moachgflg") = "Y" Then
                    CUSMOAChgFlag = True
                Else
                    CUSMOAChgFlag = False
                End If
            End If
        End If
    End Sub

    Private Function checkUpdateShipDetail(ByVal ordseq As Integer, ByVal shpseq As Integer, ByVal drSCDTLSHP As DataRow) As Boolean
        Dim drSCDTLSHP_ori() As DataRow = rs_SCDTLSHP_ori.Tables("RESULT").Select("sds_seq = '" & ordseq & "' and sds_shpseq = '" & shpseq & "'")
        If drSCDTLSHP_ori.Length > 0 Then
            For i As Integer = 0 To rs_SCDTLSHP.Tables("RESULT").Columns.Count - 1
                Select Case drSCDTLSHP.Item(i).GetType.ToString
                    Case "System.Decimal"
                        If drSCDTLSHP.Item(i) <> drSCDTLSHP_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.Int32"
                        If drSCDTLSHP.Item(i) <> drSCDTLSHP_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.String"
                        If Trim(drSCDTLSHP.Item(i).ToString) <> Trim(drSCDTLSHP_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                    Case "System.DateTime"
                        If drSCDTLSHP.Item(i) <> drSCDTLSHP_ori(0).Item(i) Then
                            Return True
                        End If
                    Case Else
                        If Trim(drSCDTLSHP.Item(i).ToString) <> Trim(drSCDTLSHP_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                End Select
            Next
            Return False
        Else
            Return False
        End If
    End Function

    Private Function checkUpdateComponent(ByVal ordseq As Integer, ByVal cptseq As Integer, ByVal drSCCPTBKD As DataRow) As Boolean
        Dim drSCCPTBKD_ori() As DataRow = rs_SCCPTBKD_ori.Tables("RESULT").Select("scb_ordseq = '" & ordseq & "' and scb_cptseq = '" & cptseq & "'")
        If drSCCPTBKD_ori.Length > 0 Then
            For i As Integer = 0 To rs_SCCPTBKD.Tables("RESULT").Columns.Count - 1
                Select Case drSCCPTBKD.Item(i).GetType.ToString
                    Case "System.Decimal"
                        If drSCCPTBKD.Item(i) <> drSCCPTBKD_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.Int32"
                        If drSCCPTBKD.Item(i) <> drSCCPTBKD_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.String"
                        If Trim(drSCCPTBKD.Item(i).ToString) <> Trim(drSCCPTBKD_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                    Case Else
                        If Trim(drSCCPTBKD.Item(i).ToString) <> Trim(drSCCPTBKD_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                End Select
            Next
            Return False
        Else
            Return False
        End If
    End Function

    Private Sub comboBoxCell(ByVal dgv As DataGridView, ByVal typ As String)
        Dim cboCell As New DataGridViewComboBoxCell
        Dim iCol As Integer = dgv.CurrentCell.ColumnIndex
        Dim iRow As Integer = dgv.CurrentCell.RowIndex
        Dim row As DataGridViewRow = dgv.CurrentRow

        Select Case typ
            Case "OneTimePrc"
                cboCell.Items.Add("Y")
                cboCell.Items.Add("N")
            Case "CusUSDCur"
                cboCell.Items.Add("AUD")
                cboCell.Items.Add("CAD")
                cboCell.Items.Add("CNY")
                cboCell.Items.Add("EUR")
                cboCell.Items.Add("JPY")
                cboCell.Items.Add("USD")
            Case "CusCADCur"
                cboCell.Items.Add("AUD")
                cboCell.Items.Add("CAD")
                cboCell.Items.Add("CNY")
                cboCell.Items.Add("EUR")
                cboCell.Items.Add("JPY")
                cboCell.Items.Add("USD")
            Case "CustUM"
                Dim rsCustUM As DataSet
                gspStr = "sp_select_SQL '','" & "select ysi_cde from SYSETINF where ysi_typ = ''05'' order by ysi_cde asc" & "'"
                rtnLong = execute_SQLStatement(gspStr, rsCustUM, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #120 sp_select_VNBASINF : " & rtnStr)
                    Exit Sub
                End If

                cboCell.Items.Add("")
                For i As Integer = 0 To rsCustUM.Tables("RESULT").Rows.Count - 1
                    cboCell.Items.Add(rsCustUM.Tables("RESULT").Rows(i)("ysi_cde"))
                Next
        End Select

        cboCell.DisplayStyle = DataGridViewComboBoxDisplayStyle.ComboBox

        dgv.Rows(iRow).Cells(iCol) = cboCell
        dgv.Rows(iRow).Cells(iCol).ReadOnly = False
    End Sub

    Private Sub dgSummary_CellValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgSummary.CellValidating, dgAssort.CellValidating
        If sender.Focused = False Then
            Exit Sub
        End If

        If e.RowIndex >= 0 And sender.Focused = True Then
            Select Case e.ColumnIndex
                Case dgSummary_OrdQty
                    If Integer.TryParse(e.FormattedValue, Nothing) = False Then
                        e.Cancel = True
                        MsgBox("Order Quantity must be an integer")
                    End If
                Case dgSummary_SelPrc
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("Selling Price must be numeric")
                    End If
                Case dgSummary_FtyCst
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("PV Item Cost must be numeric")
                    End If
                Case dgSummary_BOMCst
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("PV BOM Cost must be numeric")
                    End If
                Case dgSummary_FtyPrc
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("PV Total Cost must be numeric")
                    End If
                Case dgSummary_DVFtyCst
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("DV Item Cost must be numeric")
                    End If
                Case dgSummary_DVBOMCst
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("DV BOM Cost must be numeric")
                    End If
                Case dgSummary_DVFtyPrc
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("DV Total Cost must be numeric")
                    End If
                Case dgSummary_DtyRat
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("Duty Rate must be numeric")
                    End If
                Case dgSummary_CusUSD
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("Retail 1 Amount must be numeric")
                    End If
                Case dgSummary_CusCAD
                    If IsNumeric(e.FormattedValue) = False Then
                        e.Cancel = True
                        MsgBox("Retail 2 Amount must be numeric")
                    End If
            End Select
        End If
    End Sub

    Private Sub dgSummary_DataError(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles dgSummary.DataError
        ' Used for all Data Error
    End Sub

    Private Sub dgSummary_RowValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles dgSummary.RowValidating
        If dgSummary.Focused = False Then
            Exit Sub
        End If

        If dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value.ToString = "" Then
            e.Cancel = True
            MsgBox("Please input the Order Qty", MsgBoxStyle.Information, "SCM00001 - Summary")
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value = 0 And txtSCVerNo.Text = "1" And Split(cboSCStatus.Text, " - ")(0) <> "CAN" Then
            e.Cancel = True
            MsgBox("Order Qty cannot be Zero!", MsgBoxStyle.Exclamation, "SCM00001 - Summary")
            Cal_SummaryTotalCtn(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value)
            Cal_SummaryPrcSubTTl(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_netuntprc").Value, 0)
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value < dgSummary.Rows(e.RowIndex).Cells("sod_shpqty").Value And txtSCVerNo.Text <> "1" Then
            e.Cancel = True
            MsgBox("Order Qty < Shipped Qty !", MsgBoxStyle.Information, "SCM00001 - Summary")
            Cal_SummaryTotalCtn(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value)
            Cal_SummaryPrcSubTTl(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_netuntprc").Value, 0)
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_mtrctn").Value = 0 Then
            e.Cancel = True
            MsgBox("Order Qty not Divisible by Master Qty", MsgBoxStyle.Exclamation, "SCM00001 - Summary")
            Cal_SummaryTotalCtn(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value)
            Cal_SummaryPrcSubTTl(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_netuntprc").Value, 0)
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value Mod dgSummary.Rows(e.RowIndex).Cells("sod_mtrctn").Value <> 0 And txtOrdQty.Enabled = True Then
            e.Cancel = True
            MsgBox("Order Qty not Divisible by Master Qty", MsgBoxStyle.Exclamation, "SCM00001 - Summary")
            Cal_SummaryTotalCtn(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value)
            Cal_SummaryPrcNetSelPrc(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_untprc").Value, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value, dgSummary.Rows(e.RowIndex).Cells("sod_moqchg").Value)
            Cal_SummaryPrcSubTTl(e.RowIndex, dgSummary.Rows(e.RowIndex).Cells("sod_netuntprc").Value, dgSummary.Rows(e.RowIndex).Cells("sod_ordqty").Value)
            'Cal_SummaryPrcSubTTl(dgSummary.Rows(e.RowIndex).Cells("sod_selprc").Value, 0)
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ctnstr").Value.ToString = "" And txtStartCarton.Enabled = True Then
            e.Cancel = True
            MsgBox("Please input the Start Carton", MsgBoxStyle.Information, "SCM00001 - Summary")
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ctnend").Value.ToString = "" And txtEndCarton.Enabled = True Then
            e.Cancel = True
            MsgBox("Please input the End Carton", MsgBoxStyle.Information, "SCM00001 - Summary")
            Exit Sub
        ElseIf dgSummary.Rows(e.RowIndex).Cells("sod_ctnstr").Value > dgSummary.Rows(e.RowIndex).Cells("sod_ctnend").Value And txtStartCarton.Enabled = True Then
            e.Cancel = True
            MsgBox("Start Carton > End Carton !", MsgBoxStyle.Exclamation, "SCM00001 - Summary")
            Exit Sub
        ElseIf (dgSummary.Rows(e.RowIndex).Cells("sod_ctnend").Value - dgSummary.Rows(e.RowIndex).Cells("sod_ctnstr").Value + 1) <> dgSummary.Rows(e.RowIndex).Cells("sod_ttlctn").Value And _
                dgSummary.Rows(e.RowIndex).Cells("sod_ctnstr").Value <> 0 Then
            Dim drSCDTLSHP As DataRow() = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & dgSummary.Rows(e.RowIndex).Cells("sod_ordseq").Value & "' and sds_status <> 'Y'")
            If drSCDTLSHP.Length = 0 Then
                e.Cancel = True
                MsgBox("Not equal to the Total Carton Number !", MsgBoxStyle.Information, "SCM00001 - Summary")
                Exit Sub
            End If
        End If


        If (Split(cboSCStatus.Text, " - ")(0) = "ACT" Or Split(cboSCStatus.Text, " - ")(0) = "HLD") Then
            Dim total As Long
            Dim dr() As DataRow = rs_SCDTLSHP.Tables("RESULT").Select("sds_seq = '" & dgSummary.Rows(e.RowIndex).Cells("sod_ordseq").Value.ToString & "' and sds_status = ' ' ")
            If txtStartShip.Enabled = False Then
                total = 0
                If dr.Length > 0 Then
                    For i As Integer = 0 To dr.Length - 1
                        total = total + dr(i).Item("sds_ttlctn")
                    Next

                    If total <> dgSummary.Rows(e.RowIndex).Cells("sod_ttlctn").Value Then
                        e.Cancel = True
                        MsgBox("More Ship Qty not equal to Detail Order Qty", MsgBoxStyle.Information, "SCM00001 - Summary")
                        Exit Sub
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub Cal_SummaryTotalCtn(ByVal row As Integer, ByVal ordqty As Integer)
        Dim TotalCtn As Long
        Dim master As Integer

        'ordqty = dgSummary.Rows(row).Cells("sod_ordqty").Value
        master = dgSummary.Rows(row).Cells("sod_mtrctn").Value
        If master <> 0 Then
            TotalCtn = ordqty / master
        Else
            TotalCtn = 0
        End If
        dgSummary.Rows(row).Cells("sod_ttlctn").Value = TotalCtn
    End Sub

    Private Sub Cal_SummaryPrcSubTTl(ByVal row As Integer, ByVal basprc As Double, ByVal ordqty As Long)
        Dim selprc As Double
        selprc = basprc * (ordqty)
        dgSummary.Rows(row).Cells("sod_selprc").Value = Format(selprc, "######0.00")

    End Sub

    Private Sub Cal_SummaryPrcNetSelPrc(ByVal row As Integer, ByVal basprc As Double, ByVal ordqty As Long, ByVal MOQChg As Double)
        Dim netselprc As Double
        netselprc = basprc * (1 + Val(MOQChg) / 100)
        dgSummary.Rows(row).Cells("sod_netuntprc").Value = Format(roundup(netselprc), "######0.0000")
    End Sub

    Private Sub dgSummary_RowValidated(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSummary.RowValidated
        If cmdClear.Focused = True Or cmdExit.Focused = True Or rs_SCORDDTL Is Nothing Or initFlag = True Then
            Exit Sub
        End If

        Dim dr_SCORDDTL() As DataRow = rs_SCORDDTL.Tables("RESULT").Select("sod_ordseq = '" & dgSummary.Rows(e.RowIndex).Cells("sod_ordseq").Value & "'")
        If dr_SCORDDTL.Length = 1 Then
            For i As Integer = 0 To dgSummary.Columns.Count - 1
                'dr_SCORDDTL(0).Item(i) = dgSummary.Rows(e.RowIndex).Cells(i).Value
            Next

            recordStatus = True
            'recordStatus_dtl = True
        Else
            MsgBox("Error has occur when altering changes", MsgBoxStyle.Exclamation, "SCM00001 - Summary")
        End If
    End Sub

    Private Sub dgSummary_CellValidated(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSummary.CellValidated
        If sender.Focused = True Then
            recordStatus = True
            recordStatus_dtl = True
        End If

        Select Case e.ColumnIndex
            Case dgSummary_DtyRat
                dgSummary.Rows(e.RowIndex).Cells("sod_dtyrat").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dtyrat").Value, "0.###")
            Case dgSummary_FtyCst
                dgSummary.Rows(e.RowIndex).Cells("sod_ftycst").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_ftycst").Value, "#0.0000")
                dgSummary.Rows(e.RowIndex).Cells("sod_ftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_ftycst").Value + dgSummary.Rows(e.RowIndex).Cells("sod_bomcst").Value, "#0.0000")
            Case dgSummary_BOMCst
                dgSummary.Rows(e.RowIndex).Cells("sod_bomcst").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_bomcst").Value, "#0.0000")
                dgSummary.Rows(e.RowIndex).Cells("sod_ftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_ftycst").Value + dgSummary.Rows(e.RowIndex).Cells("sod_bomcst").Value, "#0.0000")
            Case dgSummary_FtyPrc
                dgSummary.Rows(e.RowIndex).Cells("sod_ftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_ftyprc").Value, "#0.0000")
            Case dgSummary_DVFtyCst
                dgSummary.Rows(e.RowIndex).Cells("sod_dvftycst").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dvftycst").Value, "#0.0000")
                dgSummary.Rows(e.RowIndex).Cells("sod_dvftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dvftycst").Value + dgSummary.Rows(e.RowIndex).Cells("sod_dvbomcst").Value, "#0.0000")
            Case dgSummary_DVBOMCst
                dgSummary.Rows(e.RowIndex).Cells("sod_dvbomcst").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dvbomcst").Value, "#0.0000")
                dgSummary.Rows(e.RowIndex).Cells("sod_dvftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dvftycst").Value + dgSummary.Rows(e.RowIndex).Cells("sod_dvbomcst").Value, "#0.0000")
            Case dgSummary_DVFtyPrc
                dgSummary.Rows(e.RowIndex).Cells("sod_dvftyprc").Value = Format(dgSummary.Rows(e.RowIndex).Cells("sod_dvftyprc").Value, "#0.0000")
        End Select

    End Sub

    'Private Sub dgSummary_CellEndEdit(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSummary.CellEndEdit
    '    recordStatus = True
    '    recordStatus_dtl = True

    '    ''Provoke Cell Validating After Ending Cell Edit
    '    'Dim dc As DataGridViewCell = dgSummary.CurrentCell
    '    'Try
    '    '    dgSummary.CurrentCell = Nothing
    '    'Catch ex As Exception
    '    '    Exit Sub
    '    'End Try
    '    'dgSummary.CurrentCell = dc
    'End Sub

    Private Sub dgSummary_EditingControlShowing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgSummary.EditingControlShowing
        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgSummary.CurrentCell.ColumnIndex
            Case dgSummary_OrdQty, dgSummary_FtyCst, dgSummary_BOMCst, dgSummary_FtyPrc, dgSummary_DVFtyCst, dgSummary_DVBOMCst, dgSummary_DVFtyPrc, dgSummary_DtyRat
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    AddHandler txtbox.KeyPress, AddressOf txt_dgSummary_KeyPress
                    AddHandler txtbox.TextChanged, AddressOf txt_dgSummary_TextChanged
                End If
            Case Else
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_dgSummary_KeyPress
                    RemoveHandler txtbox.TextChanged, AddressOf txt_dgSummary_TextChanged
                End If
        End Select
    End Sub

    Private Sub txt_dgSummary_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        Dim curvalue As String = dgSummary.CurrentCell.EditedFormattedValue
        ' Check Numeric
        Select Case dgSummary.CurrentCell.ColumnIndex
            Case dgSummary_OrdQty
                If Not (e.KeyChar = vbBack Or (e.KeyChar.ToString() >= "0" And e.KeyChar.ToString() <= "9")) Then
                    e.KeyChar = ""
                End If
            Case dgSummary_FtyCst, dgSummary_BOMCst, dgSummary_FtyPrc, dgSummary_DVFtyCst, dgSummary_DVBOMCst, dgSummary_DVFtyPrc, dgSummary_DtyRat
                If Not (e.KeyChar = vbBack Or e.KeyChar.ToString() = "." Or (e.KeyChar.ToString() >= "0" And e.KeyChar.ToString() <= "9")) Then
                    e.KeyChar = ""
                Else
                    If curvalue.IndexOf(".") >= 0 And e.KeyChar.ToString() = "." Then
                        e.KeyChar = ""
                    End If
                End If
        End Select


    End Sub

    Private Sub txt_dgSummary_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim row As Integer = dgSummary.CurrentCell.RowIndex

        If dgSummary.CurrentCell.ColumnIndex = dgSummary_OrdQty Then
            recordStatus = True
            recordStatus_dtl = True
            'If txtOrdQty.Enabled = True And dgSummary.Rows(row).Cells("sod_ordqty").Value.ToString <> "" And dgSummary.Rows(row).Cells("sod_untprc").Value.ToString <> "" Then
            '    Cal_SummaryTotalCtn(row, IIf(sender.Text = "", 0, sender.Text))
            '    Cal_SummaryPrcSubTTl(row, dgSummary.Rows(row).Cells("sod_netuntprc").Value, dgSummary.Rows(row).Cells("sod_ordqty").Value)
            If txtOrdQty.Enabled = True And sender.Text <> "" And dgSummary.Rows(row).Cells("sod_untprc").Value.ToString <> "" Then
                Cal_SummaryTotalCtn(row, IIf(sender.Text = "", 0, sender.Text))
                Cal_SummaryPrcSubTTl(row, dgSummary.Rows(row).Cells("sod_untprc").Value, Integer.Parse(sender.Text))
            Else
                dgSummary.Rows(row).Cells("sod_ttlctn").Value = 0
                Cal_SummaryPrcSubTTl(row, 0, 0)
                Cal_SummaryPrcNetSelPrc(row, 0, 0, 0)
                OrgMOQChg = 0
                dgSummary.Rows(row).Cells("sod_moqchg").Value = 0
                txtMOQChg.Enabled = False
            End If
        End If
    End Sub

    Private Sub loadPanSCCopyCust()
        Dim rs As New DataSet

        gspStr = "sp_select_SYUSRGRP_COMP '','" & gsUsrID & "','SCM00001'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> "0" Then  '*** An error has occured
            MsgBox("Error on loading SCM00001 #121 sp_select_SYUSRGRP_COMP : " & rtnStr)
        Else
            cboPanCopyCustCoCde.Items.Clear()

            For i As Integer = 0 To rs.Tables("RESULT").Rows.Count - 1
                If gsCompanyGroup = "UCG" Then
                    If rs.Tables("RESULT").Rows(i)("yuc_cocde").ToString <> "MS" Then
                        cboPanCopyCustCoCde.Items.Add(rs.Tables("RESULT").Rows(i)("yuc_cocde").ToString)
                    End If
                Else
                    If rs.Tables("RESULT").Rows(i)("yuc_cocde").ToString = "MS" Then
                        cboPanCopyCustCoCde.Items.Add(rs.Tables("RESULT").Rows(i)("yuc_cocde").ToString)
                    End If
                End If
            Next
        End If

        display_combo(cboCoCde.Text, cboPanCopyCustCoCde)
        display_combo(cboPriCust.Text, cboPanCopyCustPriCust)
        display_combo(cboSecCust.Text, cboPanCopyCustSecCust)

        'txtPanCopyCustCustPODat.Text = Format(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_cpodat"), "MM/dd/yyyy")
        txtPanCopyCustCustPODat.Text = "  /  /"
        txtPanCopyCustStartShipDat.Text = "  /  /"
        txtPanCopyCustEndShipDat.Text = "  /  /"
        txtPanCopyCustCancelDat.Text = "  /  /"
    End Sub

    Private Sub cmdPanCopyCustCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCopy_CustCancel.Click
        release_TabControl()
        grpHeader.Enabled = True
        panSCCopyCust.Visible = False
    End Sub

    Private Sub cmdPanCopyCustOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCopy_CustOK.Click
        If txtPanCopyCustCustPODat.Text = "  /  /" Then
            MsgBox("Customer PO Date must not be empty")
            Exit Sub
        End If

        If txtPanCopyCustStartShipDat.Text = "  /  /" Then
            MsgBox("Start Ship Date must not be empty")
            Exit Sub
        End If

        If txtPanCopyCustEndShipDat.Text = "  /  /" Then
            MsgBox("End Ship Date must not be empty")
            Exit Sub
        End If

        panSCCopyCust.Visible = False
        panSCCopy.Width = 660
        panSCCopy.Height = 424
        panSCCopy.Location = New Point(170, 120)
        panSCCopy.Visible = True
        loadPanSCCopy()
    End Sub

    Private Sub cboPanCopyCustCoCde_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPanCopyCustCoCde.SelectedIndexChanged
        gsCompany = cboCoCde.Text
        Update_gs_Value(gsCompany)

        gspStr = "sp_select_CUBASINF_PRI '" & cboPanCopyCustCoCde.Text & "','" & gsUsrID & "','" & strModule & "'"
        rs_CUBASINF_PRI = Nothing

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_PRI, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #122 sp_select_CUBASINF_PRI : " & rtnStr)
            Exit Sub
        Else
            fillcboPanSCCopyCustPriCust()
            cboPanCopyCustSecCust.Items.Clear()
            cboPanCopyCustSecCust.Text = ""
        End If
    End Sub

    Private Sub fillcboPanSCCopyCustPriCust()
        Dim dr() As DataRow = rs_CUBASINF_PRI.Tables("RESULT").Select("cbi_cusno >= '50000'")

        If dr.Length > 0 Then
            cboPanCopyCustPriCust.Text = ""
            cboPanCopyCustPriCust.Items.Clear()

            For i As Integer = 0 To dr.Length - 1
                cboPanCopyCustPriCust.Items.Add(dr(i).Item("cbi_cusno") & " - " & dr(i).Item("cbi_cussna"))
            Next
        End If


        cboPanCopyCustPriCust.SelectedIndex = -1
    End Sub

    Private Sub cboPanCopyCustPriCust_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboPanCopyCustPriCust.SelectedIndexChanged
        Dim rs_CUBASINF_SecCust As DataSet
        gspStr = "sp_select_CUBASINF_SC '" & cboCoCde.Text & "','" & Split(cboPanCopyCustPriCust.Text, " - ")(0) & "','Secondary'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_CUBASINF_SecCust, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
            MsgBox("Error on loading SCM00001 #123 sp_select_CUBASINF_SC : " & rtnStr)
        Else
            If rs_CUBASINF_SecCust.Tables("RESULT").Rows.Count = 0 Then       '***  Not Found Record
                cboPanCopyCustSecCust.Text = ""
                SetComboStatus(cboPanCopyCustSecCust, "Disable")
            Else
                SetComboStatus(cboPanCopyCustSecCust, "Enable")
                cboPanCopyCustSecCust.Items.Clear()

                cboPanCopyCustSecCust.Items.Add("")
                For i As Integer = 0 To rs_CUBASINF_SecCust.Tables("RESULT").Rows.Count - 1
                    cboPanCopyCustSecCust.Items.Add(rs_CUBASINF_SecCust.Tables("RESULT").Rows(i)("csc_seccus").ToString & " - " & rs_CUBASINF_SecCust.Tables("RESULT").Rows(i)("cbi_cussna").ToString)
                Next
            End If
        End If
    End Sub

    Private Sub cmdPanSCCopyCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanSCCopyCancel.Click
        release_TabControl()
        grpHeader.Enabled = True
        panSCCopy.Visible = False
    End Sub

    Private Sub cmdPanSCCopyCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanSCCopyCopy.Click
        rs_SCDISPRM_D_copy = rs_SCDISPRM_D.Copy
        rs_SCDISPRM_P_copy = rs_SCDISPRM_P.Copy
        rs_SCSHPMRK_copy = rs_SCSHPMRK.Copy

        For i As Integer = 0 To rs_SCDISPRM_D_copy.Tables("RESULT").Rows.Count - 1
            rs_SCDISPRM_D_copy.Tables("RESULT").Rows(i)("sdp_ordno") = ""
            rs_SCDISPRM_D_copy.Tables("RESULT").Rows(i)("sdp_creusr") = "~*ADD*~"
        Next

        For i As Integer = 0 To rs_SCDISPRM_P_copy.Tables("RESULT").Rows.Count - 1
            rs_SCDISPRM_P_copy.Tables("RESULT").Rows(i)("sdp_ordno") = ""
            rs_SCDISPRM_P_copy.Tables("RESULT").Rows(i)("sdp_creusr") = "~*ADD*~"
        Next

        For i As Integer = 0 To rs_SCSHPMRK_copy.Tables("RESULT").Rows.Count - 1
            rs_SCSHPMRK_copy.Tables("RESULT").Rows(i)("ssm_creusr") = "~*ADD*~"
        Next

        'Dim ShpStrDat As String = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpstr")), "MM/dd/yyyy")
        'Dim ShpEndDat As String = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_shpend")), "MM/dd/yyyy")
        'Dim CanDat As String
        'If Trim(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat").ToString) = "/  /" Then
        '    CanDat = "  /  /"
        'Else
        '    If IsDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")) Then
        '        CanDat = Format(CDate(rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_candat")), "MM/dd/yyyy")
        '    Else
        '        CanDat = "  /  /"
        '    End If
        'End If

        cmdPanSCCopyCancel.PerformClick()

        setStatus("Clear")

        addFlag = True

        display_combo(cboPanCopyCustCoCde.Text, cboCoCde)
        gspStr = "sp_select_CUBASINF_PRI '" & cboCoCde.Text & "','" & gsUsrID & "','" & strModule & "'"

        'Fixing global company code problem at 20100420
        gsCompany = Trim(cboCoCde.Text)
        Update_gs_Value(gsCompany)

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        gspStr = ""
        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
            MsgBox("Error on loading SCM00001 #131 sp_select_CUBASINF_PRI : " & rtnStr)
            Exit Sub
        Else
            rs_CUBASINF_P = rs.Copy()
        End If

        fillcboPriCust()

        setStatus("ADD")

        'display_combo("ACT", cboSCStatus)
        'rs_SCORDHDR.Tables("RESULT").Rows(0)("soh_ordsts") = "ACT"

        display_combo(cboPanCopyCustPriCust.Text, cboPriCust)
        display_combo(cboPanCopyCustSecCust.Text, cboSecCust)



        ' Update Currency Exchange Rate
        Dim dblRate As Double
        Dim strDate As String = ""

        Dim drCust_P As DataRow() = rs_CUBASINF_P.Tables("RESULT").Select("cbi_cusno = '" & Split(cboPriCust.Text, " - ")(0) & "'")
        dblRate = GetSelRat(drCust_P(0).Item("cpi_curcde"), "USD", strDate)
        strCurExRat = CStr(dblRate)
        strCurExEffDat = Format(CDate(strDate), "yyyy-MM-dd")

        'hdr_ShpStrDat = ShpStrDat
        'hdr_ShpEndDat = ShpEndDat
        'hdr_CanDat = CanDat

        hdr_ShpStrDat = txtPanCopyCustStartShipDat.Text
        hdr_ShpEndDat = txtPanCopyCustEndShipDat.Text
        hdr_CanDat = txtPanCopyCustCancelDat.Text

        txtCustPoDat.Text = txtPanCopyCustCustPODat.Text
        hdr_CustPODat = txtCustPoDat.Text
        CustPODat_ori = hdr_CustPODat
        txtStartShipDat.Text = hdr_ShpStrDat
        txtEndShipDat.Text = hdr_ShpEndDat
        txtCancelDat.Text = hdr_CanDat

        rs_SCORDDTL = rs_SCORDDTL_copyOK.Copy()
        rs_SCASSINF = rs_SCASSINF_copy.Copy()
        rs_SCBOMINF = rs_SCBOMINF_copy.Copy()
        rs_SCCPTBKD = rs_SCCPTBKD_copy.Copy()
        rs_SCDISPRM_D = rs_SCDISPRM_D_copy.Copy()
        rs_SCDISPRM_P = rs_SCDISPRM_P_copy.Copy()
        rs_SCSHPMRK = rs_SCSHPMRK_copy.Copy()

        Cal_TotalAmt()

        currentRow = 0
        'currentOrdSeq = 1
        currentOrdSeq = rs_SCORDDTL.Tables("RESULT").Rows(0)("sod_ordseq")
        MaxSeq = rs_SCORDDTL.Tables("RESULT").Rows.Count

        dv_dis = rs_SCDISPRM_D.Tables("RESULT").DefaultView
        grdDis.DataSource = dv_dis
        Display_Dis()

        dv_pre = rs_SCDISPRM_P.Tables("RESULT").DefaultView
        grdPre.DataSource = dv_pre
        Display_pre()

        recordMove("LOAD")

        copyFlag = True
        recordStatus = True
        recordStatus_dtl = True
    End Sub

    Private Sub loadPanSCCopy()
        totalR = rs_SCORDDTL_ori.Tables("RESULT").Rows.Count
        pBarPanSCCopy.Maximum = totalR
        totalCopy = 0
        totalFail = 0
        lblCount.Text = totalCopy & " of " & totalR
        lblFail.Text = totalFail & " of " & totalR
        pBarPanSCCopy.Value = 0
        cmdPanSCCopyCopy.Enabled = False
        rs_SCORDDTL_copyOK = rs_SCORDDTL_ori.Clone()
        rs_SCORDDTL_copyFail = rs_SCORDDTL_ori.Clone()
        rs_SCASSINF_copy = rs_SCASSINF_ori.Clone()
        rs_SCBOMINF_copy = rs_SCBOMINF_OLD.Clone()
        rs_SCCPTBKD_copy = rs_SCCPTBKD_ori.Clone()
        rs_SCDISPRM_D_copy = rs_SCDISPRM_D.Clone()
        rs_SCDISPRM_P_copy = rs_SCDISPRM_P.Clone()
        rs_SCSHPMRK_copy = rs_SCSHPMRK.Clone()
        check_CopySC()
    End Sub

    Private Sub check_CopySC()
        Dim rsCUITMPRC As DataSet
        Dim rsIMBOMASS As DataSet
        Dim rsIMBOMINF As New DataSet
        Dim rsIMXChk As DataSet
        Dim rsQUCPTBKD As DataSet
        Dim newRow As DataRow
        Dim dr_CUITMPRC_Copy() As DataRow
        Dim dr_SCASSINF_Copy() As DataRow

        Dim copyNotLatest As Integer = 0
        Dim copyOrdSeq As Integer = 1
        Dim tmp_SCASSINF_count As Integer

        For i As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Rows.Count - 1
            gspStr = "sp_select_CUITMPRC_SC_Copy '" & cboPanCopyCustCoCde.Text & "','" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_itmno").ToString & _
                     "','" & Split(cboPanCopyCustPriCust.Text, " - ")(0) & "','" & Split(cboPanCopyCustSecCust.Text, " - ")(0) & "','" & _
                     txtPanCopyCustCustPODat.Text & " 23:59'"
            rsCUITMPRC = Nothing
            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rsCUITMPRC, rtnStr)
            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #124 sp_select_CUITMPRC_SC_Copy : " & rtnStr)
            End If

            newRow = Nothing
            If rsCUITMPRC.Tables("RESULT").Rows.Count = 0 Then
                totalFail += 1
                newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                    newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                Next
                newRow.Item("sod_coldsc") = "No valid record exists in CIH"
                rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                rs_SCORDDTL_copyFail.AcceptChanges()
            Else
                dr_CUITMPRC_Copy = Nothing
                dr_CUITMPRC_Copy = rsCUITMPRC.Tables("RESULT").Select("cis_colcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_colcde") & "' and " & _
                                                                 "cis_untcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_pckunt") & "' and " & _
                                                                 "cis_inrqty = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_inrctn") & "' and " & _
                                                                 "cis_mtrqty = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_mtrctn") & "' and " & _
                                                                 "cis_colcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_colcde") & "' and " & _
                                                                 "cis_cft = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_cft") & "' and " & _
                                                                 "cis_cbm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_cbm") & "' and " & _
                                                                 "cip_ftyprctrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ftyprctrm") & "' and " & _
                                                                 "cip_hkprctrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_hkprctrm") & "' and " & _
                                                                 "cip_trantrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_trantrm") & "'")
                If dr_CUITMPRC_Copy.Length = 0 Then
                    totalFail += 1
                    newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Record does not exist in CIH"
                    rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_copyFail.AcceptChanges()
                ElseIf dr_CUITMPRC_Copy(0).Item("ibi_itmsts").ToString.Substring(0, 3) = "OLD" Then
                    totalFail += 1
                    newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "OLD item status"
                    rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_copyFail.AcceptChanges()
                ElseIf (dr_CUITMPRC_Copy(0).Item("ibi_itmsts").ToString.Substring(0, 3) <> "CMP" And dr_CUITMPRC_Copy(0).Item("ibi_itmsts").ToString.Substring(0, 3) <> "INC") Then
                    totalFail += 1
                    newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Item not in Active Status"
                    rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_copyFail.AcceptChanges()
                ElseIf dr_CUITMPRC_Copy(0).Item("vbi_vensts").ToString <> "A" Then
                    totalFail += 1
                    newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Default Vendor not in Active status"
                    rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_copyFail.AcceptChanges()
                ElseIf check_CopyAssorted(dr_CUITMPRC_Copy(0).Item("cis_itmno")) = False Then
                    totalFail += 1
                    newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Assorted Item not match with Item Master"
                    rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_copyFail.AcceptChanges()
                Else
                    gspStr = "sp_select_IMXChk '" & cboPanCopyCustCoCde.Text & "','" & Split(cboPanCopyCustPriCust.Text, " - ")(0) & "','" & _
                             dr_CUITMPRC_Copy(0).Item("cis_colcde") & "','" & dr_CUITMPRC_Copy(0).Item("cis_itmno") & "'"
                    rsIMXChk = Nothing
                    Me.Cursor = Windows.Forms.Cursors.WaitCursor
                    rtnLong = execute_SQLStatement(gspStr, rsIMXChk, rtnStr)
                    Me.Cursor = Windows.Forms.Cursors.Default
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on loading SCM00001 #125 sp_select_IMXChk : " & rtnStr)
                        Exit Sub
                    End If

                    If rsIMXChk.Tables("RESULT").Rows.Count = 0 Then
                        totalFail += 1
                        newRow = rs_SCORDDTL_copyFail.Tables("RESULT").NewRow
                        For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                            newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                        Next
                        newRow.Item("sod_coldsc") = "Item cannot be used in this Company! Customer and Compnay Relation Missing."
                        rs_SCORDDTL_copyFail.Tables("RESULT").Rows.Add(newRow)
                        rs_SCORDDTL_copyFail.AcceptChanges()
                    Else
                        totalCopy += 1
                        If dr_CUITMPRC_Copy(0).Item("cip_latest") = "N" Then
                            copyNotLatest += 1
                        End If

                        newRow = rs_SCORDDTL_copyOK.Tables("RESULT").NewRow

                        newRow.Item("sod_cocde") = dr_CUITMPRC_Copy(0).Item("cis_contopc") ' Used to do Conv to PC Checking
                        newRow.Item("sod_ordno") = ""
                        newRow.Item("sod_ordseq") = copyOrdSeq
                        newRow.Item("sod_updpo") = "Y"
                        newRow.Item("sod_chgfty") = "N"
                        newRow.Item("sod_cvname") = dr_CUITMPRC_Copy(0).Item("vbi_cvname")
                        newRow.Item("sod_subcde") = ""
                        newRow.Item("sod_pvname") = dr_CUITMPRC_Copy(0).Item("vbi_pvname")
                        newRow.Item("sod_cussub") = ""
                        newRow.Item("sod_tvname") = dr_CUITMPRC_Copy(0).Item("vbi_tvname")
                        newRow.Item("sod_evname") = dr_CUITMPRC_Copy(0).Item("vbi_evname")
                        newRow.Item("pod_purord") = ""
                        newRow.Item("pod_jobord") = ""
                        newRow.Item("sod_runno") = ""
                        newRow.Item("sod_pjobno") = ""
                        newRow.Item("sod_itmno") = dr_CUITMPRC_Copy(0).Item("cis_itmno")
                        newRow.Item("sod_cusstyno") = dr_CUITMPRC_Copy(0).Item("cis_cusstyno")
                        newRow.Item("sod_cusitm") = dr_CUITMPRC_Copy(0).Item("cis_cusitm")
                        newRow.Item("sod_cussku") = dr_CUITMPRC_Copy(0).Item("cis_cussku")
                        newRow.Item("sod_seccusitm") = ""
                        newRow.Item("ibi_itmsts") = dr_CUITMPRC_Copy(0).Item("ibi_itmsts")
                        newRow.Item("h_ibi_itmsts") = "N/A"
                        newRow.Item("sod_itmtyp") = dr_CUITMPRC_Copy(0).Item("ibi_typ")
                        newRow.Item("sod_itmdsc") = dr_CUITMPRC_Copy(0).Item("cis_itmdsc")
                        newRow.Item("sod_cuscol") = dr_CUITMPRC_Copy(0).Item("cis_cuscol")
                        newRow.Item("sod_colpck") = dr_CUITMPRC_Copy(0).Item("cis_colpck")
                        newRow.Item("sod_colcde") = dr_CUITMPRC_Copy(0).Item("cis_colcde")
                        newRow.Item("sod_pckunt") = dr_CUITMPRC_Copy(0).Item("cis_untcde")
                        newRow.Item("sod_inrctn") = dr_CUITMPRC_Copy(0).Item("cis_inrqty")
                        newRow.Item("sod_mtrctn") = dr_CUITMPRC_Copy(0).Item("cis_mtrqty")
                        newRow.Item("sod_cft") = dr_CUITMPRC_Copy(0).Item("cis_cft")
                        newRow.Item("sod_cbm") = dr_CUITMPRC_Copy(0).Item("cis_cbm")
                        newRow.Item("sod_ftyprctrm") = dr_CUITMPRC_Copy(0).Item("cip_ftyprctrm")
                        newRow.Item("sod_hkprctrm") = dr_CUITMPRC_Copy(0).Item("cip_hkprctrm")
                        newRow.Item("sod_trantrm") = dr_CUITMPRC_Copy(0).Item("cip_trantrm")
                        newRow.Item("sod_cus1no") = dr_CUITMPRC_Copy(0).Item("cip_cus1no")
                        newRow.Item("sod_cus2no") = dr_CUITMPRC_Copy(0).Item("cip_cus2no")
                        If dr_CUITMPRC_Copy(0).Item("cip_cus1no") = "" Then
                            newRow.Item("sod_prcgrp") = "STANDARD"
                        Else
                            If dr_CUITMPRC_Copy(0).Item("cip_cus2no") = "" Then
                                newRow.Item("sod_prcgrp") = dr_CUITMPRC_Copy(0).Item("cip_cus1no")
                            Else
                                newRow.Item("sod_prcgrp") = dr_CUITMPRC_Copy(0).Item("cip_cus1no") & " / " & dr_CUITMPRC_Copy(0).Item("cip_cus2no")
                            End If
                        End If
						newRow.Item("sod_effcpo") = dr_CUITMPRC_Copy(0).Item("cip_effcpo")
                        newRow.Item("sod_effdat") = dr_CUITMPRC_Copy(0).Item("cip_effdat")
                        newRow.Item("sod_expdat") = dr_CUITMPRC_Copy(0).Item("cip_expdat")
                        newRow.Item("sod_pckitr") = dr_CUITMPRC_Copy(0).Item("cis_pckitr")
                        newRow.Item("sod_coldsc") = dr_CUITMPRC_Copy(0).Item("cis_coldsc")
                        newRow.Item("sod_pckseq") = 0
                        newRow.Item("sod_qutno") = dr_CUITMPRC_Copy(0).Item("cis_refdoc")
                        newRow.Item("sod_refdat") = dr_CUITMPRC_Copy(0).Item("cis_docdat")
                        newRow.Item("sod_resppo") = ""
                        newRow.Item("sod_cuspo") = ""
                        newRow.Item("sod_ordqty") = rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty")
                        newRow.Item("sod_shpqty") = 0
                        newRow.Item("sod_outqty") = rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty")
                        newRow.Item("sod_discnt") = 0
                        newRow.Item("sod_oneprc") = "N"
                        newRow.Item("sod_curcde") = dr_CUITMPRC_Copy(0).Item("cip_curcde")
                        newRow.Item("sod_moqchg") = 0
                        newRow.Item("sod_netuntprc") = Format(dr_CUITMPRC_Copy(0).Item("cis_selprc") * (1 + newRow.Item("sod_moqchg") / 100), "######0.0000")
                        newRow.Item("sod_untprc") = dr_CUITMPRC_Copy(0).Item("cis_selprc")
                        newRow.Item("sod_orgunt") = dr_CUITMPRC_Copy(0).Item("cis_selprc")
                        'newRow.Item("sod_itmprc") = dr_CUITMPRC_Copy(0).Item("cip_basprc")
                        If dr_CUITMPRC_Copy(0).Item("cip_minprc") > 0 And dr_CUITMPRC_Copy(0).Item("cip_minprc") <> dr_CUITMPRC_Copy(0).Item("cip_basprc") Then
                            newRow.Item("sod_itmprc") = dr_CUITMPRC_Copy(0).Item("cip_minprc")
                        Else
                            newRow.Item("sod_itmprc") = dr_CUITMPRC_Copy(0).Item("cip_basprc")
                        End If
                        newRow.Item("sod_basprc") = dr_CUITMPRC_Copy(0).Item("cip_basprc")
                        newRow.Item("sod_inrdin") = dr_CUITMPRC_Copy(0).Item("cis_inrdin")
                        newRow.Item("sod_inrwin") = dr_CUITMPRC_Copy(0).Item("cis_inrwin")
                        newRow.Item("sod_inrhin") = dr_CUITMPRC_Copy(0).Item("cis_inrhin")
                        newRow.Item("sod_mtrdin") = dr_CUITMPRC_Copy(0).Item("cis_mtrdin")
                        newRow.Item("sod_mtrwin") = dr_CUITMPRC_Copy(0).Item("cis_mtrwin")
                        newRow.Item("sod_mtrhin") = dr_CUITMPRC_Copy(0).Item("cis_mtrhin")
                        newRow.Item("sod_inrdcm") = dr_CUITMPRC_Copy(0).Item("cis_inrdcm")
                        newRow.Item("sod_inrwcm") = dr_CUITMPRC_Copy(0).Item("cis_inrwcm")
                        newRow.Item("sod_inrhcm") = dr_CUITMPRC_Copy(0).Item("cis_inrhcm")
                        newRow.Item("sod_mtrdcm") = dr_CUITMPRC_Copy(0).Item("cis_mtrdcm")
                        newRow.Item("sod_mtrwcm") = dr_CUITMPRC_Copy(0).Item("cis_mtrwcm")
                        newRow.Item("sod_mtrhcm") = dr_CUITMPRC_Copy(0).Item("cis_mtrhcm")
                        newRow.Item("sod_ctnstr") = 0
                        newRow.Item("sod_ctnend") = 0
                        newRow.Item("sod_ttlctn") = Integer.Parse(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty") / dr_CUITMPRC_Copy(0).Item("cis_mtrqty"))
                        newRow.Item("sod_tirtyp") = dr_CUITMPRC_Copy(0).Item("cis_tirtyp")
                        newRow.Item("sod_moq") = dr_CUITMPRC_Copy(0).Item("cis_moq")
                        newRow.Item("sod_moqunttyp") = dr_CUITMPRC_Copy(0).Item("cis_moqunttyp")
                        newRow.Item("sod_selprc") = Format(dr_CUITMPRC_Copy(0).Item("cis_selprc") * rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty"), "######0.0000")
                        newRow.Item("sod_moa") = dr_CUITMPRC_Copy(0).Item("cis_moa")
                        newRow.Item("sod_rmk") = ""
                        newRow.Item("sod_pormk") = ""
                        newRow.Item("sod_dv") = dr_CUITMPRC_Copy(0).Item("cip_venno")
                        newRow.Item("sod_venno") = dr_CUITMPRC_Copy(0).Item("cip_prdven")
                        newRow.Item("sod_cusven") = dr_CUITMPRC_Copy(0).Item("cis_cusven")
                        newRow.Item("sod_tradeven") = dr_CUITMPRC_Copy(0).Item("cis_tradeven")
                        newRow.Item("sod_examven") = dr_CUITMPRC_Copy(0).Item("cis_examven")
                        newRow.Item("sod_purord") = ""
                        newRow.Item("sod_oldpurord") = ""
                        newRow.Item("sod_purseq") = 0
                        newRow.Item("sod_venitm") = dr_CUITMPRC_Copy(0).Item("ivi_venitm")
                        newRow.Item("sod_clmno") = ""
                        newRow.Item("sod_itmsts") = Split(dr_CUITMPRC_Copy(0).Item("ibi_itmsts"), " - ")(0)
                        newRow.Item("sod_apprve") = "N"
                        'newRow.Item("sod_shpstr") = Format(Date.Now, "MM/dd/yyyy")
                        'newRow.Item("sod_shpend") = Format(Date.Now, "MM/dd/yyyy")
                        'newRow.Item("sod_candat") = Format(Date.Now, "MM/dd/yyyy")
                        newRow.Item("sod_shpstr") = txtPanCopyCustStartShipDat.Text
                        newRow.Item("sod_shpend") = txtPanCopyCustEndShipDat.Text
                        newRow.Item("sod_candat") = txtPanCopyCustCancelDat.Text
                        newRow.Item("sod_posstr") = ""
                        newRow.Item("sod_posend") = ""
                        newRow.Item("sod_poscan") = ""
                        newRow.Item("sod_fcurcde") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                        'newRow.Item("sod_ftycst") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                        'newRow.Item("sod_bomcst") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                        'newRow.Item("sod_ftyprc") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                        newRow.Item("sod_ftycst") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                        newRow.Item("sod_bomcst") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                        newRow.Item("sod_ftyprc") = Format(dr_CUITMPRC_Copy(0).Item("cip_ftyprc") + dr_CUITMPRC_Copy(0).Item("cip_bomcst"), "#0.0000")
                        newRow.Item("sod_orgfty") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                        newRow.Item("sod_ftyunt") = dr_CUITMPRC_Copy(0).Item("cis_untcde")
                        'newRow.Item("sod_ftycst_org") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                        'newRow.Item("sod_bomcst_org") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                        'newRow.Item("sod_ftyprc_org") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                        newRow.Item("sod_ftycst_org") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                        newRow.Item("sod_bomcst_org") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                        newRow.Item("sod_ftyprc_org") = Format(dr_CUITMPRC_Copy(0).Item("cip_ftyprc") + dr_CUITMPRC_Copy(0).Item("cip_bomcst"), "#0.0000")
                        If dr_CUITMPRC_Copy(0).Item("cis_itmventyp") = "E" Then
                            newRow.Item("sod_dvfcurcde") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                            newRow.Item("sod_dvftycst") = "9999.0000"
                            newRow.Item("sod_dvbomcst") = "9999.0000"
                            newRow.Item("sod_dvftyprc") = "9999.0000"
                            newRow.Item("sod_dvftyunt") = dr_CUITMPRC_Copy(0).Item("cis_untcde")
                            newRow.Item("sod_dvftycst_org") = "9999.0000"
                            newRow.Item("sod_dvbomcst_org") = "9999.0000"
                            newRow.Item("sod_dvftyprc_org") = "9999.0000"
                            newRow.Item("sod_itmcstcur") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                            'newRow.Item("sod_dvitmcst") = "9999.0000"
                            newRow.Item("sod_dvitmcst") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                        Else
                            newRow.Item("sod_dvfcurcde") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                            'newRow.Item("sod_dvftycst") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                            'newRow.Item("sod_dvbomcst") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                            'newRow.Item("sod_dvftyprc") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                            newRow.Item("sod_dvftycst") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                            newRow.Item("sod_dvbomcst") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                            newRow.Item("sod_dvftyprc") = Format(dr_CUITMPRC_Copy(0).Item("cip_ftyprc") + dr_CUITMPRC_Copy(0).Item("cip_bomcst"), "#0.0000")
                            newRow.Item("sod_dvftyunt") = dr_CUITMPRC_Copy(0).Item("cis_untcde")
                            'newRow.Item("sod_dvftycst_org") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                            'newRow.Item("sod_dvbomcst_org") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                            'newRow.Item("sod_dvftyprc_org") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                            newRow.Item("sod_dvftycst_org") = dr_CUITMPRC_Copy(0).Item("cip_ftyprc")
                            newRow.Item("sod_dvbomcst_org") = dr_CUITMPRC_Copy(0).Item("cip_bomcst")
                            newRow.Item("sod_dvftyprc_org") = Format(dr_CUITMPRC_Copy(0).Item("cip_ftyprc") + dr_CUITMPRC_Copy(0).Item("cip_bomcst"), "#0.0000")
                            newRow.Item("sod_itmcstcur") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                            newRow.Item("sod_dvitmcst") = dr_CUITMPRC_Copy(0).Item("cip_ftycst")
                        End If
                        newRow.Item("sod_hrmcde") = dr_CUITMPRC_Copy(0).Item("cis_hrmcde")
                        newRow.Item("sod_dtyrat") = Format(dr_CUITMPRC_Copy(0).Item("cis_dtyrat"), "0.###")
                        newRow.Item("sod_dept") = dr_CUITMPRC_Copy(0).Item("cis_dept")
                        newRow.Item("sod_typcode") = dr_CUITMPRC_Copy(0).Item("cis_typcode")
                        newRow.Item("sod_code1") = dr_CUITMPRC_Copy(0).Item("cis_code1")
                        newRow.Item("sod_code2") = dr_CUITMPRC_Copy(0).Item("cis_code2")
                        newRow.Item("sod_code3") = dr_CUITMPRC_Copy(0).Item("cis_code3")
                        newRow.Item("sod_cususdcur") = dr_CUITMPRC_Copy(0).Item("cis_cususdcur")
                        newRow.Item("sod_cususd") = dr_CUITMPRC_Copy(0).Item("cis_cususd")
                        newRow.Item("sod_cuscadcur") = dr_CUITMPRC_Copy(0).Item("cis_cuscadcur")
                        newRow.Item("sod_cuscad") = dr_CUITMPRC_Copy(0).Item("cis_cuscad")
                        newRow.Item("sod_alsitmno") = dr_CUITMPRC_Copy(0).Item("ibi_alsitmno")
                        newRow.Item("sod_alscolcde") = dr_CUITMPRC_Copy(0).Item("ibi_alscolcde")
                        newRow.Item("sod_conftr") = dr_CUITMPRC_Copy(0).Item("cis_conftr")
                        newRow.Item("sod_contopc") = dr_CUITMPRC_Copy(0).Item("cis_contopc")
                        newRow.Item("sod_pcprc") = Format(dr_CUITMPRC_Copy(0).Item("cis_selprc") / dr_CUITMPRC_Copy(0).Item("cis_conftr"), "######0.0000")
                        newRow.Item("sod_custum") = ""
                        newRow.Item("sod_invqty") = 0
                        newRow.Item("sod_orgmoqchg") = 0

                        ' Check Customer MOQ Charge
                        gspStr = "sp_select_CUPRCINF '" & cboCoCde.Text & "','" & Split(cboPanCopyCustPriCust.Text, " - ")(0) & "'"
                        rs = Nothing
                        Me.Cursor = Windows.Forms.Cursors.WaitCursor
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                        Me.Cursor = Windows.Forms.Cursors.Default
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SCM00001 #126 sp_select_CUPRCINF : " & rtnStr)
                            Exit Sub
                        Else
                            If rs.Tables("RESULT").Rows.Count > 0 Then
                                If rs.Tables("RESULT").Rows(0)("cpi_moqchgflg") = "Y" And dr_CUITMPRC_Copy(0).Item("cis_tirtyp").ToString = "1" Then
                                    newRow.Item("sod_cusmoqchg") = "Y"
                                Else
                                    newRow.Item("sod_cusmoqchg") = "N"
                                End If
                            Else
                                newRow.Item("sod_cusmoqchg") = "N"
                            End If
                        End If

                        ' Check Vendor MOQ Charge
                        gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & dr_CUITMPRC_Copy(0).Item("cip_prdven") & "'"
                        rs = Nothing
                        Me.Cursor = Windows.Forms.Cursors.WaitCursor
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                        Me.Cursor = Windows.Forms.Cursors.Default
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SCM00001 #127 sp_select_VNBASINF : " & rtnStr)
                            Exit Sub
                        End If

                        If rs.Tables("RESULT").Rows.Count > 0 Then
                            If rs.Tables("RESULT").Rows(0)("vbi_moqchg") = "Y" Then
                                newRow.Item("sod_venmoqchg") = "Y"
                            Else
                                newRow.Item("sod_venmoqchg") = "N"
                            End If
                        Else
                            newRow.Item("sod_venmoqchg") = "N"
                        End If

                        newRow.Item("sod_orgvenno") = dr_CUITMPRC_Copy(0).Item("cip_prdven")
                        newRow.Item("sod_ztnvbeln") = ""
                        newRow.Item("sod_ztnposnr") = ""
                        newRow.Item("sod_zorvbeln") = ""
                        newRow.Item("sod_zorposnr") = ""
                        newRow.Item("sod_qutdat") = dr_CUITMPRC_Copy(0).Item("cip_qutdat")
                        newRow.Item("sod_imqutdat") = dr_CUITMPRC_Copy(0).Item("cip_imqutdat")
                        newRow.Item("sod_imqutdat_org") = dr_CUITMPRC_Copy(0).Item("cip_imqutdat")
                        newRow.Item("sod_imqutdatchg") = "N"
                        newRow.Item("sod_venno_org") = dr_CUITMPRC_Copy(0).Item("cip_prdven")
                        newRow.Item("sod_fcurcde_org") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                        newRow.Item("sod_dvfcurcde_org") = dr_CUITMPRC_Copy(0).Item("cip_fcurcde")
                        newRow.Item("sod_year") = dr_CUITMPRC_Copy(0).Item("cis_year")
                        newRow.Item("sod_season") = dr_CUITMPRC_Copy(0).Item("cis_season")
                        newRow.Item("sod_tordno") = ""
                        newRow.Item("sod_tordseq") = ""
                        newRow.Item("sod_creusr") = "~*ADD*~"

                        ' Check for Assortment
                        If newRow.Item("sod_itmtyp") = "ASS" Then
                            gspStr = "sp_select_IMBOMASS_SC '" & cboPanCopyCustCoCde.Text & "','" & newRow.Item("sod_itmno") & "','" & _
                                     Split(cboPanCopyCustPriCust.Text, " - ")(0) & "'"
                            rsIMBOMASS = Nothing
                            Me.Cursor = Windows.Forms.Cursors.WaitCursor
                            rtnLong = execute_SQLStatement(gspStr, rsIMBOMASS, rtnStr)
                            Me.Cursor = Windows.Forms.Cursors.Default
                            If rtnLong <> RC_SUCCESS Then
                                MsgBox("Error on loading SCM00001 #128 sp_select_IMBOMASS_SC : " & rtnStr)
                            End If

                            newRow.Item("sod_assitmcount") = rsIMBOMASS.Tables("RESULT").Rows.Count
                            'If rsIMBOMASS.Tables("RESULT").Rows.Count > 0 Then
                            '    Dim newAssorted As DataRow
                            '    For j As Integer = 0 To rsIMBOMASS.Tables("RESULT").Rows.Count - 1
                            '        newAssorted = Nothing
                            '        newAssorted = rs_SCASSINF_copy.Tables("RESULT").NewRow
                            '        newAssorted.Item("sai_ordno") = ""
                            '        newAssorted.Item("sai_ordseq") = copyOrdSeq
                            '        newAssorted.Item("sai_itmno") = newRow.Item("sod_itmno")
                            '        newAssorted.Item("sai_assitm") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_assitm")
                            '        newAssorted.Item("sai_assdsc") = rsIMBOMASS.Tables("RESULT").Rows(j)("ibi_engdsc")
                            '        newAssorted.Item("sai_colcde") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_colcde")
                            '        newAssorted.Item("sai_coldsc") = rsIMBOMASS.Tables("RESULT").Rows(j)("icf_coldsc")
                            '        newAssorted.Item("sai_untcde") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_pckunt")
                            '        newAssorted.Item("sai_inrqty") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_inrqty")
                            '        newAssorted.Item("sai_mtrqty") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_mtrqty")
                            '        newAssorted.Item("sai_imperiod") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_period")
                            '        newAssorted.Item("sai_cusrtl") = 0
                            '        newAssorted.Item("sai_cusstyno") = rsIMBOMASS.Tables("RESULT").Rows(j)("ics_cusstyno")
                            '        newAssorted.Item("sai_tordno") = ""
                            '        newAssorted.Item("sai_tordno") = ""
                            '        newAssorted.Item("sai_creusr") = "~*ADD*~"
                            '        newAssorted.Item("sai_ordseq2") = copyOrdSeq
                            '        rs_SCASSINF_copy.Tables("RESULT").Rows.Add(newAssorted)
                            '    Next
                            'End If

                            dr_SCASSINF_Copy = Nothing
                            dr_SCASSINF_Copy = rs_SCASSINF_ori.Tables("RESULT").Select("sai_ordseq = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ordseq") & "' and " & _
                                                                                       "sai_itmno = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_itmno") & "'")

                            For j As Integer = 0 To rsIMBOMASS.Tables("RESULT").Rows.Count - 1
                                dr_SCASSINF_Copy = Nothing
                                dr_SCASSINF_Copy = rs_SCASSINF_ori.Tables("RESULT").Select("sai_ordseq = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ordseq") & "' and " & _
                                                                                           "sai_itmno = '" & newRow.Item("sod_itmno") & "' and " & _
                                                                                           "sai_assitm = '" & rsIMBOMASS.Tables("RESULT").Rows(j)("iba_assitm") & "' and " & _
                                                                                           "sai_colcde = '" & rsIMBOMASS.Tables("RESULT").Rows(j)("iba_colcde") & "' and " & _
                                                                                           "sai_untcde = '" & rsIMBOMASS.Tables("RESULT").Rows(j)("iba_pckunt") & "' and " & _
                                                                                           "sai_inrqty = '" & rsIMBOMASS.Tables("RESULT").Rows(j)("iba_inrqty") & "' and " & _
                                                                                           "sai_mtrqty = '" & rsIMBOMASS.Tables("RESULT").Rows(j)("iba_mtrqty") & "'")
                                tmp_SCASSINF_count = rs_SCASSINF_copy.Tables("RESULT").Rows.Count
                                rs_SCASSINF_copy.Tables("RESULT").Rows.Add()
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_ordno") = ""
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_ordseq") = copyOrdSeq
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_itmno") = newRow.Item("sod_itmno")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_assitm") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_assitm")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_assdsc") = dr_SCASSINF_Copy(0)("sai_assdsc")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_cusitm") = dr_SCASSINF_Copy(0)("sai_cusitm")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_colcde") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_colcde")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_coldsc") = dr_SCASSINF_Copy(0)("sai_coldsc")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_cussku") = dr_SCASSINF_Copy(0)("sai_cussku")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_cusstyno") = dr_SCASSINF_Copy(0)("sai_cusstyno")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_upcean") = dr_SCASSINF_Copy(0)("sai_upcean")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_cusrtl") = dr_SCASSINF_Copy(0)("sai_cusrtl")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_imperiod") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_period")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_untcde") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_pckunt")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_inrqty") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_inrqty")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_mtrqty") = rsIMBOMASS.Tables("RESULT").Rows(j)("iba_mtrqty")
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_tordno") = ""
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_tordseq") = 0
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_creusr") = "~*ADD*~"
                                rs_SCASSINF_copy.Tables("RESULT").Rows(tmp_SCASSINF_count)("sai_ordseq2") = copyOrdSeq
                            Next
                        Else
                            newRow.Item("sod_assitmcount") = 0
                        End If

                        ' Check for BOM
                        gspStr = "sp_select_IMBOM_SC '" & cboPanCopyCustCoCde.Text & "','" & newRow.Item("sod_itmno") & "'"
                        rsIMBOMINF = Nothing
                        Me.Cursor = Windows.Forms.Cursors.WaitCursor
                        rtnLong = execute_SQLStatement(gspStr, rsIMBOMINF, rtnStr)
                        Me.Cursor = Windows.Forms.Cursors.Default
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SCM00001 #129 sp_select_IMBOM_SC : " & rtnStr)
                            Exit Sub
                        End If
                        If rsIMBOMINF.Tables("RESULT").Rows.Count > 0 Then
                            Dim newBOM As DataRow
                            For j As Integer = 0 To rsIMBOMINF.Tables("RESULT").Rows.Count - 1
                                newBOM = Nothing
                                newBOM = rs_SCBOMINF_copy.Tables("RESULT").NewRow
                                newBOM.Item("sbi_ordno") = ""
                                newBOM.Item("sbi_ordseq") = copyOrdSeq
                                newBOM.Item("sbi_itmno") = newRow.Item("sod_itmno")
                                newBOM.Item("sbi_assitm") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_assitm")
                                newBOM.Item("sbi_assinrqty") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_assinrqty")
                                newBOM.Item("sbi_assmtrqty") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_assmtrqty")
                                newBOM.Item("sbi_bomitm") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bomitm")
                                newBOM.Item("sbi_venno") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_venno")
                                newBOM.Item("sbi_bomdsce") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bomdsce")
                                newBOM.Item("sbi_bomdscc") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bomdscc")
                                newBOM.Item("sbi_colcde") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_colcde")
                                newBOM.Item("sbi_coldsc") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_coldsc")
                                newBOM.Item("sbi_pckunt") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_pckunt")
                                newBOM.Item("sbi_ordqty") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_ordqty")
                                newBOM.Item("sbi_fcurcde") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_fcurcde")
                                newBOM.Item("sbi_ftyprc") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_ftyprc")
                                newBOM.Item("sbi_bcurcde") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bcurcde")
                                newBOM.Item("sbi_bomcst") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bomcst")
                                newBOM.Item("sbi_obcurcde") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_obcurcde")
                                newBOM.Item("sbi_obomcst") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_obomcst")
                                newBOM.Item("sbi_obomprc") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_obomprc")
                                newBOM.Item("sbi_creusr") = "~*ADD*~"
                                newBOM.Item("sbi_ordseq2") = copyOrdSeq
                                newBOM.Item("sbi_bompoflg") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_bompoflg")
                                newBOM.Item("sbi_imperiod") = rsIMBOMINF.Tables("RESULT").Rows(j)("sbi_imperiod")
                                rs_SCBOMINF_copy.Tables("RESULT").Rows.Add(newBOM)
                            Next
                        End If

                        ' 2013-12-09 David Yue Component Breakdown Load from CIH Component Breakdown
                        '' Check for Material Breakdowns
                        'gspStr = "sp_select_QUCPTBKD_SC '" & cboCoCde.Text & "','" & dr_CUITMPRC_Copy(0).Item("cis_qutno") & "','" & _
                        '         dr_CUITMPRC_Copy(0).Item("cis_itmno") & "','" & dr_CUITMPRC_Copy(0).Item("cis_untcde") & "','" & _
                        '         dr_CUITMPRC_Copy(0).Item("cis_inrqty") & "','" & dr_CUITMPRC_Copy(0).Item("cis_mtrqty") & "','" & _
                        '         dr_CUITMPRC_Copy(0).Item("cis_colcde") & "'"
                        'rsQUCPTBKD = Nothing
                        'Me.Cursor = Windows.Forms.Cursors.WaitCursor
                        'rtnLong = execute_SQLStatement(gspStr, rsQUCPTBKD, rtnStr)
                        'Me.Cursor = Windows.Forms.Cursors.Default
                        'If rtnLong <> RC_SUCCESS Then
                        '    MsgBox("Error on loading SCM00001 #130 sp_select_QUCPTBKD_SC : " & rtnStr)
                        '    Exit Sub
                        'End If
                        'If rsQUCPTBKD.Tables("RESULT").Rows.Count > 0 Then
                        '    Dim newCPT As DataRow
                        '    For j As Integer = 0 To rsQUCPTBKD.Tables("RESULT").Rows.Count - 1
                        '        newCPT = rs_SCCPTBKD_copy.Tables("RESULT").NewRow
                        '        newCPT.Item("scb_cocde") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_cocde")
                        '        newCPT.Item("scb_ordno") = ""
                        '        newCPT.Item("scb_ordseq") = copyOrdSeq
                        '        newCPT.Item("scb_itmno") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_itmno")
                        '        newCPT.Item("scb_cptseq") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_cptseq")
                        '        newCPT.Item("scb_cpt") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_cpt")
                        '        newCPT.Item("scb_curcde") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_curcde")
                        '        newCPT.Item("scb_cst") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_cst")
                        '        newCPT.Item("scb_cstpct") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_cstpct")
                        '        newCPT.Item("scb_pct") = rsQUCPTBKD.Tables("RESULT").Rows(j)("qcb_pct")
                        '        newCPT.Item("scb_creusr") = "~*ADD*~"
                        '        rs_SCCPTBKD_copy.Tables("RESULT").Rows.Add(newCPT)
                        '    Next
                        'End If

                        Dim rs_CUCPTBKD As DataSet
                        gspStr = "sp_select_CUCPTBKD_SC '" & cboCoCde.Text & "','" & _
                                 dr_CUITMPRC_Copy(0).Item("cis_cusno") & "','" & _
                                 dr_CUITMPRC_Copy(0).Item("cis_seccus") & "','" & _
                                 dr_CUITMPRC_Copy(0).Item("cis_itmno") & "','" & _
                                 dr_CUITMPRC_Copy(0).Item("cis_colcde") & "'"
                        rtnLong = execute_SQLStatement(gspStr, rs_CUCPTBKD, rtnStr)
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SCM00001 #130 sp_select_CUCPTBKD_SC : " & rtnStr)
                            Exit Sub
                        End If
                        If rs_CUCPTBKD.Tables("RESULT").Rows.Count > 0 Then
                            Dim newCPT As DataRow
                            For j As Integer = 0 To rs_CUCPTBKD.Tables("RESULT").Rows.Count - 1
                                newCPT = Nothing
                                newCPT = rs_SCCPTBKD.Tables("RESULT").NewRow
                                newCPT.Item("scb_cocde") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_cocde")
                                newCPT.Item("scb_ordno") = ""
                                newCPT.Item("scb_ordseq") = currentOrdSeq
                                newCPT.Item("scb_itmno") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_itmno")
                                newCPT.Item("scb_cptseq") = j + 1 'rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_cptseq")
                                newCPT.Item("scb_cpt") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_cpt")
                                newCPT.Item("scb_curcde") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_curcde")
                                newCPT.Item("scb_cst") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_cst")
                                newCPT.Item("scb_cstpct") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_cstpct")
                                newCPT.Item("scb_pct") = rs_CUCPTBKD.Tables("RESULT").Rows(j)("ccb_pct")
                                newCPT.Item("scb_creusr") = "~*ADD*~"
                                rs_SCCPTBKD.Tables("RESULT").Rows.Add(newCPT)
                            Next
                        End If

                        rs_SCORDDTL_copyOK.Tables("RESULT").Rows.Add(newRow)
                        copyOrdSeq += 1
                    End If
                End If
            End If

            lblCount.Text = totalCopy & " of " & totalR
            lblFail.Text = totalFail & " of " & totalR
            pBarPanSCCopy.Value += 1
        Next

        For i As Integer = 0 To rs_SCORDDTL_copyOK.Tables("RESULT").Rows.Count - 1
            rs_SCORDDTL_copyOK.Tables("RESULT").Rows(i)("max_seq") = rs_SCORDDTL_copyOK.Tables("RESULT").Rows.Count
        Next

        dgCopyValid.DataSource = rs_SCORDDTL_copyOK.Tables("RESULT").DefaultView
        Display_CopyValid()
        dgCopyInvalid.DataSource = rs_SCORDDTL_copyFail.Tables("RESULT").DefaultView
        Display_CopyInvalid()

        If copyNotLatest > 0 Then
            If copyNotLatest = totalR Then
                MsgBox("All of the items do not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Copy")
            ElseIf copyNotLatest = 1 Then
                MsgBox("One of the items does not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Copy")
            ElseIf copyNotLatest > 1 Then
                MsgBox("More than one of the items do not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Copy")
            End If
        End If

        If rs_SCORDDTL_copyOK.Tables("RESULT").Rows.Count > 0 Then
            cmdPanSCCopyCopy.Enabled = True
        Else
            cmdPanSCCopyCopy.Enabled = False
        End If
    End Sub

    Private Sub Display_CopyValid()
        With dgCopyValid
            For i As Integer = 0 To rs_SCORDDTL_copyOK.Tables("RESULT").Columns.Count - 1
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Select Case i
                    Case 7
                        .Columns(i).HeaderText = "PV"
                        .Columns(i).Width = 150
                        .Columns(i).ReadOnly = True
                        'Case 6
                        '    .Columns(i).HeaderText = "Sub-Code"
                        '    .Columns(i).Width = 80
                        '    .Columns(i).ReadOnly = True
                    Case 15
                        .Columns(i).HeaderText = "Item #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 16
                        .Columns(i).HeaderText = "Cust Sty #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 17
                        .Columns(i).HeaderText = "Cust Itm #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 18
                        .Columns(i).HeaderText = "Cust SKU #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 25
                        .Columns(i).HeaderText = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/TranTrm)"
                        .Columns(i).Width = 350
                        .Columns(i).ReadOnly = True
                    Case 41
                        .Columns(i).HeaderText = "Color Desc"
                        .Columns(i).Width = 250
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub Display_CopyInvalid()
        With dgCopyInvalid
            For i As Integer = 0 To rs_SCORDDTL_copyFail.Tables("RESULT").Columns.Count - 1
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Select Case i
                    Case 7
                        .Columns(i).HeaderText = "PV"
                        .Columns(i).Width = 150
                        .Columns(i).ReadOnly = True
                        'Case 6
                        '    .Columns(i).HeaderText = "Sub-Code"
                        '    .Columns(i).Width = 80
                        '    .Columns(i).ReadOnly = True
                    Case 15
                        .Columns(i).HeaderText = "Item #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 25
                        .Columns(i).HeaderText = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/TranTrm)"
                        .Columns(i).Width = 350
                        .Columns(i).ReadOnly = True
                    Case 41
                        .Columns(i).HeaderText = "Reason"
                        .Columns(i).Width = 250
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub txtPanCopyCustSecCustPODat_Validating(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtPanCopyCustCustPODat.Validating
        If cmdPanCopy_CustCancel.Focused = True Then
            Exit Sub
        End If

        If sender.Text <> "  /  /" Then
            If sender.Text.Length <> 10 Or IsDate(sender.Text) = False Then
                e.Cancel = True
                MsgBox("Invalid Customer PO Date (MM/DD/YYYY)")
                Exit Sub
            ElseIf CDate(sender.Text) < DateAdd(DateInterval.Day, -365, Date.Today) Or CDate(sender.Text) > DateAdd(DateInterval.Day, 365, Date.Today) Then
                e.Cancel = True
                MsgBox("Customer PO Date out of allowed range (+/- 365 days)")
                Exit Sub
            End If
        End If
    End Sub

    Private Sub cmdSavePO_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSavePO.Click
        Dim rs_tmp As DataSet
        Dim drPOSHPMRK() As DataRow
        Dim saveOK As Boolean = False
        Dim saveError As Boolean = False

        For i As Integer = 0 To rs_POORDHDR.Tables("RESULT").Rows.Count - 1
            ' Check timestamp
            gspStr = "sp_select_POORDHDR '" & cboCoCde.Text & "','" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_tmp, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #132 sp_select_POORDHDR : " & rtnStr)
                Exit Sub
            End If
            If rs_tmp.Tables("RESULT").Rows.Count = 0 Then
                MsgBox("P0 # " & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & Environment.NewLine & _
                       "The record has been modified by other users, please clear and try again.", MsgBoxStyle.Exclamation, "SCM00001 - Save PO")
                saveError = True
                Continue For
            Else
                If rs_tmp.Tables("RESULT").Rows(0)("poh_timstp") <> rs_POORDHDR.Tables("RESULT").Rows(i)("poh_timstp") Then
                    MsgBox("P0 # " & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & Environment.NewLine & _
                           "The record has been modified by other users, please clear and try again.", MsgBoxStyle.Exclamation, "SCM00001 - Save PO")
                    saveError = True
                    Continue For
                End If
            End If

            If checkUpdatePOHeader(rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord"), rs_POORDHDR.Tables("RESULT").Rows(i)) = True Then
                If rs_POORDHDR.Tables("RESULT").Rows(i)("poh_pursts") <> "OPE" Then
                    MsgBox("PO # " & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & " not in OPEN status" & Environment.NewLine & "PO not updated")
                    saveError = True
                    Continue For
                End If

                gspStr = "sp_update_POORDHDR_SC '" & cboCoCde.Text & "','" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & "','" & _
                        rs_POORDHDR.Tables("RESULT").Rows(i)("poh_porctp") & "','" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_prctrm") & "','" & _
                        rs_POORDHDR.Tables("RESULT").Rows(i)("poh_paytrm") & "','" & _
                        Replace(rs_POORDHDR.Tables("RESULT").Rows(i)("poh_rmk").ToString, "'", "''") & "','" & _
                        rs_POORDHDR.Tables("RESULT").Rows(i)("poh_discnt") & "','" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_pocdat") & "','" & _
                        rs_POORDHDR.Tables("RESULT").Rows(i)("poh_pocdatend") & "','" & LCase(gsUsrID) & "'"
                rtnLong = execute_SQLStatement(gspStr, rs_tmp, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on saving SCM00001 #133 sp_update_POORDHDR_SC : " & rtnStr)
                    Exit Sub
                Else
                    saveOK = True
                End If
            End If

            drPOSHPMRK = Nothing
            drPOSHPMRK = rs_POSHPMRK.Tables("RESULT").Select("psm_purord = '" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & "'")
            If drPOSHPMRK.Length > 0 Then
                For j As Integer = 0 To drPOSHPMRK.Length - 1
                    If checkUpdatePOShpmrk(rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord"), drPOSHPMRK(j).Item("psm_shptyp"), drPOSHPMRK(j)) = True Then
                        gspStr = "sp_update_POSHPMRK '" & cboCoCde.Text & "','" & rs_POORDHDR.Tables("RESULT").Rows(i)("poh_purord") & "','" & _
                                 drPOSHPMRK(j).Item("psm_shptyp") & "','" & Replace(drPOSHPMRK(j).Item("psm_engdsc"), "'", "''") & "','" & _
                                 Replace(drPOSHPMRK(j).Item("psm_chndsc"), "'", "''") & "','" & Replace(drPOSHPMRK(j).Item("psm_engrmk"), "'", "''") & _
                                 "','" & Replace(drPOSHPMRK(j).Item("psm_chnrmk"), "'", "''") & "','" & LCase(gsUsrID) & "'"
                        rs_tmp = Nothing
                        rtnLong = execute_SQLStatement(gspStr, rs_tmp, rtnStr)
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on saving SCM00001 #134 sp_update_POSHPMRK : " & rtnStr)
                            Exit Sub
                        Else
                            saveOK = True
                        End If
                    End If
                Next
            End If
        Next

        If saveOK = True Then
            MsgBox("All PO successfully updated", , "SCM00001 - Save PO")
        Else
            If saveError = True Then
                MsgBox("Partial PO updated", MsgBoxStyle.Exclamation, "SCM00001 - Save PO")
            Else
                MsgBox("No PO has been updated", MsgBoxStyle.Information, "SCM00001 - Save PO")
            End If
        End If

        cmdClear.PerformClick()
    End Sub

    Private Function checkUpdatePOHeader(ByVal purord As String, ByVal drPOORDHDR As DataRow) As Boolean
        Dim drPOORDHDR_ori() As DataRow = rs_POORDHDR_ori.Tables("RESULT").Select("poh_purord = '" & purord & "'")
        If drPOORDHDR_ori.Length > 0 Then
            For i As Integer = 0 To rs_POORDHDR.Tables("RESULT").Columns.Count - 1
                Select Case drPOORDHDR.Item(i).GetType.ToString
                    Case "System.Decimal"
                        If drPOORDHDR.Item(i) <> drPOORDHDR_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.Int32"
                        If drPOORDHDR.Item(i) <> drPOORDHDR_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.String"
                        If Trim(drPOORDHDR.Item(i).ToString) <> Trim(drPOORDHDR_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                    Case "System.DateTime"
                        If drPOORDHDR.Item(i) <> drPOORDHDR_ori(0).Item(i) Then
                            Return True
                        End If
                    Case Else

                End Select
            Next
            Return False
        Else
            Return False
        End If
    End Function

    Private Function checkUpdatePOShpmrk(ByVal purord As String, ByVal shptyp As String, ByVal drPOSHPMRK As DataRow) As Boolean
        Dim drPOSHPMRK_ori() As DataRow = rs_POSHPMRK_ori.Tables("RESULT").Select("psm_purord = '" & purord & "' and psm_shptyp ='" & shptyp & "'")
        If drPOSHPMRK_ori.Length > 0 Then
            For i As Integer = 0 To rs_POSHPMRK.Tables("RESULT").Columns.Count - 1
                Select Case drPOSHPMRK.Item(i).GetType.ToString
                    Case "System.Decimal"
                        If drPOSHPMRK.Item(i) <> drPOSHPMRK_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.Int32"
                        If drPOSHPMRK.Item(i) <> drPOSHPMRK_ori(0).Item(i) Then
                            Return True
                        End If
                    Case "System.String"
                        If Trim(drPOSHPMRK.Item(i).ToString) <> Trim(drPOSHPMRK_ori(0).Item(i).ToString) Then
                            Return True
                        End If
                    Case "System.DateTime"
                        If drPOSHPMRK.Item(i) <> drPOSHPMRK_ori(0).Item(i) Then
                            Return True
                        End If
                    Case Else

                End Select
            Next
            Return False
        Else
            Return False
        End If
    End Function

    'Private Sub dgSCShpDat_EditingControlShowing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgSCShpDat.EditingControlShowing
    '    Select Case dgSCShpDat.CurrentCell.ColumnIndex
    '        Case dgDtlShpDat_CtnStr, dgDtlShpDat_CtnEnd, dgDtlShpDat_OrdQty
    '            Dim txtbox As TextBox = CType(e.Control, TextBox)
    '            If Not (txtbox Is Nothing) Then
    '                AddHandler txtbox.KeyPress, AddressOf txt_dgSCShpDat_KeyPress
    '            End If
    '    End Select
    'End Sub

    'Private Sub txt_dgSCShpDat_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
    '    Dim curvalue As String = dgSCShpDat.CurrentCell.EditedFormattedValue
    '    ' Check Numeric
    '    Select Case dgSCShpDat.CurrentCell.ColumnIndex
    '        Case dgDtlShpDat_CtnStr, dgDtlShpDat_CtnEnd, dgDtlShpDat_OrdQty
    '            If Not (e.KeyChar = vbBack Or (e.KeyChar.ToString() >= "0" And e.KeyChar.ToString() <= "9")) Then
    '                e.KeyChar = ""
    '            End If
    '    End Select
    'End Sub

    Private Sub txtPOStartShip_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOStartShip.Enter
        txtPOStartShip.SelectionStart = 0
        txtPOStartShip.Refresh()
        txtPOStartShip.SelectAll()
    End Sub

    Private Sub txtPOEndShip_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOEndShip.Enter
        txtPOEndShip.SelectionStart = 0
        txtPOEndShip.Refresh()
        txtPOEndShip.SelectAll()
    End Sub

    Private Sub txtPOCanDat_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOCanDat.Enter
        txtPOCanDat.SelectionStart = 0
        txtPOCanDat.Refresh()
        txtPOCanDat.SelectAll()
    End Sub

    Private Sub cboHSTU_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboHSTU.KeyPress
        If Asc(e.KeyChar) = 46 Then
            Return
        ElseIf Asc(e.KeyChar) = 8 Then
            Return
        ElseIf IsNumeric(e.KeyChar) Then
            Return
        ElseIf sender.Text.Length >= 25 Then
            e.KeyChar = Chr(0)
        Else
            e.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub cmdPanDtl0ShpDatCalcPODat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanDtl0ShpDatCalcPODat.Click
        Dim rs_POSHPDAT As DataSet

        For i As Integer = 0 To dgSCShpDat.Rows.Count - 1
            If dgSCShpDat.Rows(i).Cells("sds_status").Value <> "Y" And (dgSCShpDat.Rows(i).Cells("sds_pofrom").Value <> "" Or dgSCShpDat.Rows(i).Cells("sds_pofrom").Value <> "01/01/1900") Then
                gspStr = "sp_select_POSHPDAT_SC '" & cboCoCde.Text & "','" & Split(cboCusVen.Text, " - ")(0) & "','" & _
                         dgSCShpDat.Rows(i).Cells("sds_scfrom").Value & "','" & dgSCShpDat.Rows(i).Cells("sds_scto").Value & "',''"
                rtnLong = execute_SQLStatement(gspStr, rs_POSHPDAT, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SCM00001 #135 sp_select_POSHPDAT : " & rtnStr)
                    Exit Sub
                End If

                If rs_POSHPDAT.Tables("RESULT").Rows.Count > 0 Then
                    If rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posstr") <= CDate("01/01/1900") Then
                        dgSCShpDat.Rows(i).Cells("sds_pofrom").Value = ""
                    Else
                        dgSCShpDat.Rows(i).Cells("sds_pofrom").Value = Format(rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posstr"), "MM/dd/yyyy")
                    End If

                    If rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posend") <= CDate("01/01/1900") Then
                        dgSCShpDat.Rows(i).Cells("sds_poto").Value = ""
                    Else
                        dgSCShpDat.Rows(i).Cells("sds_poto").Value = Format(rs_POSHPDAT.Tables("RESULT").Rows(0)("sod_posend"), "MM/dd/yyyy")
                    End If

                    recordStatus_dtl = True
                End If

            End If
        Next
    End Sub

    Private Sub chkDelDtl_Validating(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles chkDelDtl.Validating
        If chkDelDtl.Checked = False And hdr_CustPODat <> CustPODat_ori And txtSCNo.Text <> "" Then
            Dim dr() As DataRow = rs_SCORDDTL_ori.Tables("RESULT").Select("sod_ordseq = '" & currentOrdSeq & "' and sod_itmno = '" & txtItmno.Text & "'")
            If dr.Length <> 0 Then
                e.Cancel = True
                chkDelDtl.Checked = True
                MsgBox("You are not allowed to uncheck deleted items from different Customer PO Date", MsgBoxStyle.Critical, "SCM00001 - Uncheck Delete")
                Exit Sub
            End If
        End If
    End Sub

    Private Sub Vendors_SelectionChangeCommitted(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboCusVen.SelectionChangeCommitted, cboTradeVen.SelectionChangeCommitted, cboExamVen.SelectionChangeCommitted
        recordStatus = True
        recordStatus_dtl = True
    End Sub

    Private Sub txtTentOrdno_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtTentOrdno.KeyPress
        If Asc(e.KeyChar) = 13 Then
            txtTentOrdno.Text = UCase(Trim(txtTentOrdno.Text))

            If txtTentOrdno.Text = "" Then
                MsgBox("Tentative Order No. is empty")
                Exit Sub
            End If

            gspStr = "sp_select_TOITMDTL_SC '" & cboCoCde.Text & "','" & txtTentOrdno.Text & "','" & UCase(Trim(txtItmno.Text)) & _
                     "','" & Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "','" & UCase(gsUsrID) & "'"
            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rs_TOITMDTL, rtnStr)
            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #137 sp_select_TOITMDTL_SC : " & rtnStr)
                Exit Sub
            Else
                For i As Integer = 0 To rs_TOITMDTL.Tables("RESULT").Columns.Count - 1
                    rs_TOITMDTL.Tables("RESULT").Columns(i).ReadOnly = False
                Next
            End If

            If rs_TOITMDTL.Tables("RESULT").Rows.Count = 0 Then
                MsgBox("Tentative Order not found")
                Exit Sub
            Else
                freeze_TabControl(tabFrame_Detail)
                grpDetail.Enabled = False
                panTent.Width = 455
                panTent.Height = 235
                panTent.Location = New Point(220, 200)
                loadPanTent("DETAIL", currentOrdSeq)
                panTent.BringToFront()
                initFlag = True
                panTent.Visible = True
                initFlag = False
                dgTOITMDTL.ClearSelection()
                recordStatus_dtl = True
            End If
        End If
    End Sub

    Private Sub loadPanTent(ByVal mode As String, ByVal ordseq As Integer, Optional ByVal itmno As String = "", Optional ByVal colcde As String = "", Optional ByVal toordno As String = "")
        lblPanTentMode.Text = UCase(mode)

        If UCase(mode) = "DETAIL" Then
            lblPanTentTOrdno.Text = txtTentOrdno.Text
            lblPanTentItmno.Text = txtItmno.Text
            lblPanTentColCde.Text = ""
        ElseIf UCase(mode) = "ASSORTED" Then
            lblPanTentTOrdno.Text = UCase(toordno)
            lblPanTentItmno.Text = UCase(itmno)
            lblPanTentColCde.Text = UCase(colcde)
        End If

        dgTOITMDTL.Enabled = True
        display_dgTOITMDTL()
    End Sub

    Private Sub display_dgTOITMDTL()
        dgTOITMDTL.DataSource = rs_TOITMDTL.Tables("RESULT").DefaultView

        With dgTOITMDTL
            For i As Integer = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        dgDtlShpDat_Del = i
                        .Columns(i).HeaderText = "Select"
                        .Columns(i).Width = 50
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                        .Columns(i).ReadOnly = True
                    Case 2
                        dgDtlShpDat_SCFrom = i
                        .Columns(i).HeaderText = "TO Seq"
                        .Columns(i).Width = 50
                        .Columns(i).ReadOnly = True
                    Case 3
                        dgDtlShpDat_SCTo = i
                        .Columns(i).HeaderText = "UM"
                        .Columns(i).Width = 50
                        .Columns(i).ReadOnly = True
                    Case 4
                        dgDtlShpDat_POFrom = i
                        .Columns(i).HeaderText = "TO Qty"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = True
                    Case 5
                        dgDtlShpDat_POTo = i
                        .Columns(i).HeaderText = "SO Qty"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = True
                    Case 6
                        dgDtlShpDat_OrdQty = i
                        .Columns(i).HeaderText = "OS Qty"
                        .Columns(i).Width = 55
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
        End With
    End Sub

    Private Sub cmdPanTentSelect_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanTentSelect.Click
        Dim dr() As DataRow = rs_TOITMDTL.Tables("RESULT").Select("tid_status = 'Y'")

        If dr.Length = 0 Then
            MsgBox("No Tentative Order Sequence selected")
            Exit Sub
        End If

        If dr(0)("tid_osqty") <= 0 Then
            MsgBox("Sales Order Quantity Exceeded")
            Exit Sub
        End If

        If lblPanTentMode.Text = "DETAIL" Then
            If dr(0)("tid_pckunt") <> txtUM.Text Then
                MsgBox("Tentative Order Item UM does not match with SC Item UM")
                Exit Sub
            End If
        End If

        If lblPanTentMode.Text = "DETAIL" Then
            txtTentOrdSeq.Text = dr(0)("tid_toordseq").ToString
            txtTentOrdno.Enabled = False
        ElseIf lblPanTentMode.Text = "ASSORTED" Then
            dgAssort.CurrentRow.Cells("sai_tordseq").Value = dr(0)("tid_toordseq").ToString
            dgAssort.Columns("sai_tordno").ReadOnly = True
            rs_SCASSINF_tmp.AcceptChanges()
        End If

        cmdPanTentCancel.PerformClick()
    End Sub

    Private Sub cmdPanTentCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanTentCancel.Click
        If lblPanTentMode.Text = "DETAIL" Then
            release_TabControl()
            grpDetail.Enabled = True
            panTent.Visible = False
        ElseIf lblPanTentMode.Text = "ASSORTED" Then
            panTent.Visible = False
            panDtlASS.Visible = True
            dgAssort.ClearSelection()
        End If
    End Sub

    Private Sub dgTOITMDTL_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgTOITMDTL.CellClick
        If e.RowIndex >= 0 Then
            If e.ColumnIndex = 0 Then
                If dgTOITMDTL.Rows(e.RowIndex).Cells("tid_status").Value = "Y" Then
                    dgTOITMDTL.Rows(e.RowIndex).Cells("tid_status").Value = ""
                Else
                    For i As Integer = 0 To dgTOITMDTL.Rows.Count - 1
                        dgTOITMDTL.Rows(i).Cells("tid_status").Value = ""
                    Next
                    dgTOITMDTL.Rows(e.RowIndex).Cells("tid_status").Value = "Y"
                End If
            End If
        End If
    End Sub

    Private Sub dgAssort_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgAssort.RowEnter
        If e.RowIndex >= 0 Then
            If dgAssort.Rows(e.RowIndex).Cells("sai_tordseq").Value.ToString <> "" Then
                dgAssort.Columns("sai_tordno").ReadOnly = True
            Else
                dgAssort.Columns("sai_tordno").ReadOnly = False
            End If
        End If
    End Sub

    Private Sub dgAssort_CellDoubleClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgAssort.CellDoubleClick
        If e.RowIndex >= 0 Then
            If e.ColumnIndex = dgAssort_TOOrdno Then
                If dgAssort.Columns("sai_tordno").ReadOnly = False Then
                    If dgAssort.CurrentRow.Cells("sai_tordno").Value.ToString = "" Then
                        MsgBox("Tentative Order No. is empty")
                        Exit Sub
                    End If

                    gspStr = "sp_select_TOITMDTL_SC '" & cboCoCde.Text & "','" & dgAssort.CurrentRow.Cells("sai_tordno").Value.ToString & "','" & _
                             dgAssort.CurrentRow.Cells("sai_assitm").Value.ToString & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & _
                             Split(cboSecCust.Text, " - ")(0) & "','" & UCase(gsUsrID) & "'"
                    Me.Cursor = Windows.Forms.Cursors.WaitCursor
                    rtnLong = execute_SQLStatement(gspStr, rs_TOITMDTL, rtnStr)
                    Me.Cursor = Windows.Forms.Cursors.Default
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on loading SCM00001 #138 sp_select_TOITMDTL_SC : " & rtnStr)
                        Exit Sub
                    Else
                        For i As Integer = 0 To rs_TOITMDTL.Tables("RESULT").Columns.Count - 1
                            rs_TOITMDTL.Tables("RESULT").Columns(i).ReadOnly = False
                        Next
                    End If

                    If rs_TOITMDTL.Tables("RESULT").Rows.Count = 0 Then
                        MsgBox("Tentative Order not found")
                        Exit Sub
                    Else
                        'freeze_TabControl(tabFrame_Detail)
                        'grpDetail.Enabled = False
                        panDtlASS.Visible = False
                        panTent.Width = 455
                        panTent.Height = 235
                        panTent.Location = New Point(220, 200)
                        loadPanTent("ASSORTED", currentOrdSeq, dgAssort.CurrentRow.Cells("sai_assitm").Value, dgAssort.CurrentRow.Cells("sai_colcde").Value, dgAssort.CurrentRow.Cells("sai_tordno").Value)
                        panTent.BringToFront()
                        initFlag = True
                        panTent.Visible = True
                        initFlag = False
                        dgTOITMDTL.ClearSelection()
                        recordStatus_dtl = True
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub cmdCustPOChg_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCustPOChg.Click
        freeze_TabControl(tabFrame_Header)
        grpHeader.Enabled = False
        panCustPO.Width = 236
        panCustPO.Height = 84
        panCustPO.Location = New Point(377, 238)
        panCustPO.BringToFront()
        panCustPO.Visible = True
        txtPanCustPO_NewDat.Text = "  /  /"
    End Sub

    Private Sub cmdCustPOChg_OK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCustPO_OK.Click
        If txtPanCustPO_NewDat.Text.Length <> 10 Or IsDate(txtPanCustPO_NewDat.Text) = False Then
            MsgBox("Customer PO Date is invalid (MM/DD/YYYY)")
            txtPanCustPO_NewDat.Focus()
            txtPanCustPO_NewDat.SelectAll()
            Exit Sub
        ElseIf (CDate(txtPanCustPO_NewDat.Text) < DateAdd(DateInterval.Day, -365, Date.Today)) Or (CDate(txtPanCustPO_NewDat.Text) > DateAdd(DateInterval.Day, 365, Date.Today)) Then
            MsgBox("Customer PO Date out of allowed range (+/- 365 days)")
            txtPanCustPO_NewDat.Focus()
            txtPanCustPO_NewDat.SelectAll()
            Exit Sub
        End If

        panCustPO.Visible = False
        panCustPOChg.Width = 660
        panCustPOChg.Height = 424
        panCustPOChg.Location = New Point(170, 120)
        panCustPOChg.Visible = True
        loadPanCustPO()
    End Sub

    Private Sub cmdCustPOChg_Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCustPO_Cancel.Click
        release_TabControl()
        grpHeader.Enabled = True
        panCustPO.Visible = False
    End Sub

    Private Sub loadPanCustPO()
        totalR_CustPO = rs_SCORDDTL_ori.Tables("RESULT").Rows.Count
        pBarPanCustPOChg.Maximum = totalR_CustPO
        totalCopy_CustPO = 0
        totalFail_CustPO = 0
        lblPanCustPOChg_Count.Text = totalCopy_CustPO & " of " & totalR_CustPO
        lblPanCustPOChg_Fail.Text = totalFail_CustPO & " of " & totalR_CustPO
        pBarPanCustPOChg.Value = 0
        cmdPanCustPOChg_Change.Enabled = False
        'rs_SCORDDTL_copyOK = rs_SCORDDTL_ori.Clone()
        'rs_SCORDDTL_copyFail = rs_SCORDDTL_ori.Clone()
        'rs_SCASSINF_copy = rs_SCASSINF_ori.Clone()
        'rs_SCBOMINF_copy = rs_SCBOMINF_OLD.Clone()
        'rs_SCCPTBKD_copy = rs_SCCPTBKD_ori.Clone()
        'rs_SCDISPRM_D_copy = rs_SCDISPRM_D.Clone()
        'rs_SCDISPRM_P_copy = rs_SCDISPRM_P.Clone()
        'rs_SCSHPMRK_copy = rs_SCSHPMRK.Clone()
        'check_CopySC()
        rs_SCORDDTL_CustPOChgOK = rs_SCORDDTL_ori.Clone()
        rs_SCORDDTL_CustPOChgFail = rs_SCORDDTL_ori.Clone()
        check_ChgCustPO()
    End Sub

    Private Sub check_ChgCustPO()
        Dim rsCUITMPRC As New DataSet
        Dim dr_CUITMPRC_CustPO() As DataRow
        Dim newRow As DataRow

        Dim copyNotLatest As Integer = 0
        Dim copyOrdSeq As Integer = 1

        For i As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Rows.Count - 1
            gspStr = "sp_select_CUITMPRC_SC_Copy '" & cboCoCde.Text & "','" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_itmno").ToString & _
                     "','" & Split(cboPriCust.Text, " - ")(0) & "','" & Split(cboSecCust.Text, " - ")(0) & "','" & txtPanCustPO_NewDat.Text & " 23:59'"
            rsCUITMPRC = Nothing
            Me.Cursor = Windows.Forms.Cursors.WaitCursor
            rtnLong = execute_SQLStatement(gspStr, rsCUITMPRC, rtnStr)
            Me.Cursor = Windows.Forms.Cursors.Default
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SCM00001 #139 sp_select_CUITMPRC_SC : " & rtnStr)
            End If

            newRow = Nothing
            If rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_tordno") <> "" Then
                totalFail_CustPO += 1
                newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                    newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                Next
                newRow.Item("sod_coldsc") = "Item already matched with Tentative Order"
                rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                rs_SCORDDTL_CustPOChgFail.AcceptChanges()
            ElseIf rsCUITMPRC.Tables("RESULT").Rows.Count = 0 Then
                totalFail_CustPO += 1
                newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                    newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                Next
                newRow.Item("sod_coldsc") = "No valid record exists in CIH"
                rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                rs_SCORDDTL_CustPOChgFail.AcceptChanges()
            Else
                dr_CUITMPRC_CustPO = Nothing
                dr_CUITMPRC_CustPO = rsCUITMPRC.Tables("RESULT").Select("cis_colcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_colcde") & "' and " & _
                                                                 "cis_untcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_pckunt") & "' and " & _
                                                                 "cis_inrqty = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_inrctn") & "' and " & _
                                                                 "cis_mtrqty = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_mtrctn") & "' and " & _
                                                                 "cis_colcde = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_colcde") & "' and " & _
                                                                 "cis_cft = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_cft") & "' and " & _
                                                                 "cis_cbm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_cbm") & "' and " & _
                                                                 "cip_ftyprctrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ftyprctrm") & "' and " & _
                                                                 "cip_hkprctrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_hkprctrm") & "' and " & _
                                                                 "cip_trantrm = '" & rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_trantrm") & "'")

                If dr_CUITMPRC_CustPO.Length = 0 Then
                    totalFail_CustPO += 1
                    newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Record does not exist in CIH"
                    rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_CustPOChgFail.AcceptChanges()
                ElseIf dr_CUITMPRC_CustPO(0).Item("ibi_itmsts").ToString.Substring(0, 3) = "OLD" Then
                    totalFail_CustPO += 1
                    newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "OLD item status"
                    rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_CustPOChgFail.AcceptChanges()
                ElseIf (dr_CUITMPRC_CustPO(0).Item("ibi_itmsts").ToString.Substring(0, 3) <> "CMP" And dr_CUITMPRC_CustPO(0).Item("ibi_itmsts").ToString.Substring(0, 3) <> "INC") Then
                    totalFail_CustPO += 1
                    newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Item not in Active Status"
                    rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_CustPOChgFail.AcceptChanges()
                ElseIf dr_CUITMPRC_CustPO(0).Item("vbi_vensts").ToString <> "A" Then
                    totalFail_CustPO += 1
                    newRow = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").NewRow
                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next
                    newRow.Item("sod_coldsc") = "Default Vendor not in Active status"
                    rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Rows.Add(newRow)
                    rs_SCORDDTL_CustPOChgFail.AcceptChanges()
                Else
                    totalCopy_CustPO += 1
                    If dr_CUITMPRC_CustPO(0).Item("cip_latest") = "N" Then
                        copyNotLatest += 1
                    End If

                    newRow = rs_SCORDDTL_CustPOChgOK.Tables("RESULT").NewRow

                    For j As Integer = 0 To rs_SCORDDTL_ori.Tables("RESULT").Columns.Count - 1
                        newRow.Item(j) = IIf(IsDBNull(rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j)), "", rs_SCORDDTL_ori.Tables("RESULT").Rows(i)(j))
                    Next

                    newRow.Item("sod_cvname") = dr_CUITMPRC_CustPO(0).Item("vbi_cvname")
                    newRow.Item("sod_pvname") = dr_CUITMPRC_CustPO(0).Item("vbi_pvname")
                    newRow.Item("sod_tvname") = dr_CUITMPRC_CustPO(0).Item("vbi_tvname")
                    newRow.Item("sod_evname") = dr_CUITMPRC_CustPO(0).Item("vbi_evname")
                    newRow.Item("sod_itmno") = dr_CUITMPRC_CustPO(0).Item("cis_itmno")
                    'newRow.Item("sod_cusstyno") = dr_CUITMPRC_CustPO(0).Item("cis_cusstyno")
                    'newRow.Item("sod_cusitm") = dr_CUITMPRC_CustPO(0).Item("cis_cusitm")
                    'newRow.Item("sod_cussku") = dr_CUITMPRC_CustPO(0).Item("cis_cussku")
                    'newRow.Item("sod_seccusitm") = ""
                    newRow.Item("ibi_itmsts") = dr_CUITMPRC_CustPO(0).Item("ibi_itmsts")
                    newRow.Item("h_ibi_itmsts") = "N/A"
                    newRow.Item("sod_itmtyp") = dr_CUITMPRC_CustPO(0).Item("ibi_typ")
                    'newRow.Item("sod_itmdsc") = dr_CUITMPRC_CustPO(0).Item("cis_itmdsc")
                    'newRow.Item("sod_cuscol") = dr_CUITMPRC_CustPO(0).Item("cis_cuscol")
                    newRow.Item("sod_colpck") = dr_CUITMPRC_CustPO(0).Item("cis_colpck")
                    newRow.Item("sod_colcde") = dr_CUITMPRC_CustPO(0).Item("cis_colcde")
                    newRow.Item("sod_pckunt") = dr_CUITMPRC_CustPO(0).Item("cis_untcde")
                    newRow.Item("sod_inrctn") = dr_CUITMPRC_CustPO(0).Item("cis_inrqty")
                    newRow.Item("sod_mtrctn") = dr_CUITMPRC_CustPO(0).Item("cis_mtrqty")
                    newRow.Item("sod_cft") = dr_CUITMPRC_CustPO(0).Item("cis_cft")
                    newRow.Item("sod_cbm") = dr_CUITMPRC_CustPO(0).Item("cis_cbm")
                    newRow.Item("sod_ftyprctrm") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprctrm")
                    newRow.Item("sod_hkprctrm") = dr_CUITMPRC_CustPO(0).Item("cip_hkprctrm")
                    newRow.Item("sod_trantrm") = dr_CUITMPRC_CustPO(0).Item("cip_trantrm")
                    newRow.Item("sod_cus1no") = dr_CUITMPRC_CustPO(0).Item("cip_cus1no")
                    newRow.Item("sod_cus2no") = dr_CUITMPRC_CustPO(0).Item("cip_cus2no")
                    If dr_CUITMPRC_CustPO(0).Item("cip_cus1no") = "" Then
                        newRow.Item("sod_prcgrp") = "STANDARD"
                    Else
                        If dr_CUITMPRC_CustPO(0).Item("cip_cus2no") = "" Then
                            newRow.Item("sod_prcgrp") = dr_CUITMPRC_CustPO(0).Item("cip_cus1no")
                        Else
                            newRow.Item("sod_prcgrp") = dr_CUITMPRC_CustPO(0).Item("cip_cus1no") & " / " & dr_CUITMPRC_CustPO(0).Item("cip_cus2no")
                        End If
                    End If
					newRow.Item("sod_effcpo") = dr_CUITMPRC_CustPO(0).Item("cip_effcpo")
                    newRow.Item("sod_effdat") = dr_CUITMPRC_CustPO(0).Item("cip_effdat")
                    newRow.Item("sod_expdat") = dr_CUITMPRC_CustPO(0).Item("cip_expdat")
                    'newRow.Item("sod_pckitr") = dr_CUITMPRC_CustPO(0).Item("cis_pckitr")
                    'newRow.Item("sod_coldsc") = dr_CUITMPRC_CustPO(0).Item("cis_coldsc")
                    'newRow.Item("sod_pckseq") = 0
                    newRow.Item("sod_qutno") = dr_CUITMPRC_CustPO(0).Item("cis_refdoc")
                    newRow.Item("sod_refdat") = dr_CUITMPRC_CustPO(0).Item("cis_docdat")
                    'newRow.Item("sod_resppo") = ""
                    'newRow.Item("sod_cuspo") = ""
                    'newRow.Item("sod_ordqty") = rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ordqty")
                    'newRow.Item("sod_shpqty") = 0
                    'newRow.Item("sod_outqty") = rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_ordqty") - rs_SCORDDTL_ori.Tables("RESULT").Rows(i)("sod_shpqty")
                    'newRow.Item("sod_discnt") = 0
                    'newRow.Item("sod_oneprc") = "N"
                    newRow.Item("sod_curcde") = dr_CUITMPRC_CustPO(0).Item("cip_curcde")
                    'newRow.Item("sod_moqchg") = 0
                    newRow.Item("sod_netuntprc") = Format(dr_CUITMPRC_CustPO(0).Item("cis_selprc") * (1 + newRow.Item("sod_moqchg") / 100), "######0.0000")
                    newRow.Item("sod_untprc") = dr_CUITMPRC_CustPO(0).Item("cis_selprc")
                    newRow.Item("sod_orgunt") = dr_CUITMPRC_CustPO(0).Item("cis_selprc")
                    If dr_CUITMPRC_CustPO(0).Item("cip_minprc") > 0 And dr_CUITMPRC_CustPO(0).Item("cip_minprc") <> dr_CUITMPRC_CustPO(0).Item("cip_basprc") Then
                        newRow.Item("sod_itmprc") = dr_CUITMPRC_CustPO(0).Item("cip_minprc")
                    Else
                        newRow.Item("sod_itmprc") = dr_CUITMPRC_CustPO(0).Item("cip_basprc")
                    End If
                    newRow.Item("sod_basprc") = dr_CUITMPRC_CustPO(0).Item("cip_basprc")
                    'newRow.Item("sod_itmprc") = dr_CUITMPRC_CustPO(0).Item("cip_basprc")
                    newRow.Item("sod_inrdin") = dr_CUITMPRC_CustPO(0).Item("cis_inrdin")
                    newRow.Item("sod_inrwin") = dr_CUITMPRC_CustPO(0).Item("cis_inrwin")
                    newRow.Item("sod_inrhin") = dr_CUITMPRC_CustPO(0).Item("cis_inrhin")
                    newRow.Item("sod_mtrdin") = dr_CUITMPRC_CustPO(0).Item("cis_mtrdin")
                    newRow.Item("sod_mtrwin") = dr_CUITMPRC_CustPO(0).Item("cis_mtrwin")
                    newRow.Item("sod_mtrhin") = dr_CUITMPRC_CustPO(0).Item("cis_mtrhin")
                    newRow.Item("sod_inrdcm") = dr_CUITMPRC_CustPO(0).Item("cis_inrdcm")
                    newRow.Item("sod_inrwcm") = dr_CUITMPRC_CustPO(0).Item("cis_inrwcm")
                    newRow.Item("sod_inrhcm") = dr_CUITMPRC_CustPO(0).Item("cis_inrhcm")
                    newRow.Item("sod_mtrdcm") = dr_CUITMPRC_CustPO(0).Item("cis_mtrdcm")
                    newRow.Item("sod_mtrwcm") = dr_CUITMPRC_CustPO(0).Item("cis_mtrwcm")
                    newRow.Item("sod_mtrhcm") = dr_CUITMPRC_CustPO(0).Item("cis_mtrhcm")
                    'newRow.Item("sod_ctnstr") = 0
                    'newRow.Item("sod_ctnend") = 0
                    'newRow.Item("sod_ttlctn") = Integer.Parse(rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty") / dr_CUITMPRC_CustPO(0).Item("cis_mtrqty"))
                    newRow.Item("sod_tirtyp") = dr_CUITMPRC_CustPO(0).Item("cis_tirtyp")
                    'newRow.Item("sod_moq") = dr_CUITMPRC_CustPO(0).Item("cis_moq")
                    'newRow.Item("sod_moqunttyp") = dr_CUITMPRC_CustPO(0).Item("cis_moqunttyp")
                    newRow.Item("sod_selprc") = Format(dr_CUITMPRC_CustPO(0).Item("cis_selprc") * rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordqty"), "######0.0000")
                    'newRow.Item("sod_moa") = dr_CUITMPRC_CustPO(0).Item("cis_moa")
                    'newRow.Item("sod_rmk") = ""
                    'newRow.Item("sod_pormk") = ""
                    newRow.Item("sod_dv") = dr_CUITMPRC_CustPO(0).Item("cip_venno")
                    newRow.Item("sod_venno") = dr_CUITMPRC_CustPO(0).Item("cip_prdven")
                    newRow.Item("sod_cusven") = dr_CUITMPRC_CustPO(0).Item("cis_cusven")
                    newRow.Item("sod_tradeven") = dr_CUITMPRC_CustPO(0).Item("cis_tradeven")
                    newRow.Item("sod_examven") = dr_CUITMPRC_CustPO(0).Item("cis_examven")
                    'newRow.Item("sod_purord") = ""
                    'newRow.Item("sod_oldpurord") = ""
                    'newRow.Item("sod_purseq") = 0
                    newRow.Item("sod_venitm") = dr_CUITMPRC_CustPO(0).Item("ivi_venitm")
                    'newRow.Item("sod_clmno") = ""
                    newRow.Item("sod_itmsts") = Split(dr_CUITMPRC_CustPO(0).Item("ibi_itmsts"), " - ")(0)
                    'newRow.Item("sod_apprve") = "N"
                    'newRow.Item("sod_shpstr") = Format(Date.Now, "MM/dd/yyyy")
                    'newRow.Item("sod_shpend") = Format(Date.Now, "MM/dd/yyyy")
                    'newRow.Item("sod_candat") = Format(Date.Now, "MM/dd/yyyy")
                    'newRow.Item("sod_posstr") = ""
                    'newRow.Item("sod_posend") = ""
                    'newRow.Item("sod_poscan") = ""
                    newRow.Item("sod_fcurcde") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                    newRow.Item("sod_ftycst") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprc")
                    newRow.Item("sod_bomcst") = dr_CUITMPRC_CustPO(0).Item("cip_bomcst")
                    newRow.Item("sod_ftyprc") = Format(dr_CUITMPRC_CustPO(0).Item("cip_ftyprc") + dr_CUITMPRC_CustPO(0).Item("cip_bomcst"), "#0.0000")
                    newRow.Item("sod_orgfty") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprc")
                    newRow.Item("sod_ftyunt") = dr_CUITMPRC_CustPO(0).Item("cis_untcde")
                    newRow.Item("sod_ftycst_org") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprc")
                    newRow.Item("sod_bomcst_org") = dr_CUITMPRC_CustPO(0).Item("cip_bomcst")
                    newRow.Item("sod_ftyprc_org") = Format(dr_CUITMPRC_CustPO(0).Item("cip_ftyprc") + dr_CUITMPRC_CustPO(0).Item("cip_bomcst"), "#0.0000")
                    If dr_CUITMPRC_CustPO(0).Item("cis_itmventyp") = "E" Then
                        newRow.Item("sod_dvfcurcde") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                        newRow.Item("sod_dvftycst") = "9999.0000"
                        newRow.Item("sod_dvbomcst") = "9999.0000"
                        newRow.Item("sod_dvftyprc") = "9999.0000"
                        newRow.Item("sod_dvftyunt") = dr_CUITMPRC_CustPO(0).Item("cis_untcde")
                        newRow.Item("sod_dvftycst_org") = "9999.0000"
                        newRow.Item("sod_dvbomcst_org") = "9999.0000"
                        newRow.Item("sod_dvftyprc_org") = "9999.0000"
                        newRow.Item("sod_itmcstcur") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                        'newRow.Item("sod_dvitmcst") = "9999.0000"
                        newRow.Item("sod_dvitmcst") = dr_CUITMPRC_CustPO(0).Item("cip_ftycst")
                    Else
                        newRow.Item("sod_dvfcurcde") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                        newRow.Item("sod_dvftycst") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprc")
                        newRow.Item("sod_dvbomcst") = dr_CUITMPRC_CustPO(0).Item("cip_bomcst")
                        newRow.Item("sod_dvftyprc") = Format(dr_CUITMPRC_CustPO(0).Item("cip_ftyprc") + dr_CUITMPRC_CustPO(0).Item("cip_bomcst"), "#0.0000")
                        newRow.Item("sod_dvftyunt") = dr_CUITMPRC_CustPO(0).Item("cis_untcde")
                        newRow.Item("sod_dvftycst_org") = dr_CUITMPRC_CustPO(0).Item("cip_ftyprc")
                        newRow.Item("sod_dvbomcst_org") = dr_CUITMPRC_CustPO(0).Item("cip_bomcst")
                        newRow.Item("sod_dvftyprc_org") = Format(dr_CUITMPRC_CustPO(0).Item("cip_ftyprc") + dr_CUITMPRC_CustPO(0).Item("cip_bomcst"), "#0.0000")
                        newRow.Item("sod_itmcstcur") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                        newRow.Item("sod_dvitmcst") = dr_CUITMPRC_CustPO(0).Item("cip_ftycst")
                    End If

                    'newRow.Item("sod_hrmcde") = dr_CUITMPRC_CustPO(0).Item("cis_hrmcde")
                    'newRow.Item("sod_dtyrat") = Format(dr_CUITMPRC_CustPO(0).Item("cis_dtyrat"), "0.###")
                    'newRow.Item("sod_dept") = dr_CUITMPRC_CustPO(0).Item("cis_dept")
                    'newRow.Item("sod_typcode") = dr_CUITMPRC_CustPO(0).Item("cis_typcode")
                    'newRow.Item("sod_code1") = dr_CUITMPRC_CustPO(0).Item("cis_code1")
                    'newRow.Item("sod_code2") = dr_CUITMPRC_CustPO(0).Item("cis_code2")
                    'newRow.Item("sod_code3") = dr_CUITMPRC_CustPO(0).Item("cis_code3")
                    'newRow.Item("sod_cususdcur") = dr_CUITMPRC_CustPO(0).Item("cis_cususdcur")
                    'newRow.Item("sod_cususd") = dr_CUITMPRC_CustPO(0).Item("cis_cususd")
                    'newRow.Item("sod_cuscadcur") = dr_CUITMPRC_CustPO(0).Item("cis_cuscadcur")
                    'newRow.Item("sod_cuscad") = dr_CUITMPRC_CustPO(0).Item("cis_cuscad")
                    'newRow.Item("sod_alsitmno") = dr_CUITMPRC_CustPO(0).Item("ibi_alsitmno")
                    'newRow.Item("sod_alscolcde") = dr_CUITMPRC_CustPO(0).Item("ibi_alscolcde")
                    newRow.Item("sod_conftr") = dr_CUITMPRC_CustPO(0).Item("cis_conftr")
                    newRow.Item("sod_contopc") = dr_CUITMPRC_CustPO(0).Item("cis_contopc")
                    newRow.Item("sod_pcprc") = Format(dr_CUITMPRC_CustPO(0).Item("cis_selprc") / dr_CUITMPRC_CustPO(0).Item("cis_conftr"), "######0.0000")
                    'newRow.Item("sod_custum") = ""
                    'newRow.Item("sod_invqty") = 0
                    'newRow.Item("sod_orgmoqchg") = 0

                    ' Check Customer MOQ Charge
                    gspStr = "sp_select_CUPRCINF '" & cboCoCde.Text & "','" & Split(cboPanCopyCustPriCust.Text, " - ")(0) & "'"
                    rs = Nothing
                    Me.Cursor = Windows.Forms.Cursors.WaitCursor
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    Me.Cursor = Windows.Forms.Cursors.Default
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on loading SCM00001 #126 sp_select_CUPRCINF : " & rtnStr)
                        Exit Sub
                    Else
                        If rs.Tables("RESULT").Rows.Count > 0 Then
                            If rs.Tables("RESULT").Rows(0)("cpi_moqchgflg") = "Y" And dr_CUITMPRC_CustPO(0).Item("cis_tirtyp").ToString = "1" Then
                                newRow.Item("sod_cusmoqchg") = "Y"
                            Else
                                newRow.Item("sod_cusmoqchg") = "N"
                            End If
                        Else
                            newRow.Item("sod_cusmoqchg") = "N"
                        End If
                    End If

                    ' Check Vendor MOQ Charge
                    gspStr = "sp_select_VNBASINF '" & cboCoCde.Text & "','" & dr_CUITMPRC_CustPO(0).Item("cip_prdven") & "'"
                    rs = Nothing
                    Me.Cursor = Windows.Forms.Cursors.WaitCursor
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    Me.Cursor = Windows.Forms.Cursors.Default
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on loading SCM00001 #127 sp_select_VNBASINF : " & rtnStr)
                        Exit Sub
                    End If

                    If rs.Tables("RESULT").Rows.Count > 0 Then
                        If rs.Tables("RESULT").Rows(0)("vbi_moqchg") = "Y" Then
                            newRow.Item("sod_venmoqchg") = "Y"
                        Else
                            newRow.Item("sod_venmoqchg") = "N"
                        End If
                    Else
                        newRow.Item("sod_venmoqchg") = "N"
                    End If

                    newRow.Item("sod_orgvenno") = dr_CUITMPRC_CustPO(0).Item("cip_prdven")
                    newRow.Item("sod_ztnvbeln") = ""
                    newRow.Item("sod_ztnposnr") = ""
                    newRow.Item("sod_zorvbeln") = ""
                    newRow.Item("sod_zorposnr") = ""
                    newRow.Item("sod_qutdat") = dr_CUITMPRC_CustPO(0).Item("cip_qutdat")
                    newRow.Item("sod_imqutdat") = dr_CUITMPRC_CustPO(0).Item("cip_imqutdat")
                    newRow.Item("sod_imqutdat_org") = dr_CUITMPRC_CustPO(0).Item("cip_imqutdat")
                    newRow.Item("sod_imqutdatchg") = "N"
                    newRow.Item("sod_venno_org") = dr_CUITMPRC_CustPO(0).Item("cip_prdven")
                    newRow.Item("sod_fcurcde_org") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                    newRow.Item("sod_dvfcurcde_org") = dr_CUITMPRC_CustPO(0).Item("cip_fcurcde")
                    newRow.Item("sod_year") = dr_CUITMPRC_CustPO(0).Item("cis_year")
                    newRow.Item("sod_season") = dr_CUITMPRC_CustPO(0).Item("cis_season")
                    'newRow.Item("sod_tordno") = ""
                    'newRow.Item("sod_tordseq") = ""
                    'newRow.Item("sod_creusr") = "~*ADD*~"
                    ''''
                    'newRow.Item("sod_assitmcount") = 0

                    rs_SCORDDTL_CustPOChgOK.Tables("RESULT").Rows.Add(newRow)
                    copyOrdSeq += 1
                End If
            End If
        Next

        lblPanCustPOChg_Count.Text = totalCopy_CustPO & " of " & totalR_CustPO
        lblPanCustPOChg_Fail.Text = totalFail_CustPO & " of " & totalR_CustPO
        pBarPanCustPOChg.Value += 1

        dgCustPOChgValid.DataSource = rs_SCORDDTL_CustPOChgOK.Tables("RESULT").DefaultView
        display_CustPOValid()
        dgCustPOChgInvalid.DataSource = rs_SCORDDTL_CustPOChgFail.Tables("RESULT").DefaultView
        display_CustPOInvalid()

        If rs_SCORDDTL_CustPOChgOK.Tables("RESULT").Rows.Count = rs_SCORDDTL_ori.Tables("RESULT").Rows.Count Then
            cmdPanCustPOChg_Change.Enabled = True

            If copyNotLatest > 0 Then
                If copyNotLatest = totalR_CustPO Then
                    MsgBox("All of the items do not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Customer PO Date Change")
                ElseIf copyNotLatest = 1 Then
                    MsgBox("One of the items does not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Customer PO Date Change")
                ElseIf copyNotLatest > 1 Then
                    MsgBox("More than one of the items do not have the most recent CIH price", MsgBoxStyle.Information, "SCM00001 - Customer PO Date Change")
                End If
            End If
        Else
            cmdPanCustPOChg_Change.Enabled = False
            MsgBox("Not all items are allowed to change Customer PO Date")
        End If
    End Sub

    Private Sub display_CustPOValid()
        With dgCustPOChgValid
            For i As Integer = 0 To rs_SCORDDTL_CustPOChgOK.Tables("RESULT").Columns.Count - 1
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Select Case i
                    Case 7
                        .Columns(i).HeaderText = "PV"
                        .Columns(i).Width = 150
                        .Columns(i).ReadOnly = True
                    Case 15
                        .Columns(i).HeaderText = "Item #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 16
                        .Columns(i).HeaderText = "Cust Sty #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 17
                        .Columns(i).HeaderText = "Cust Itm #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 18
                        .Columns(i).HeaderText = "Cust SKU #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 25
                        .Columns(i).HeaderText = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/TranTrm)"
                        .Columns(i).Width = 350
                        .Columns(i).ReadOnly = True
                    Case 41
                        .Columns(i).HeaderText = "Color Desc"
                        .Columns(i).Width = 250
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
            .ClearSelection()
        End With
    End Sub

    Private Sub display_CustPOInvalid()
        With dgCustPOChgInvalid
            For i As Integer = 0 To rs_SCORDDTL_CustPOChgFail.Tables("RESULT").Columns.Count - 1
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Select Case i
                    Case 7
                        .Columns(i).HeaderText = "PV"
                        .Columns(i).Width = 150
                        .Columns(i).ReadOnly = True
                    Case 15
                        .Columns(i).HeaderText = "Item #"
                        .Columns(i).Width = 120
                        .Columns(i).ReadOnly = True
                    Case 25
                        .Columns(i).HeaderText = "(Color/UM/Inner/Master/CFT/CBM/FTY PrcTrm/HK PrcTrm/TranTrm)"
                        .Columns(i).Width = 350
                        .Columns(i).ReadOnly = True
                    Case 41
                        .Columns(i).HeaderText = "Reason"
                        .Columns(i).Width = 250
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
            Next
            .ClearSelection()
        End With
    End Sub

    Private Sub cmdPanCustPO_Change_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCustPOChg_Change.Click
        rs_SCORDDTL = rs_SCORDDTL_CustPOChgOK.Copy()
        txtCustPoDat.Text = txtPanCustPO_NewDat.Text

        recordStatus = True
        recordStatus_dtl = True

        cmdPanCustPOChg_Cancel.PerformClick()
    End Sub

    Private Sub cmdPanCustPO_Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPanCustPOChg_Cancel.Click
        release_TabControl()
        grpHeader.Enabled = True
        panCustPOChg.Visible = False
    End Sub

    Private Sub dgSCShpDat_EditingControlShowing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgSCShpDat.EditingControlShowing
        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgSCShpDat.CurrentCell.ColumnIndex
            Case dgDtlShpDat_SCFrom, dgDtlShpDat_SCTo, dgDtlShpDat_POFrom, dgDtlShpDat_POTo
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    AddHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress
                    'AddHandler txtbox.TextChanged, AddressOf txt_dgSummary_TextChanged
                End If
            Case Else
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress
                End If
        End Select
    End Sub

    Private Sub txt_datagridDates_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        If e.KeyChar = vbBack Or (dgSCShpDat.CurrentCell.ColumnIndex <> dgDtlShpDat_SCFrom And dgSCShpDat.CurrentCell.ColumnIndex <> dgDtlShpDat_SCTo And _
                                  dgSCShpDat.CurrentCell.ColumnIndex <> dgDtlShpDat_POFrom And dgSCShpDat.CurrentCell.ColumnIndex <> dgDtlShpDat_POTo) Then
            Exit Sub
        End If

        Dim curvalue As String = sender.Text.ToString

        If curvalue = "" Then
            Exit Sub
        ElseIf curvalue.Length = 10 Then
            e.KeyChar = ""
        ElseIf Split(sender.Text, "/").Length > 2 And e.KeyChar = "/" Then
            e.KeyChar = ""
        End If

        If Replace(curvalue, "/", "").Length = 2 Then
            If sender.Text.ToString.Substring(sender.Text.Length - 1, 1) <> "/" Then
                sender.Text = sender.Text + "/"
            End If
            sender.Select(sender.Text.Length, 0)
        ElseIf Replace(curvalue, "/", "").Length = 4 Then
            If sender.Text.ToString.Substring(sender.Text.Length - 1, 1) <> "/" Then
                sender.Text = sender.Text + "/"
            End If
            sender.Select(sender.Text.Length, 0)
        End If
    End Sub

    Private Sub custRetailCurChange_dtl(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboRetailUSDCur.SelectionChangeCommitted, cboRetailCADCur.SelectionChangeCommitted
        recordStatus = True
        recordStatus_dtl = True
    End Sub

    Private Sub dgMatBrkdwn_CellValidated(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMatBrkdwn.CellValidated
        If e.ColumnIndex = dgMatBrkDwn_CstPer Then
            dgMatBrkdwn.CurrentRow.Cells("scb_curcde").Value = lblSelprcCur.Text
            dgMatBrkdwn.CurrentRow.Cells("scb_cst").Value = CDbl(txtUntPrc.Text) * (dgMatBrkdwn.CurrentRow.Cells("scb_cstpct").Value / 100)
        End If
    End Sub

    Private Sub dgMatBrkdwn_RowValidating(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles dgMatBrkdwn.RowValidating
        If cmdPanMatBrkdwnCancel.Focused = True Or panMatBrkdwn.Visible = False Then
            Exit Sub
        End If

        If dgMatBrkdwn.CurrentRow.Cells("scb_status").Value <> "Y" Then
            If dgMatBrkdwn.CurrentRow.Cells("scb_cstpct").Value = 0 And dgMatBrkdwn.CurrentRow.Cells("scb_pct").Value = 0 Then
                e.Cancel = True
                MsgBox("Material must have either Cost Percentage or Weight Percentrage", MsgBoxStyle.Information, "SCM00001 - Material Breakdown")
            End If
        End If
    End Sub

    Private Sub dgSCShpDat_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles dgSCShpDat.KeyDown
        If e.KeyValue = 46 Then
            If Not dgSCShpDat.CurrentRow Is Nothing Then
                If dgSCShpDat.SelectedCells.Count = 1 Then
                    If dgSCShpDat.CurrentCell.ColumnIndex = dgDtlShpDat_SCFrom Or dgSCShpDat.CurrentCell.ColumnIndex = dgDtlShpDat_SCTo Or _
                    dgSCShpDat.CurrentCell.ColumnIndex = dgDtlShpDat_POFrom Or dgSCShpDat.CurrentCell.ColumnIndex = dgDtlShpDat_POTo Then
                        dgSCShpDat.CurrentCell.Value = ""
                    End If
                End If
            End If
        End If
    End Sub

    Private Function updateCUCPTBKD(ByVal i As Integer, ByVal flag As Boolean) As Boolean
        If flag = True Then
            Return True
        End If

        If clearCUCPTBKD(Split(cboPriCust.Text, " - ")(0), Split(cboSecCust.Text, " - ")(0), rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_itmno"), rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_colcde")) = False Then
            MsgBox("An error as occured during the saving process for CIH Material Breakdown." & Environment.NewLine & _
                   "Please contact your administrator for further detail", MsgBoxStyle.Critical, "SCM00001 - Saving")
            Return False
        Else
            Dim drSCCPTBKD() As DataRow = rs_SCCPTBKD.Tables("RESULT").Select("scb_ordseq = '" & rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_ordseq") & "' and scb_status <> 'Y'")
            If drSCCPTBKD.Length > 0 Then
                For j As Integer = 0 To drSCCPTBKD.Length - 1
                    ' Insert Material Breakdown Components into CUCPTBKD
                    gspStr = "sp_insert_CUCPTBKD '" & cboCoCde.Text & "','" & Split(cboPriCust.Text, " - ")(0) & "','" & _
                             Split(cboSecCust.Text, " - ")(0) & "','" & rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_itmno") & _
                             "','" & rs_SCORDDTL.Tables("RESULT").Rows(i)("sod_colcde") & "','" & UCase(drSCCPTBKD(j)("scb_cpt")) & _
                             "','" & drSCCPTBKD(j)("scb_curcde") & "','" & drSCCPTBKD(j)("scb_cst") & "','" & _
                             drSCCPTBKD(j)("scb_cstpct") & "','" & drSCCPTBKD(j)("scb_pct") & "','" & LCase(gsUsrID) & "'"
                    rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    If rtnLong <> RC_SUCCESS Then
                        MsgBox("Error on saving SCM00001 #142 sp_insert_CUCPTBKD : " & rtnStr)
                        Return False
                    End If
                Next
            End If
            Return True
        End If
    End Function

    Private Function clearCUCPTBKD(ByVal cus1no As String, ByVal cus2no As String, ByVal itmno As String, ByVal colcde As String) As Boolean
        ' Remove all Material Breakdown Components in CUCPTBKD
        ' Returns True when successfully deleted, False Otherwise
        gspStr = "sp_physical_delete_CUCPTBKD '" & cboCoCde.Text & "','" & cus1no & "','" & cus2no & "','" & itmno & "','" & colcde & "','" & LCase(gsUsrID) & "'"
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on deleting SCM00001 #141 sp_physical_delete_CUCPTBKD : " & rtnStr)
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub txtPanSumPODatesSeqFrom_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPanSumPODatesSeqFrom.TextChanged
        txtPanSumPODatesSeqTo.Text = txtPanSumPODatesSeqFrom.Text
    End Sub

    Private Function check_CopyAssorted(ByVal itmno As String) As Boolean
        Dim rsIMBOMASS As DataSet

        gspStr = "sp_select_IMBOMASS_SC '" & cboPanCopyCustCoCde.Text & "','" & itmno & "','" & _
                                     Split(cboPanCopyCustPriCust.Text, " - ")(0) & "'"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rsIMBOMASS, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading SCM00001 #142 sp_select_IMBOMASS_SC : " & rtnStr)
        End If

        Dim dr() As DataRow
        For i As Integer = 0 To rsIMBOMASS.Tables("RESULT").Rows.Count - 1
            dr = Nothing
            dr = rs_SCASSINF_ori.Tables("RESULT").Select("sai_assitm = '" & rsIMBOMASS.Tables("RESULT").Rows(i)("iba_assitm") & "' and " & _
                                                         "sai_colcde = '" & rsIMBOMASS.Tables("RESULT").Rows(i)("iba_colcde") & "' and " & _
                                                         "sai_untcde = '" & rsIMBOMASS.Tables("RESULT").Rows(i)("iba_pckunt") & "' and " & _
                                                         "sai_inrqty = '" & rsIMBOMASS.Tables("RESULT").Rows(i)("iba_inrqty") & "' and " & _
                                                         "sai_mtrqty = '" & rsIMBOMASS.Tables("RESULT").Rows(i)("iba_mtrqty") & "'")
            If dr.Length = 0 Then
                Return False
            End If
        Next
        Return True
    End Function
End Class