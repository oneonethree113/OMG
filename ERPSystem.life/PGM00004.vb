﻿Public Class PGM00004
    Dim Enq_right_local As Boolean
    Dim Del_right_local As Boolean
    Dim mode As String
    Dim rs_CUBASINF_P As DataSet
    Dim rs_CUBASINF_S As DataSet
    Dim rs_SYPAKCAT As DataSet
    Dim rs_PKIMBAIF As DataSet
    Dim Add_flag As Boolean = False
    Dim recordstatus As Boolean = False
    Dim rs_TOSCHEADER As DataSet
    Dim rs_TOSCDETAIL As DataSet
    Dim rs_PKORDDTL As DataSet
    Dim rs_VNBASINF As DataSet
    Dim rs_VNBASINF_02 As DataSet
    Dim pkgtype As String
    Dim MouseClickCbo As Boolean
    Dim rs_PKORDHDR As DataSet
    Dim rs_VNCNTINF As DataSet
    Dim rs_VNCTNPER As DataSet
    Dim rs_PKDISPRM As DataSet
    Dim rs_SYDISPRM As DataSet
    Dim rs_PKDISPRM_P As DataSet
    Dim rs_PKDISPRM_D As DataSet
    Dim rs_PKREPORD As DataSet

    Public FrmPGM00001 As PGM00001
    Public FrmPGM00007 As PGM00007

    Dim dgPkgITem_cocde As Integer
    Dim dgPkgITem_ordno As Integer
    Dim dgPkgITem_seq As Integer
    Dim dgPkgITem_realitem As Integer
    Dim dgPkgITem_tempitem As Integer
    Dim dgPkgITem_venno As Integer
    Dim dgPkgITem_venitem As Integer
    Dim dgPkgITem_stqty As Integer
    Dim dgPkgItem_colcde As Integer
    Dim dgPkgITem_um As Integer
    Dim dgPkgITem_inr As Integer
    Dim dgPkgITem_mst As Integer
    Dim dgPkgITem_ftyprctrm As Integer
    Dim dgPkgITem_hkprctrm As Integer
    Dim dgPkgITem_trantrm As Integer
    Dim dgPkgITem_Terms As Integer
    Dim dgPkgITem_curcde As Integer
    Dim dgPkgITem_Scno As Integer
    Dim dgPkgITem_ScSeq As Integer
    Dim dgPkgITem_ScItem As Integer
    Dim dgPkgItem_ScQty As Integer

    Dim dgPKORDDTL_pod_cocde As Integer
    Dim dgPKORDDTL_pod_ordno As Integer
    Dim dgPKORDDTL_pod_seq As Integer
    Dim dgPKORDDTL_pod_status As Integer
    Dim dgPKORDDTL_pod_itemno As Integer
    Dim dgPKORDDTL_pod_tmpitmno As Integer
    Dim dgPKORDDTL_pod_venno As Integer
    Dim dgPKORDDTL_pod_venitm As Integer
    Dim dgPKORDDTL_pod_pckunt As Integer
    Dim dgPKORDDTL_pod_inrqty As Integer
    Dim dgPKORDDTL_pod_mtrqty As Integer
    Dim dgPKORDDTL_pod_cft As Integer
    Dim dgPKORDDTL_pod_ftyprctrm As Integer
    Dim dgPKORDDTL_pod_hkprctrm As Integer
    Dim dgPKORDDTL_pod_trantrm As Integer
    Dim dgPKORDDTL_pod_pkgitm As Integer
    Dim dgPKORDDTL_pod_pkgven As Integer
    Dim dgPKORDDTL_pod_cate As Integer
    Dim dgPKORDDTL_pod_chndsc As Integer
    Dim dgPKORDDTL_pod_engdsc As Integer
    Dim dgPKORDDTL_pod_remark As Integer
    Dim dgPKORDDTL_pod_EInchL As Integer
    Dim dgPKORDDTL_pod_EInchW As Integer
    Dim dgPKORDDTL_pod_EInchH As Integer
    Dim dgPKORDDTL_pod_EcmL As Integer
    Dim dgPKORDDTL_pod_EcmW As Integer
    Dim dgPKORDDTL_pod_EcmH As Integer
    Dim dgPKORDDTL_pod_FInchL As Integer
    Dim dgPKORDDTL_pod_FinchW As Integer
    Dim dgPKORDDTL_pod_FinchH As Integer
    Dim dgPKORDDTL_pod_FcmL As Integer
    Dim dgPKORDDTL_pod_FcmW As Integer
    Dim dgPKORDDTL_pod_FcmH As Integer
    Dim dgPKORDDTL_pod_matral As Integer
    Dim dgPKORDDTL_pod_tiknes As Integer
    Dim dgPKORDDTL_pod_prtmtd As Integer
    Dim dgPKORDDTL_pod_clrfot As Integer
    Dim dgPKORDDTL_pod_clrbck As Integer
    Dim dgPKORDDTL_pod_finish As Integer
    Dim dgPKORDDTL_pod_rmtnce As Integer
    Dim dgPKORDDTL_pod_addres_fty As Integer
    Dim dgPKORDDTL_pod_state_fty As Integer
    Dim dgPKORDDTL_pod_cntry_fty As Integer
    Dim dgPKORDDTL_pod_zip_fty As Integer
    Dim dgPKORDDTL_pod_Tel_fty As Integer
    Dim dgPKORDDTL_pod_cntper_fty As Integer
    Dim dgPKORDDTL_pod_sctoqty As Integer
    Dim dgPKORDDTL_pod_qtyum As Integer
    Dim dgPKORDDTL_pod_curcde As Integer
    Dim dgPKORDDTL_pod_multip As Integer
    Dim dgPKORDDTL_pod_ordqty As Integer
    Dim dgPKORDDTL_pod_wasper As Integer
    Dim dgPKORDDTL_pod_wasqty As Integer
    Dim dgPKORDDTL_pod_ttlordqty As Integer
    Dim dgPKORDDTL_pod_untprc As Integer
    Dim dgPKORDDTL_pod_ttlamtqty As Integer
    Dim dgPKORDDTL_pod_receqty As Integer
    Dim dgPKORDDTL_pod_Reqno As Integer
    Dim dgPKORDDTL_pod_Reqseq As Integer
    Dim dgPKORDDTL_pod_creusr As Integer
    Dim dgPKORDDTL_pod_updusr As Integer
    Dim dgPKORDDTL_pod_credat As Integer
    Dim dgPKORDDTL_pod_upddat As Integer
    Dim dgPKORDDTL_pod_timstp As Integer
    Dim dgPKORDDTL_pod_stkqty As Integer
    Dim dgPKORDDTL_pod_Conmak As Integer
    Dim dgPKORDDTL_pod_finfot As Integer
    Dim dgPKORDDTL_pod_finbck As Integer
    Dim dgPKORDDTL_pod_matDsc As Integer
    Dim dgPKORDDTL_pod_tikDsc As Integer
    Dim dgPKORDDTL_pod_prtDsc As Integer
    Dim dgPKORDDTL_pod_bonqty As Integer
    Dim dgPKORDDTL_pod_shpstr As Integer
    Dim dgPKORDDTL_pod_shpend As Integer
    Dim dgPKORDDTL_pod_fty As Integer
    Dim dgPKORDDTL_pod_InWas As Integer
    Dim dgPKORDDTL_pod_MOA As Integer


    Dim Got_Focus_Grid As String

    Public FrmPGM00003 As PGM00003

    Dim rs_pkordrec As DataSet
    Dim rs_syswasge As DataSet
    Dim flag_panpack_keypress As Boolean = False


    Dim rs_PKINVHDR As DataSet
    Dim rs_PKMLTSHP As DataSet

    Dim rdoflag As Boolean

    Public FrmPGM00008 As PGM00008
    Dim rs_VNBASINF_MS As DataSet

    Dim rs_ListPkinvhdr As DataSet
    Dim rs_Pkreqdtl As DataSet
    Dim flag_cboDtlFty_GotFocus As Boolean

    Dim cboHdrAdd_fty_GotFocus_flag As Boolean
    Dim txtHdrSta_fty_GotFocus_flag As Boolean
    Dim txtHdrCty_fty_GotFocus_flag As Boolean
    Dim txtHdrzip_fty_GotFocus_flag As Boolean
    Dim cboHdrCtn_fty_GotFocus_flag As Boolean
    Dim txtHdrTel_fty_GotFocus_flag As Boolean


    Dim dgMltShpEditCellRow As Integer
    Dim dgMltShpEditCellCol As Integer

    Dim flag_disply As Boolean

    Dim mmdPrint_Right As Boolean = False
    Dim mmdFunction_Right As Boolean = False

    Private Sub PGM00004_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call AccessRight("PGM00008")
        mmdFunction_Right = Enq_right
        Call AccessRight("PGM00007")
        mmdPrint_Right = Enq_right



        Call Formstartup(Me.Name)
        Call AccessRight(Me.Name)

        Enq_right_local = Enq_right
        Del_right_local = Del_right


        gspStr = "sp_list_VNBASINF_NOT_PD ''"
        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF_MS, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading PGM00004_Load sp_list_VNBASINF :" & rtnStr)
            Exit Sub
        End If





        gspStr = "sp_list_VNBASINF_PKG04 ''"
        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF_02, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_VNBASINF :" & rtnStr)
            Exit Sub
        End If

        Call FillCompCombo(gsUsrID, cbococde)

        Format_cboStatus()
        format_Fty()
        Format_cboUM()

        mode = "INIT"
        formInit(mode)

        cbococde.SelectedIndex = 0
        recordstatus = False

        panelMoveTimer = New Timer()
        panelMoveTimer.Interval = 2
        panelMoveTimer.Enabled = True

        AddHandler panelMoveTimer.Tick, AddressOf panelMoveTimer_Tick
    End Sub

    Private Sub formInit(ByVal m As String)
        If m = "INIT" Then
            Call clearAllDisplay(Me)
        End If

        Call resetcmdButton(m)

        Call resetdisplay(m)

        'Me.StatusBar.Text = m
        SetStatusBar(m)

    End Sub

    Private Sub SetStatusBar(ByVal mode As String)

        If mode = "INIT" Then
            Me.StatusBar.Items("lblLeft").Text = "Init"
        ElseIf mode = "ADD" Then
            Me.StatusBar.Items("lblLeft").Text = "Add"
        ElseIf mode = "UPDATE" Then
            Me.StatusBar.Items("lblLeft").Text = "Updating"
        ElseIf mode = "Save" Then
            Me.StatusBar.Items("lblLeft").Text = "Record Saved"
        ElseIf mode = "DelRow" Then
            Me.StatusBar.Items("lblLeft").Text = "Record Row Deleted"
        ElseIf mode = "ReadOnly" Then
            Me.StatusBar.Items("lblLeft").Text = "Read Only"
        ElseIf mode = "Clear" Then
            Me.StatusBar.Items("lblLeft").Text = "Clear Screen"
        End If
    End Sub
    Private Sub resetcmdButton(ByVal Mode As String)
        If Mode = "INIT" Then
            mmdAdd.Enabled = False
            mmdSave.Enabled = False
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = True
            mmdInsRow.Enabled = False
            mmdDelRow.Enabled = False
            mmdExit.Enabled = True
            mmdClear.Enabled = True
            mmdSearch.Enabled = True


            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False
            'Add_flag = False



            '   cmdAddCat.Enabled = False '''

        ElseIf Mode = "DisableAll" Then 'For copy disable
            mmdAdd.Enabled = False
            mmdSave.Enabled = False
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdInsRow.Enabled = False
            mmdDelRow.Enabled = False
            mmdClear.Enabled = False
            mmdSearch.Enabled = False


            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False

            'txtVenNam.Enabled = False
            'txtVenChnNam.Enabled = False
            'chkfty.Enabled = False
            'txtVenSna.Enabled = False
            'chkDiCoTi.Enabled = False
            'chkActivate.Enabled = False
            'ChkMOQChg.Enabled = False




        End If

    End Sub


    Private Sub clearAllDisplay(ByVal fv As Control)
        Dim v As Control
        For Each v In fv.Controls

            If TypeOf v Is BaseTabControl Then
                Dim btc As BaseTabControl
                btc = v
                Dim i As Integer
                For i = 0 To btc.TabPages.Count - 1
                    Call clearAllDisplay(btc.TabPages(i))
                Next i
            ElseIf TypeOf v Is GroupBox Then
                Call clearAllDisplay(v)
                v.Enabled = False
            Else
                If TypeOf v Is TextBox Or TypeOf v Is MaskedTextBox Or TypeOf v Is ComboBox Or TypeOf v Is RichTextBox Then
                    v.Text = ""
                    v.Enabled = False
                ElseIf TypeOf v Is ListBox Then
                    Dim lb As ListBox
                    lb = v
                    lb.Items.Clear()
                    v.Enabled = False
                ElseIf TypeOf v Is CheckBox Then
                    Dim cb As CheckBox
                    cb = v
                    cb.Checked = False
                    v.Enabled = False
                ElseIf TypeOf v Is DataGridView Then
                    Dim dg As DataGridView
                    dg = v
                    dg.DataSource = Nothing
                End If
            End If
        Next v

    End Sub


    Private Sub Format_cboStatus()







        cboScStatus.Items.Clear()
        cboToStatus.Items.Clear()
        cboStatus.Items.Clear()

        cboScStatus.Items.Add("")
        cboScStatus.Items.Add("ACT - Active")
        cboScStatus.Items.Add("HLD - Waiting for Approval")
        cboScStatus.Items.Add("REL - Released")
        cboScStatus.Items.Add("CAN - Cancel")
        cboScStatus.Items.Add("CLO - Close")
        cboScStatus.Items.Add("OPE - Open")
        cboScStatus.Items.Add("REL - Released")
        cboScStatus.Items.Add("APV - Approved")

        cboToStatus.Items.Add("")
        cboToStatus.Items.Add("ACT - Active")
        cboToStatus.Items.Add("HLD - Waiting for Approval")
        cboToStatus.Items.Add("REL - Released")
        cboToStatus.Items.Add("CAN - Cancel")
        cboToStatus.Items.Add("CLO - Close")
        cboToStatus.Items.Add("OPE - Open")
        cboToStatus.Items.Add("REL - Released")
        cboToStatus.Items.Add("APV - Approved")

        cboStatus.Items.Add("")
        cboStatus.Items.Add("ACT - Active")
        cboStatus.Items.Add("HLD - Waiting for Approval")
        cboStatus.Items.Add("REL - Released")
        cboStatus.Items.Add("CAN - Cancel")
        cboStatus.Items.Add("CLO - Close")
        cboStatus.Items.Add("OPE - Open")
        cboStatus.Items.Add("REL - Released")
        cboStatus.Items.Add("APV - Approved")




    End Sub


    Private Sub Format_cboUM()


        cboOrdUm.Items.Clear()
        cboWastUm.Items.Clear()
        cboStkUm.Items.Clear()
        cboTtlUm.Items.Clear()

        'cboOrdUm.Items.Add("")
        'cboWastUm.Items.Add("")
        'cboStkUm.Items.Add("")
        'cboTtlUm.Items.Add("")

        cboOrdUm.Items.Add("PC")
        cboWastUm.Items.Add("PC")
        cboStkUm.Items.Add("PC")
        cboTtlUm.Items.Add("PC")

        cboOrdUm.Items.Add("SET")
        cboWastUm.Items.Add("SET")
        cboStkUm.Items.Add("SET")
        cboTtlUm.Items.Add("SET")

        cboOrdUm.Items.Add("ROLL")
        cboWastUm.Items.Add("ROLL")
        cboStkUm.Items.Add("ROLL")
        cboTtlUm.Items.Add("ROLL")

        cboOrdUm.Items.Add("YDS")
        cboWastUm.Items.Add("YDS")
        cboStkUm.Items.Add("YDS")
        cboTtlUm.Items.Add("YDS")

        cboOrdUm.Items.Add("METER")
        cboWastUm.Items.Add("METER")
        cboStkUm.Items.Add("METER")
        cboTtlUm.Items.Add("METER")

        cboTtlUm.Items.Add("KG")

    End Sub



    Private Sub format_Fty()
        cboDtlFty.Items.Clear()
        cboHdrFty.Items.Clear()
        cboDtlFty.Items.Add("")
        cboHdrFty.Items.Add("")
        Dim i As Integer
        Dim dr() As DataRow

        dr = rs_VNBASINF_MS.Tables("RESULT").Select("vbi_vensts = 'A'", "vbi_vensna")


        For i = 0 To dr.Length - 1
            'If rs_VNBASINF_MS.Tables("RESULT").Rows(i).Item("vbi_vensts") = "A" Then
            cboDtlFty.Items.Add(dr(i).Item("vbi_vensna") & " - " & dr(i).Item("vbi_venno"))
            cboHdrFty.Items.Add(dr(i).Item("vbi_vensna") & " - " & dr(i).Item("vbi_venno"))
            'End If
        Next i

    End Sub


    Private Sub display_combo_Specail(ByVal val As String, ByVal combo As ComboBox)

        If val = "" Then
            combo.Text = val
            Exit Sub
        End If

        Dim i As Integer

        For i = 0 To combo.Items.Count - 1
            If combo.Items(i).ToString <> "" Then
                Dim count As Integer
                Dim a As Array
                a = Split(combo.Items(i).ToString, " - ")
                count = a.Length - 1

                If val = Split(combo.Items(i), " - ")(count) Then
                    combo.Text = combo.Items(i)
                    Exit Sub
                End If
            End If
        Next i

        combo.Text = val
    End Sub

    Private Sub resetdisplay(ByVal mode As String)
        If mode = "INIT" Then



            Me.StatusBar.Items("lblLeft").Text = ""
            Me.StatusBar.Items("lblRight").Text = ""
            ' cbococde.Text = ""
            Panel1.Visible = False
            txtReqno.Text = ""
            txtVerno.Text = ""
            txtIssDate.Text = ""
            txtRevDate.Text = ""
            cboStatus.Text = ""
            cboPriCust.Text = ""
            cboSecCust.Text = ""
            txtToNo.Text = ""
            txtToVer.Text = ""
            cboToStatus.Text = ""
            txtToIssDate.Text = ""
            txtToRevDate.Text = ""
            txtRefQuot.Text = ""
            rdoPack.Checked = False
            rdoMock.Checked = False

            txtSalesDiv.Text = ""
            cboSalesRep.Text = ""
            txtScNo.Text = ""
            txtScVer.Text = ""
            cboScStatus.Text = ""
            txtScIssDat.Text = ""
            txtScRevDate.Text = ""
            txtCustPoDate.Text = ""
            txtScCancelDate.Text = ""
            txtScShipDateEnd.Text = ""
            txtScShipDateStr.Text = ""
            txtScRemark.Text = ""
            txtSeq.Text = ""
            txtItemNo.Text = ""
            txtTerms.Text = ""
            txtPkgItem.Text = ""
            cboPkgVendor.Text = ""
            txtCate.Text = ""
            cboRemi.Text = ""
            txtPkgChDesc.Text = ""
            txtPkgAddress.Text = ""
            txtPkgEnDesc.Text = ""
            txtPkgRemark.Text = ""
            txtPkgState.Text = ""
            txtPkgCtry.Text = ""
            txtZip.Text = ""
            txtTel.Text = ""
            cboPkgCtnPer.Text = ""
            txtPkgSTQty.Text = ""
            cboSTOUM.Text = ""
            txtPkgMult.Text = ""
            txtPkgOrdQty.Text = ""
            cboOrdUm.Text = ""
            txtPkgWastPer.Text = ""
            txtPkgWast.Text = ""
            cboWastUm.Text = ""
            txtPkgTtlQty.Text = ""
            cboTtlUm.Text = ""
            txtPkgUnitPriCur.Text = ""
            txtPkgUnitPri.Text = ""
            txtTtlAmtCur.Text = ""
            txtTtlAmt.Text = ""
            txtPkgRcive.Text = ""
            cboReceUm.Text = ""

            txtTerms.Text = ""

            txtEISizeH.Text = ""
            txtEISizeL.Text = ""
            txtEISizeW.Text = ""

            txtECSizeH.Text = ""
            txtECSizeL.Text = ""
            txtEISizeW.Text = ""

            txtFCSizeH.Text = ""
            txtFCSizeL.Text = ""
            txtFCSizeW.Text = ""
            txtFISizeH.Text = ""
            txtFISizeL.Text = ""
            txtFISizeW.Text = ""

            txtMatri.Text = ""
            txtTcknes.Text = ""
            txtPrtMtd.Text = ""
            txtForntCol.Text = ""
            txtBackCol.Text = ""
            txtFinish.Text = ""

            txtStkqty.Text = ""
            cboStkUm.Text = ""
            txtConRemark.Text = ""




            txtDvyDat.Text = ""
            txtDremark.Text = ""
            txtiremark.Text = ""
            cboHdrVen.Text = ""
            cboHdrRemi.Text = ""
            txtHdrAdd.Text = ""
            txtHdrSta.Text = ""
            txtHdrCty.Text = ""
            txtHdrzip.Text = ""
            txtHdrTel.Text = ""
            cboHdrCtn.Text = ""


            'txtForntFin.Text = ""
            'txtBackFin.Text = ""


            txtMatDsc.Text = ""
            txtTckDsc.Text = ""
            txtPrtDsc.Text = ""
            cboTabHdrVen.Text = ""


            txtHdrShpEnd.Text = ""
            txtHdrShpStr.Text = ""
            cboHdrFty.Text = ""
            txtDtlShpEnd.Text = ""
            txtDtlShpStr.Text = ""
            cboDtlFty.Text = ""
            txtBonQty.Text = ""

            txtHdrPriCur.Text = ""
            txtHdrTtlAmt.Text = ""

            txtInvStkQty.Text = ""
            txtMOQ.Text = ""

            cboHdrAdd.Text = ""
            cboHdrCtn.Text = ""
            txtPayTrm.Text = ""
            txtHdrDCCur.Text = ""
            txtHdrTACur.Text = ""
            txtHdrTACur_F.Text = ""
            txtHdrTA.Text = ""
            txtHdrTA_F.Text = ""
            txtHdrDC.Text = ""
            txtWasIn.Text = ""
            txtMOA.Text = ""
            txtMOACur.Text = ""
            txtReprtFlag.Text = ""


            ChkDel.Checked = False

            mmdSearch.Enabled = True
            mmdRel.Enabled = False


            cbococde.Enabled = True
            txtReqno.Enabled = True


            cmdRelease.Enabled = False
            cmdUnRelease.Enabled = False
            cmdReChose.Enabled = False
            cmdCloseOrd.Enabled = False
            cmdRePrint.Enabled = False
            cmdRepordAdd.Enabled = False
            cmdRepordDel.Enabled = False
            cmdRepordClose.Enabled = False


            freeze_TabControl(0)
            BaseTabControl1.SelectedIndex = 0

            mmdCancel.Enabled = False

            cmdCanOrd.Enabled = False
            PelReqdtl.Visible = False
            PelInvDtl.Visible = False
            cmdAttach.Enabled = False

            'lstCty.DataSource = Nothing
            'lstCty.Visible = False

            PanelRepord.Visible = False
            lstRepord.Items.Clear()

        ElseIf mode = "ReadOnly" Then
            Panel1.Visible = False
            cmdReChose.Enabled = False
            cbococde.Enabled = False
            txtReqno.Enabled = False
            txtVerno.Enabled = False
            txtIssDate.Enabled = False
            txtRevDate.Enabled = False
            cboStatus.Enabled = False
            cmdRelease.Enabled = True
            cmdUnRelease.Enabled = True
            cboPriCust.Enabled = False
            cboSecCust.Enabled = False
            txtToNo.Enabled = False
            txtToVer.Enabled = False
            cboToStatus.Enabled = False
            txtToIssDate.Enabled = False
            txtToRevDate.Enabled = False
            txtRefQuot.Enabled = False
            rdoMock.Enabled = False
            rdoPack.Enabled = False
            txtSalesDiv.Enabled = False
            cboSalesRep.Enabled = False
            txtScNo.Enabled = False
            txtScVer.Enabled = False
            cboScStatus.Enabled = False
            txtScIssDat.Enabled = False
            txtScRevDate.Enabled = False
            txtCustPoDate.Enabled = False
            txtScCancelDate.Enabled = False
            txtScShipDateEnd.Enabled = False
            txtScShipDateStr.Enabled = False
            txtScRemark.Enabled = False
            txtSeq.Enabled = False
            txtItemNo.Enabled = False
            txtTerms.Enabled = False
            txtPkgItem.Enabled = False
            txtCate.Enabled = False
            txtPkgChDesc.Enabled = False
            txtPkgEnDesc.Enabled = False
            txtPkgRemark.Enabled = False
            cboPkgVendor.Enabled = False
            cboRemi.Enabled = False
            txtPkgAddress.Enabled = False
            txtPkgState.Enabled = False
            txtPkgCtry.Enabled = False
            txtZip.Enabled = False
            txtTel.Enabled = False
            cboPkgCtnPer.Enabled = False
            txtEISizeH.Enabled = False
            txtEISizeL.Enabled = False
            txtEISizeW.Enabled = False
            txtECSizeH.Enabled = False
            txtECSizeL.Enabled = False
            txtECSizeW.Enabled = False
            txtFCSizeH.Enabled = False
            txtFCSizeL.Enabled = False
            txtFCSizeW.Enabled = False
            txtFISizeH.Enabled = False
            txtFISizeL.Enabled = False
            txtFISizeW.Enabled = False
            txtMatri.Enabled = False
            txtTcknes.Enabled = False
            txtPrtMtd.Enabled = False
            txtForntCol.Enabled = False
            txtBackCol.Enabled = False
            txtFinish.Enabled = False
            txtPkgSTQty.Enabled = False
            cboSTOUM.Enabled = False
            txtPkgMult.Enabled = False
            txtPkgOrdQty.Enabled = False
            txtPkgWastPer.Enabled = False
            txtPkgWast.Enabled = False
            txtPkgTtlQty.Enabled = False
            txtPkgUnitPri.Enabled = False
            txtTtlAmt.Enabled = False
            txtPkgRcive.Enabled = False
            cboOrdUm.Enabled = False
            cboWastUm.Enabled = False
            cboTtlUm.Enabled = False
            txtPkgUnitPriCur.Enabled = False
            txtTtlAmtCur.Enabled = False
            cboReceUm.Enabled = False
            ChkDel.Enabled = False
            txtReprtFlag.Enabled = False

            cmdBack.Enabled = True
            cmdNext.Enabled = True


            txtStkqty.Enabled = False
            cboStkUm.Enabled = False

            mmdFunction.Enabled = mmdFunction_Right


            mmdRel.Enabled = True
            mmdSearch.Enabled = False

            mmdPrint.Enabled = False

            mmdAdd.Enabled = False
            mmdSave.Enabled = Enq_right_local
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdClear.Enabled = True
            mmdInsRow.Enabled = False
            mmdExit.Enabled = True
            cmdCloseOrd.Enabled = False
            cmdRePrint.Enabled = False
            cmdRepordAdd.Enabled = False
            cmdRepordDel.Enabled = False
            cmdRepordClose.Enabled = False
            'txtForntFin.Enabled = False
            'txtBackFin.Enabled = False

            txtMatDsc.Enabled = False
            txtTckDsc.Enabled = False
            txtPrtDsc.Enabled = False

            rdoIn.Enabled = False
            rdoOut.Enabled = False


            txtHdrShpEnd.Enabled = False
            txtHdrShpStr.Enabled = False
            cboHdrFty.Enabled = False

            cboHdrAdd_fty.Enabled = False
            txtHdrSta_fty.Enabled = False
            txtHdrCty_fty.Enabled = False
            txtHdrzip_fty.Enabled = False
            cboHdrCtn_fty.Enabled = False
            txtHdrTel_fty.Enabled = False

            txtDtlShpEnd.Enabled = False
            txtDtlShpStr.Enabled = False
            cboDtlFty.Enabled = False
            cboHdrAdd_dtl.Enabled = False
            txtHdrSta_dtl.Enabled = False
            txtHdrCty_dtl.Enabled = False
            txtHdrzip_dtl.Enabled = False
            cboHdrCtn_dtl.Enabled = False
            txtHdrTel_dtl.Enabled = False


            cboHdrAdd_dtl.Enabled = False
            txtHdrSta_dtl.Enabled = False
            txtHdrCty_dtl.Enabled = False
            txtHdrzip_dtl.Enabled = False
            cboHdrCtn_dtl.Enabled = False
            txtHdrTel_dtl.Enabled = False

            txtBonQty.Enabled = False
            txtHdrPriCur.Enabled = False
            txtHdrTtlAmt.Enabled = False

            txtInvStkQty.Enabled = False
            txtMOQ.Enabled = False

            cmdShowReqdtl.Enabled = True
            cmdInvDetail.Enabled = True
            cmdCloseRequest.Enabled = True

            cmdAttach.Enabled = True
            cboHdrAdd.Enabled = False
            cboHdrCtn.Enabled = False

            cmdAttach.Enabled = False
            cmdRePrint.Enabled = True
            cmdRepordAdd.Enabled = False
            cmdRepordDel.Enabled = False
            cmdRepordClose.Enabled = True

            txtPayTrm.Enabled = False
            txtHdrDCCur.Enabled = False
            txtHdrTACur.Enabled = False
            txtHdrTACur_F.Enabled = False
            txtHdrTA.Enabled = False
            txtHdrTA_F.Enabled = False
            txtHdrDC.Enabled = False
            txtWasIn.Enabled = False
            txtMOA.Enabled = False
            txtMOACur.Enabled = False

            txtMOA.Text = ""
            txtMOACur.Text = ""
            txtWasIn.Text = ""
            txtHdrDC.Text = ""
            txtHdrDCCur.Text = ""
            txtHdrTACur.Text = ""
            txtHdrTACur_F.Text = ""
            txtHdrTA.Text = ""
            txtHdrTA_F.Text = ""
            txtPayTrm.Text = ""
            '  txtReqno.Text = ""
            txtVerno.Text = ""
            txtIssDate.Text = ""
            txtRevDate.Text = ""
            cboStatus.Text = ""
            cboPriCust.Text = ""
            cboSecCust.Text = ""
            txtToNo.Text = ""
            txtToVer.Text = ""
            cboToStatus.Text = ""
            txtToIssDate.Text = ""
            txtToRevDate.Text = ""
            txtRefQuot.Text = ""
            rdoPack.Checked = False
            rdoMock.Checked = False
            txtSalesDiv.Text = ""
            cboSalesRep.Text = ""
            txtScNo.Text = ""
            txtScVer.Text = ""
            cboScStatus.Text = ""
            txtScIssDat.Text = ""
            txtScRevDate.Text = ""
            txtCustPoDate.Text = ""
            txtScCancelDate.Text = ""
            txtScShipDateEnd.Text = ""
            txtScShipDateStr.Text = ""
            txtScRemark.Text = ""
            txtSeq.Text = ""
            txtItemNo.Text = ""
            txtTerms.Text = ""
            txtPkgItem.Text = ""
            cboPkgVendor.Text = ""
            txtCate.Text = ""
            cboRemi.Text = ""
            txtPkgChDesc.Text = ""
            txtPkgAddress.Text = ""
            txtPkgEnDesc.Text = ""
            txtPkgRemark.Text = ""
            txtPkgState.Text = ""
            txtPkgCtry.Text = ""
            txtZip.Text = ""
            txtTel.Text = ""
            cboPkgCtnPer.Text = ""
            txtPkgSTQty.Text = ""
            cboSTOUM.Text = ""
            txtPkgMult.Text = ""
            txtPkgOrdQty.Text = ""
            cboOrdUm.Text = ""
            txtPkgWastPer.Text = ""
            txtPkgWast.Text = ""
            cboWastUm.Text = ""
            txtPkgTtlQty.Text = ""
            cboTtlUm.Text = ""
            txtPkgUnitPriCur.Text = ""
            txtPkgUnitPri.Text = ""
            txtTtlAmtCur.Text = ""
            txtTtlAmt.Text = ""
            txtPkgRcive.Text = ""
            cboReceUm.Text = ""

            txtTerms.Text = ""

            txtEISizeH.Text = ""
            txtEISizeL.Text = ""
            txtEISizeW.Text = ""

            txtECSizeH.Text = ""
            txtECSizeL.Text = ""
            txtEISizeW.Text = ""

            txtFCSizeH.Text = ""
            txtFCSizeL.Text = ""
            txtFCSizeW.Text = ""
            txtFISizeH.Text = ""
            txtFISizeL.Text = ""
            txtFISizeW.Text = ""

            txtMatri.Text = ""
            txtTcknes.Text = ""
            txtPrtMtd.Text = ""
            txtForntCol.Text = ""
            txtBackCol.Text = ""
            txtFinish.Text = ""
            txtStkqty.Text = ""
            cboStkUm.Text = ""
            ChkDel.Checked = False

            txtConRemark.Enabled = False
            txtConRemark.Text = ""




            txtDvyDat.Text = ""
            txtDremark.Text = ""
            txtiremark.Text = ""
            cboHdrVen.Text = ""
            cboHdrRemi.Text = ""
            txtHdrAdd.Text = ""
            txtHdrSta.Text = ""
            txtHdrCty.Text = ""
            txtHdrzip.Text = ""
            txtHdrTel.Text = ""
            cboHdrCtn.Text = ""
            'txtForntFin.Text = ""
            'txtBackFin.Text = ""
            txtMatDsc.Text = ""
            txtTckDsc.Text = ""
            txtPrtDsc.Text = ""
            cboTabHdrVen.Text = ""


            txtHdrShpEnd.Text = ""
            txtHdrShpStr.Text = ""
            cboHdrFty.Text = ""
            txtDtlShpEnd.Text = ""
            txtDtlShpStr.Text = ""
            cboDtlFty.Text = ""
            txtBonQty.Text = ""
            txtHdrPriCur.Text = ""
            txtHdrTtlAmt.Text = ""
            cboHdrAdd.Text = ""
            cboHdrCtn.Text = ""
            txtReprtFlag.Text = ""

            txtDvyDat.Enabled = False
            txtDremark.Enabled = False
            txtiremark.Enabled = False
            cboHdrVen.Enabled = False
            cboHdrRemi.Enabled = False
            txtHdrAdd.Enabled = False
            txtHdrSta.Enabled = False
            txtHdrCty.Enabled = False
            txtHdrzip.Enabled = False
            txtHdrTel.Enabled = False
            cboHdrCtn.Enabled = False

            If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "CAN" Then

                cmdCanOrd.Enabled = False
                cmdRelease.Enabled = False

                mmdCancel.Enabled = False
                mmdRel.Enabled = False
            End If

            If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "CLO" Then
                cmdCanOrd.Enabled = False
                cmdRelease.Enabled = False

                mmdCancel.Enabled = False
                mmdRel.Enabled = False
            End If


            txtInvStkQty.Text = ""
            txtMOQ.Text = ""


            Call SetStatusBar(mode)

            PelReqdtl.Visible = False
            PanelRepord.Visible = False
            lstRepord.Items.Clear()

        ElseIf mode = "UPDATE" Then
            Panel1.Visible = False
            cmdReChose.Enabled = False
            cbococde.Enabled = False
            txtReqno.Enabled = False
            txtVerno.Enabled = False
            txtIssDate.Enabled = False
            txtRevDate.Enabled = False
            cboStatus.Enabled = False
            cmdRelease.Enabled = True
            cmdUnRelease.Enabled = True
            cboPriCust.Enabled = False
            cboSecCust.Enabled = False
            txtToNo.Enabled = False
            txtToVer.Enabled = False
            cboToStatus.Enabled = False
            txtToIssDate.Enabled = False
            txtToRevDate.Enabled = False
            txtRefQuot.Enabled = False
            rdoMock.Enabled = False
            rdoPack.Enabled = False
            txtSalesDiv.Enabled = False
            cboSalesRep.Enabled = False
            txtScNo.Enabled = False
            txtScVer.Enabled = False
            cboScStatus.Enabled = False
            txtScIssDat.Enabled = False
            txtScRevDate.Enabled = False
            txtCustPoDate.Enabled = False
            txtScCancelDate.Enabled = False
            txtScShipDateEnd.Enabled = False
            txtScShipDateStr.Enabled = False
            txtScRemark.Enabled = False
            txtSeq.Enabled = False
            txtItemNo.Enabled = False
            txtTerms.Enabled = False
            txtPkgItem.Enabled = False
            txtCate.Enabled = False
            txtPkgChDesc.Enabled = False
            txtPkgEnDesc.Enabled = False
            txtPkgRemark.Enabled = False
            cboPkgVendor.Enabled = False
            cboRemi.Enabled = False
            txtPkgAddress.Enabled = False
            txtPkgState.Enabled = False
            txtPkgCtry.Enabled = False
            txtZip.Enabled = False
            txtTel.Enabled = False
            cboPkgCtnPer.Enabled = False
            txtEISizeH.Enabled = False
            txtEISizeL.Enabled = False
            txtEISizeW.Enabled = False
            txtECSizeH.Enabled = False
            txtECSizeL.Enabled = False
            txtECSizeW.Enabled = False
            txtFCSizeH.Enabled = False
            txtFCSizeL.Enabled = False
            txtFCSizeW.Enabled = False
            txtFISizeH.Enabled = False
            txtFISizeL.Enabled = False
            txtFISizeW.Enabled = False
            txtMatri.Enabled = False
            txtTcknes.Enabled = False
            txtPrtMtd.Enabled = False
            txtForntCol.Enabled = False
            txtBackCol.Enabled = False
            txtFinish.Enabled = False
            txtPkgSTQty.Enabled = False
            cboSTOUM.Enabled = False
            txtPkgMult.Enabled = False
            txtPkgOrdQty.Enabled = False
            txtPkgWastPer.Enabled = False
            txtPkgWast.Enabled = False
            txtPkgTtlQty.Enabled = False
            txtPkgUnitPri.Enabled = False
            txtTtlAmt.Enabled = False
            txtPkgRcive.Enabled = False  '*
            cboOrdUm.Enabled = False
            cboWastUm.Enabled = False
            cboTtlUm.Enabled = True
            txtPkgUnitPriCur.Enabled = False
            txtTtlAmtCur.Enabled = False
            cboReceUm.Enabled = False
            ChkDel.Enabled = False


            cmdBack.Enabled = True
            cmdNext.Enabled = True

            mmdFunction.Enabled = mmdFunction_Right
            mmdRel.Enabled = True
            mmdSearch.Enabled = False



            mmdPrint.Enabled = mmdPrint_Right

            mmdAdd.Enabled = False
            mmdSave.Enabled = Enq_right_local
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdClear.Enabled = True

            mmdExit.Enabled = True
            mmdInsRow.Enabled = False
            cmdRePrint.Enabled = True
            cmdRepordAdd.Enabled = True
            cmdRepordDel.Enabled = True
            cmdRepordClose.Enabled = True
            'cmdCloseOrd.Enabled = True

            txtStkqty.Enabled = True
            cboStkUm.Enabled = False
            'txtForntFin.Enabled = False
            'txtBackFin.Enabled = False

            txtMatDsc.Enabled = False
            txtTckDsc.Enabled = False
            txtPrtDsc.Enabled = False



            rdoIn.Enabled = True
            rdoOut.Enabled = True


            txtHdrShpEnd.Enabled = True
            txtHdrShpStr.Enabled = True
            cboHdrFty.Enabled = True
            cboHdrAdd_fty.Enabled = True
            txtHdrSta_fty.Enabled = True
            txtHdrCty_fty.Enabled = True
            txtHdrzip_fty.Enabled = True
            cboHdrCtn_fty.Enabled = True
            txtHdrTel_fty.Enabled = True

            txtDtlShpEnd.Enabled = True
            txtDtlShpStr.Enabled = True
            cboDtlFty.Enabled = True
            cboHdrAdd_dtl.Enabled = True
            txtHdrSta_dtl.Enabled = True
            txtHdrCty_dtl.Enabled = True
            txtHdrzip_dtl.Enabled = True
            cboHdrCtn_dtl.Enabled = True
            txtHdrTel_dtl.Enabled = True
            txtBonQty.Enabled = True
            txtHdrPriCur.Enabled = False
            txtHdrTtlAmt.Enabled = False
            txtInvStkQty.Enabled = False
            txtMOQ.Enabled = False

            cmdShowReqdtl.Enabled = True
            cmdCloseRequest.Enabled = True
            cmdInvDetail.Enabled = True
            cmdAttach.Enabled = True
            cboHdrAdd.Enabled = True
            cboHdrCtn.Enabled = True

            cmdAttach.Enabled = True
            txtPayTrm.Enabled = False
            cmdCloseOrd.Enabled = False

            txtHdrDCCur.Enabled = False
            txtHdrTACur.Enabled = False
            txtHdrTACur_F.Enabled = False
            txtHdrTA.Enabled = False
            txtHdrTA_F.Enabled = False
            txtHdrDC.Enabled = True
            txtWasIn.Enabled = False
            txtMOA.Enabled = True
            txtMOACur.Enabled = False
            txtReprtFlag.Enabled = False

            txtReprtFlag.Text = ""
            txtMOA.Text = ""
            txtMOACur.Text = ""
            txtWasIn.Text = ""
            txtHdrDC.Text = ""

            txtHdrDCCur.Text = ""
            txtHdrTACur.Text = ""
            txtHdrTACur_F.Text = ""
            txtHdrTA.Text = ""
            txtHdrTA_F.Text = ""

            txtPayTrm.Text = ""
            'txtReqno.Text = ""
            txtVerno.Text = ""
            txtIssDate.Text = ""
            txtRevDate.Text = ""
            cboStatus.Text = ""
            cboPriCust.Text = ""
            cboSecCust.Text = ""
            txtToNo.Text = ""
            txtToVer.Text = ""
            cboToStatus.Text = ""
            txtToIssDate.Text = ""
            txtToRevDate.Text = ""
            txtRefQuot.Text = ""
            rdoPack.Checked = False
            rdoMock.Checked = False
            txtSalesDiv.Text = ""
            cboSalesRep.Text = ""
            txtScNo.Text = ""
            txtScVer.Text = ""
            cboScStatus.Text = ""
            txtScIssDat.Text = ""
            txtScRevDate.Text = ""
            txtCustPoDate.Text = ""
            txtScCancelDate.Text = ""
            txtScShipDateEnd.Text = ""
            txtScShipDateStr.Text = ""
            txtScRemark.Text = ""
            txtSeq.Text = ""
            txtItemNo.Text = ""
            txtTerms.Text = ""
            txtPkgItem.Text = ""
            cboPkgVendor.Text = ""
            txtCate.Text = ""
            cboRemi.Text = ""
            txtPkgChDesc.Text = ""
            txtPkgAddress.Text = ""
            txtPkgEnDesc.Text = ""
            txtPkgRemark.Text = ""
            txtPkgState.Text = ""
            txtPkgCtry.Text = ""
            txtZip.Text = ""
            txtTel.Text = ""
            cboPkgCtnPer.Text = ""
            txtPkgSTQty.Text = ""
            cboSTOUM.Text = ""
            txtPkgMult.Text = ""
            txtPkgOrdQty.Text = ""
            cboOrdUm.Text = ""
            txtPkgWastPer.Text = ""
            txtPkgWast.Text = ""
            cboWastUm.Text = ""
            txtPkgTtlQty.Text = ""
            cboTtlUm.Text = ""
            txtPkgUnitPriCur.Text = ""
            txtPkgUnitPri.Text = ""
            txtTtlAmtCur.Text = ""
            txtTtlAmt.Text = ""
            txtPkgRcive.Text = ""
            cboReceUm.Text = ""

            txtTerms.Text = ""

            txtEISizeH.Text = ""
            txtEISizeL.Text = ""
            txtEISizeW.Text = ""

            txtECSizeH.Text = ""
            txtECSizeL.Text = ""
            txtEISizeW.Text = ""

            txtFCSizeH.Text = ""
            txtFCSizeL.Text = ""
            txtFCSizeW.Text = ""
            txtFISizeH.Text = ""
            txtFISizeL.Text = ""
            txtFISizeW.Text = ""

            txtMatri.Text = ""
            txtTcknes.Text = ""
            txtPrtMtd.Text = ""
            txtForntCol.Text = ""
            txtBackCol.Text = ""
            txtFinish.Text = ""

            txtStkqty.Text = ""
            cboStkUm.Text = ""


            ChkDel.Checked = False

            txtConRemark.Text = ""
            txtConRemark.Enabled = True

            txtDvyDat.Text = ""
            txtDremark.Text = ""
            txtiremark.Text = ""
            cboHdrVen.Text = ""
            cboHdrRemi.Text = ""
            txtHdrAdd.Text = ""
            txtHdrSta.Text = ""
            txtHdrCty.Text = ""
            txtHdrzip.Text = ""
            txtHdrTel.Text = ""
            cboHdrCtn.Text = ""
            'txtForntFin.Text = ""
            'txtBackFin.Text = ""

            txtMatDsc.Text = ""
            txtTckDsc.Text = ""
            txtPrtDsc.Text = ""
            cboTabHdrVen.Text = ""



            txtHdrShpEnd.Text = ""
            txtHdrShpStr.Text = ""
            cboHdrFty.Text = ""
            txtDtlShpEnd.Text = ""
            txtDtlShpStr.Text = ""
            cboDtlFty.Text = ""
            txtBonQty.Text = ""

            txtHdrPriCur.Text = ""
            txtHdrTtlAmt.Text = ""

            txtInvStkQty.Text = ""
            txtMOQ.Text = ""
            cboHdrAdd.Text = ""
            cboHdrCtn.Text = ""

            txtDvyDat.Enabled = True
            txtDremark.Enabled = True
            txtiremark.Enabled = True
            cboHdrVen.Enabled = False
            cboHdrRemi.Enabled = False
            txtHdrAdd.Enabled = True
            txtHdrSta.Enabled = False
            txtHdrCty.Enabled = False
            txtHdrzip.Enabled = False
            txtHdrTel.Enabled = False
            cboHdrCtn.Enabled = True
            cmdCanOrd.Enabled = True
            Call SetStatusBar(mode)

            mmdCancel.Enabled = True

            PelReqdtl.Visible = False
            PanelRepord.Visible = False
            lstRepord.Items.Clear()

        ElseIf mode = "ADD" Then
            Panel1.Visible = False
            cmdReChose.Enabled = False
            cbococde.Enabled = False
            txtReqno.Enabled = False
            txtVerno.Enabled = False
            txtIssDate.Enabled = False
            txtRevDate.Enabled = False
            cboStatus.Enabled = False
            cmdRelease.Enabled = False
            cmdUnRelease.Enabled = False
            cboPriCust.Enabled = False
            cboSecCust.Enabled = False
            txtToNo.Enabled = True
            txtToVer.Enabled = False
            cboToStatus.Enabled = False
            txtToIssDate.Enabled = False
            txtToRevDate.Enabled = False
            txtRefQuot.Enabled = False
            rdoMock.Enabled = False
            rdoPack.Enabled = False
            txtSalesDiv.Enabled = False
            cboSalesRep.Enabled = False
            txtScNo.Enabled = True
            txtScVer.Enabled = False
            cboScStatus.Enabled = False
            txtScIssDat.Enabled = False
            txtScRevDate.Enabled = False
            txtCustPoDate.Enabled = False
            txtScCancelDate.Enabled = False
            txtScShipDateEnd.Enabled = False
            txtScShipDateStr.Enabled = False
            txtScRemark.Enabled = False
            txtSeq.Enabled = False
            txtItemNo.Enabled = False
            txtTerms.Enabled = False
            txtPkgItem.Enabled = False
            txtCate.Enabled = False
            txtPkgChDesc.Enabled = False
            txtPkgEnDesc.Enabled = False
            txtPkgRemark.Enabled = False
            cboPkgVendor.Enabled = False
            cboRemi.Enabled = False
            txtPkgAddress.Enabled = False
            txtPkgState.Enabled = False
            txtPkgCtry.Enabled = False
            txtZip.Enabled = False
            txtTel.Enabled = False
            cboPkgCtnPer.Enabled = False
            txtEISizeH.Enabled = False
            txtEISizeL.Enabled = False
            txtEISizeW.Enabled = False
            txtECSizeH.Enabled = False
            txtECSizeL.Enabled = False
            txtECSizeW.Enabled = False
            txtFCSizeH.Enabled = False
            txtFCSizeL.Enabled = False
            txtFCSizeW.Enabled = False
            txtFISizeH.Enabled = False
            txtFISizeL.Enabled = False
            txtFISizeW.Enabled = False
            txtMatri.Enabled = False
            txtTcknes.Enabled = False
            txtPrtMtd.Enabled = False
            txtForntCol.Enabled = False
            txtBackCol.Enabled = False
            txtFinish.Enabled = False
            txtPkgSTQty.Enabled = False
            cboSTOUM.Enabled = False
            txtPkgMult.Enabled = False
            txtPkgOrdQty.Enabled = False
            txtPkgWastPer.Enabled = False
            txtPkgWast.Enabled = False
            txtPkgTtlQty.Enabled = False
            txtPkgUnitPri.Enabled = False
            txtTtlAmt.Enabled = False
            txtPkgRcive.Enabled = False
            cboOrdUm.Enabled = False
            cboWastUm.Enabled = False
            cboTtlUm.Enabled = False
            txtPkgUnitPriCur.Enabled = False
            txtTtlAmtCur.Enabled = False
            cboReceUm.Enabled = False
            ChkDel.Enabled = True


            cmdBack.Enabled = True
            cmdNext.Enabled = True

            txtStkqty.Enabled = False
            cboStkUm.Enabled = False

            mmdRel.Enabled = False
            mmdSearch.Enabled = False



            mmdAdd.Enabled = False
            mmdSave.Enabled = False
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdClear.Enabled = True
            mmdInsRow.Enabled = False
            mmdExit.Enabled = True
            'txtForntFin.Enabled = False
            'txtBackFin.Enabled = False

            txtMatDsc.Enabled = False
            txtTckDsc.Enabled = False
            txtPrtDsc.Enabled = False
            cmdInvDetail.Enabled = True

            rdoIn.Enabled = False
            rdoOut.Enabled = False

            txtHdrShpEnd.Enabled = True
            txtHdrShpStr.Enabled = True
            cboHdrFty.Enabled = True
            cboHdrAdd_fty.Enabled = True
            txtHdrSta_fty.Enabled = True
            txtHdrCty_fty.Enabled = True
            txtHdrzip_fty.Enabled = True
            cboHdrCtn_fty.Enabled = True
            txtHdrTel_fty.Enabled = True

            txtDtlShpEnd.Enabled = True
            txtDtlShpStr.Enabled = True
            cboDtlFty.Enabled = True
            cboHdrAdd_dtl.Enabled = True
            txtHdrSta_dtl.Enabled = True
            txtHdrCty_dtl.Enabled = True
            txtHdrzip_dtl.Enabled = True
            cboHdrCtn_dtl.Enabled = True
            txtHdrTel_dtl.Enabled = True

            txtBonQty.Enabled = True

            cmdAttach.Enabled = True
            txtWasIn.Enabled = False
            txtMOA.Enabled = True
            txtMOACur.Enabled = False

            txtReprtFlag.Enabled = False
            txtReprtFlag.Text = ""
            txtMOA.Text = ""
            txtMOACur.Text = ""
            txtWasIn.Text = ""
            txtReqno.Text = ""
            txtVerno.Text = ""
            txtIssDate.Text = ""
            txtRevDate.Text = ""
            cboStatus.Text = ""
            cboPriCust.Text = ""
            cboSecCust.Text = ""
            txtToNo.Text = ""
            txtToVer.Text = ""
            cboToStatus.Text = ""
            txtToIssDate.Text = ""
            txtToRevDate.Text = ""
            txtRefQuot.Text = ""
            rdoPack.Checked = False
            rdoMock.Checked = False
            txtSalesDiv.Text = ""
            cboSalesRep.Text = ""
            txtScNo.Text = ""
            txtScVer.Text = ""
            cboScStatus.Text = ""
            txtScIssDat.Text = ""
            txtScRevDate.Text = ""
            txtCustPoDate.Text = ""
            txtScCancelDate.Text = ""
            txtScShipDateEnd.Text = ""
            txtScShipDateStr.Text = ""
            txtScRemark.Text = ""
            txtSeq.Text = ""
            txtItemNo.Text = ""
            txtTerms.Text = ""
            txtPkgItem.Text = ""
            cboPkgVendor.Text = ""
            txtCate.Text = ""
            cboRemi.Text = ""
            txtPkgChDesc.Text = ""
            txtPkgAddress.Text = ""
            txtPkgEnDesc.Text = ""
            txtPkgRemark.Text = ""
            txtPkgState.Text = ""
            txtPkgCtry.Text = ""
            txtZip.Text = ""
            txtTel.Text = ""
            cboPkgCtnPer.Text = ""
            txtPkgSTQty.Text = ""
            cboSTOUM.Text = ""
            txtPkgMult.Text = ""
            txtPkgOrdQty.Text = ""
            cboOrdUm.Text = ""
            txtPkgWastPer.Text = ""
            txtPkgWast.Text = ""
            cboWastUm.Text = ""
            txtPkgTtlQty.Text = ""
            cboTtlUm.Text = ""
            txtPkgUnitPriCur.Text = ""
            txtPkgUnitPri.Text = ""
            txtTtlAmtCur.Text = ""
            txtTtlAmt.Text = ""
            txtPkgRcive.Text = ""
            cboReceUm.Text = ""

            txtTerms.Text = ""

            txtEISizeH.Text = ""
            txtEISizeL.Text = ""
            txtEISizeW.Text = ""

            txtECSizeH.Text = ""
            txtECSizeL.Text = ""
            txtEISizeW.Text = ""

            txtFCSizeH.Text = ""
            txtFCSizeL.Text = ""
            txtFCSizeW.Text = ""
            txtFISizeH.Text = ""
            txtFISizeL.Text = ""
            txtFISizeW.Text = ""

            txtMatri.Text = ""
            txtTcknes.Text = ""
            txtPrtMtd.Text = ""
            txtForntCol.Text = ""
            txtBackCol.Text = ""
            txtFinish.Text = ""
            ChkDel.Checked = False

            txtStkqty.Text = ""
            cboStkUm.Text = ""

            txtConRemark.Text = ""




            txtDvyDat.Text = ""
            txtDremark.Text = ""
            txtiremark.Text = ""
            cboHdrVen.Text = ""
            cboHdrRemi.Text = ""
            txtHdrAdd.Text = ""
            txtHdrSta.Text = ""
            txtHdrCty.Text = ""
            txtHdrzip.Text = ""
            txtHdrTel.Text = ""
            cboHdrCtn.Text = ""
            'txtForntFin.Text = ""
            'txtBackFin.Text = ""
            txtMatDsc.Text = ""
            txtTckDsc.Text = ""
            txtPrtDsc.Text = ""
            cboTabHdrVen.Text = ""




            txtHdrShpEnd.Text = ""
            txtHdrShpStr.Text = ""
            cboHdrFty.Text = ""
            txtDtlShpEnd.Text = ""
            txtDtlShpStr.Text = ""
            cboDtlFty.Text = ""
            txtBonQty.Text = ""


            txtDvyDat.Enabled = False
            txtDremark.Enabled = False
            txtiremark.Enabled = False
            cboHdrVen.Enabled = False
            cboHdrRemi.Enabled = False
            txtHdrAdd.Enabled = False
            txtHdrSta.Enabled = False
            txtHdrCty.Enabled = False
            txtHdrzip.Enabled = False
            txtHdrTel.Enabled = False
            cboHdrCtn.Enabled = False
            cmdCanOrd.Enabled = True

            mmdCancel.Enabled = True

            Call SetStatusBar(mode)

            Me.BaseTabControl1.TabPages(0).Enabled = True
            Me.BaseTabControl1.TabPages(1).Enabled = False

            PanelRepord.Visible = False
            lstRepord.Items.Clear()

        End If



    End Sub


    Private Sub freeze_TabControl(ByVal tabpageno As Integer)
        Dim i As Integer
        For i = 0 To BaseTabControl1.TabPages.Count - 1
            If i = tabpageno Then
                Me.BaseTabControl1.TabPages(i).Enabled = True
            Else
                Me.BaseTabControl1.TabPages(i).Enabled = False
            End If
        Next i
    End Sub


    Public Sub mmdFind_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdFind.Click
        Cursor = Cursors.WaitCursor
        flag_cboDtlFty_GotFocus = False


        If (Trim(txtReqno.Text) = "" And txtReqno.Enabled = True) Then
            If txtReqno.Enabled And txtReqno.Visible Then
                txtReqno.Select()
                MsgBox("Pls input Order No.")
                Cursor = Cursors.Default
                Exit Sub
            End If
        End If

        txtReqno.Text = txtReqno.Text.ToUpper


        gsCompany = Trim(cbococde.Text)
        Call Update_gs_Value(gsCompany)


        gspStr = "sp_select_PKORDHDR '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_PKORDHDR, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKORDHDR :" & rtnStr)
            Exit Sub
        End If



        If rs_PKORDHDR.Tables("RESULT").Rows.Count <> 1 Then
            MsgBox("Order not found!")
            txtReqno.Select()
            Cursor = Cursors.Default
            Exit Sub
        End If


        gspStr = " sp_select_PKORDDTL '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_PKORDDTL, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKORDDTL :" & rtnStr)
            Exit Sub
        End If


        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            MsgBox("Order have no detail!")
            txtReqno.Select()
            Cursor = Cursors.Default
            Exit Sub
        End If


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Columns.Count - 1
            rs_PKORDDTL.Tables("RESULT").Columns(i).ReadOnly = False

        Next

        For i As Integer = 0 To rs_PKORDHDR.Tables("RESULT").Columns.Count - 1
            rs_PKORDHDR.Tables("RESULT").Columns(i).ReadOnly = False

        Next



        gspStr = "sp_list_VNBASINF_PD ''"
        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_VNBASINF_PD :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_list_VNBASINF_PKG04 ''"
        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF_02, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_VNBASINF_PKG04 :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKORDREC '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_pkordrec, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKORDREC :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKMTLSHP '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_PKMLTSHP, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKMLTSHP :" & rtnStr)
            Exit Sub
        End If




        gspStr = "sp_list_pkwasge_02 ''"
        rtnLong = execute_SQLStatement(gspStr, rs_syswasge, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_pkwasge :" & rtnStr)
            Exit Sub
        End If




        gspStr = "sp_select_PKINVDTL ''"
        rtnLong = execute_SQLStatement(gspStr, rs_PKINVHDR, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_PKINVHDR :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_list_PKINVHDR ''"
        rtnLong = execute_SQLStatement(gspStr, rs_ListPkinvhdr, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_PKINVHDR :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_list_SYPAKCAT"
        rtnLong = execute_SQLStatement(gspStr, rs_SYPAKCAT, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_PKINVHDR :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKREQDTL_04 '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_Pkreqdtl, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_list_PKINVHDR :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_VNCNTINF_PG04 '','" & Split(rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_pkgven"), " - ")(0) & "'"
        'gspStr = "sp_select_VNCNTINF_PG04 '','3007'" ' & Split(rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_pkgven"), " - ")(0) & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_VNCNTINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_VNCNTINF_PG04 :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_VNCTNPER_PG04 '','" & Split(rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_pkgven"), " - ")(0) & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_VNCTNPER, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_VNCTNPER_PG04 :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKDISPRM '" & cbococde.Text & "','" & txtReqno.Text & "','P'"
        rtnLong = execute_SQLStatement(gspStr, rs_PKDISPRM_P, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKDISPRM(P) :" & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKDISPRM '" & cbococde.Text & "','" & txtReqno.Text & "','D'"
        rtnLong = execute_SQLStatement(gspStr, rs_PKDISPRM_D, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            Cursor = Cursors.Default
            MsgBox("Error on loading cmdFind_Click sp_select_PKDISPRM(D) :" & rtnStr)
            Exit Sub
        End If



        gspStr = "sp_select_SYDISPRM_ALL"
        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_SYDISPRM, rtnStr)
        Me.Cursor = Windows.Forms.Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading cmdFind_Click sp_select_SYDISPRM_ALL : " & rtnStr)
            Exit Sub
        End If


        gspStr = "sp_select_PKREPORD '" & cbococde.Text & "','" & txtReqno.Text & "'"
        Me.Cursor = Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_PKREPORD, rtnStr)
        Me.Cursor = Cursors.Default
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading cmdFind_Click sp_select_PKREPORD : " & rtnStr)
            Exit Sub
        End If

        For i As Integer = 0 To rs_PKREPORD.Tables("RESULT").Columns.Count - 1
            rs_PKREPORD.Tables("RESULT").Columns(i).ReadOnly = False
        Next



        Format_cboStatus()
        format_VendorCombo()
        format_VendorAddress()
        format_ContactPerson()
        Format_cboUM()


        If Enq_right_local = True Then
            mode = "UPDATE"
            'mode = "ReadOnly"
        Else
            mode = "ReadOnly"
        End If

        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "CLO" Or _
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "REL" Or _
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Or _
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "CAN" Then
            mode = "ReadOnly"

        End If


        Dim SOTO As String

        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToNo").ToString <> "" Then
        '    SOTO = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToNo").ToString

        '    gspStr = "sp_select_TOORDDTL_PKG02 '" & cbococde.Text & "','" & SOTO & "'"
        '    rtnLong = execute_SQLStatement(gspStr, rs_TOSCDETAIL, rtnStr)
        '    If rtnLong <> RC_SUCCESS Then
        '        Cursor = Cursors.Default
        '        MsgBox("Error on loading cmdFind_Click sp_select_TOORDDTL_PKG02 :" & rtnStr)
        '        Exit Sub
        '    End If


        '    gspStr = "sp_select_TOORDHDR_PKG02 '" & cbococde.Text & "','" & SOTO & "'"
        '    rtnLong = execute_SQLStatement(gspStr, rs_TOSCHEADER, rtnStr)
        '    If rtnLong <> RC_SUCCESS Then
        '        Cursor = Cursors.Default
        '        MsgBox("Error on loading cmdFind_Click sp_select_TOORDHDR_PKG02 :" & rtnStr)
        '        Exit Sub
        '    End If

        '    'SetdgSCTO_TO()

        'Else
        '    SOTO = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScNo").ToString


        '    gspStr = "sp_select_SCORDDTL_PKG02 '" & cbococde.Text & "','" & SOTO & "'"
        '    rtnLong = execute_SQLStatement(gspStr, rs_TOSCDETAIL, rtnStr)
        '    If rtnLong <> RC_SUCCESS Then
        '        Cursor = Cursors.Default
        '        MsgBox("Error on loading cmdFind_Click sp_select_SCORDDTL_PKG02 :" & rtnStr)
        '        Exit Sub
        '    End If



        '    gspStr = "sp_select_SCORDHDR_PKG02 '" & cbococde.Text & "','" & SOTO & "'"
        '    rtnLong = execute_SQLStatement(gspStr, rs_TOSCHEADER, rtnStr)
        '    If rtnLong <> RC_SUCCESS Then
        '        Cursor = Cursors.Default
        '        MsgBox("Error on loading cmdFind_Click sp_select_SCORDHDR_PKG02 :" & rtnStr)
        '        Exit Sub
        '    End If


        '    'SetdgSCTO_SC()

        'End If



        Me.BaseTabControl1.TabPages(1).Enabled = True
        Me.BaseTabControl1.TabPages(2).Enabled = True

        'SetdgPkgITem()

        resetdisplay(mode) 'do


        display_REQUEST()

        display_PKREQDTL(0)

        display_dgPKORDDTL()

        display_dgPKGoodRec(1)

        display_dgMLTSHP(1)

        display_dgReqdtl(1)

        display_dgDis()

        display_dgPre()



        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "CLO" Or _
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
            cmdRelease.Enabled = False
            mmdRel.Enabled = False
        End If

        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "REL" Or _
        '    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "OPE" Or _
        '    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
        '    cmdCloseOrd.Enabled = True
        'End If


        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
            cmdCloseOrd.Enabled = True
        End If



        recordstatus = False
        MouseClickCbo = False

        Cursor = Cursors.Default

    End Sub

    Private Sub txtReqno_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtReqno.KeyPress
        If e.KeyChar.Equals(Chr(13)) Then
            Call mmdFind_Click(sender, e)
        End If
    End Sub

    Private Sub txtReqno_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtReqno.TextChanged

    End Sub


    Private Sub format_VendorCombo()
        Dim i As Integer
        Dim strList As String

        cboPkgVendor.Items.Clear()
        cboPkgVendor.Items.Add("")
        cboHdrVen.Items.Clear()
        cboHdrVen.Items.Add("")
        cboTabHdrVen.Items.Clear()
        cboTabHdrVen.Items.Add("")

        If rs_VNBASINF.Tables("RESULT").Rows.Count > 0 Then
            For i = 0 To rs_VNBASINF.Tables("RESULT").Rows.Count - 1
                strList = rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_vensna")
                If strList <> "" Then
                    cboPkgVendor.Items.Add(strList)
                    cboHdrVen.Items.Add(strList)
                    cboTabHdrVen.Items.Add(strList)
                End If
            Next i
        End If
    End Sub


    Private Sub format_VendorAddress()
        Dim i As Integer
        Dim strList As String

        cboHdrAdd.Items.Clear()
        cboHdrAdd.Items.Add("")



        If rs_VNCNTINF.Tables("RESULT").Rows.Count > 0 Then
            For i = 0 To rs_VNCNTINF.Tables("RESULT").Rows.Count - 1
                strList = rs_VNCNTINF.Tables("RESULT").Rows(i).Item("vci_adr")
                If strList <> "" Then
                    cboHdrAdd.Items.Add(strList)

                End If
            Next i
        End If
    End Sub

    Private Sub format_ContactPerson()
        Dim i As Integer
        Dim strList As String

        cboHdrCtn.Items.Clear()
        cboHdrCtn.Items.Add("")

        If rs_VNCTNPER.Tables("RESULT").Rows.Count > 0 Then
            For i = 0 To rs_VNCTNPER.Tables("RESULT").Rows.Count - 1
                strList = rs_VNCTNPER.Tables("RESULT").Rows(i).Item("vci_cntctp")
                If strList <> "" Then
                    cboHdrCtn.Items.Add(strList)
                End If
            Next
        End If

    End Sub




    Private Sub display_REQUEST()

        If rs_PKORDHDR.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub
        End If

        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub
        End If

        'txtVerno.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ver")
        txtIssDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_issdat")
        txtRevDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_revdat")

        display_combo(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status"), cboStatus)

        If cboStatus.Text.Split(" -")(0) = "APV" Then
            mmdPrint.Enabled = mmdPrint_Right
        Else
            mmdPrint.Enabled = False
        End If


        'cboPriCust.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cus1no") + " - " + rs_PKORDHDR.Tables("RESULT").Rows(0).Item("cus1name")
        ''cboSecCust.Text = rs_TOSCHEADER.Tables("RESULT").Rows(0).Item("toh_cus2no")
        'cboPriCust.Text = ""

        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cus2no") <> "" Then
        '    cboSecCust.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cus2no") + " - " + rs_PKORDHDR.Tables("RESULT").Rows(0).Item("cus2name")
        'Else
        '    cboSecCust.Text = ""
        'End If
        'cboSecCust.Text = ""


        'txtSalesDiv.Text = "Division " + rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_saldiv") + _
        '      " (TEAM " + rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_saltem") + ")"

        'txtSalesDiv.Text = ""

        'cboSalesRep.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_salrep").ToString
        'txtToNo.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToNo")
        'txtToVer.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToVer")

        '' cboToStatus.Text = rs_TOSCHEADER.Tables("RESULT").Rows(0).Item("toh_ordsts")


        'display_combo(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToSts"), cboToStatus)


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToIsdat").ToString <> "01/01/1900" Then
        '    txtToIssDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToIsdat")
        'Else
        '    txtToIssDate.Text = ""
        'End If


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToRevdat").ToString <> "01/01/1900" Then
        '    txtToRevDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToRevdat")
        'Else
        '    txtToRevDate.Text = ""

        'End If

        'txtRefQuot.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ToRefqut")




        'txtScNo.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScNo")
        'txtScVer.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScVer")

        'display_combo(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScSts"), cboScStatus)






        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScIsdat").ToString <> "01/01/1900" Then
        '    txtScIssDat.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScIsdat")
        'Else
        '    txtScIssDat.Text = ""
        'End If


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScRevdat").ToString <> "01/01/1900" Then
        '    txtScRevDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScRevdat")
        'Else
        '    txtScRevDate.Text = ""
        'End If


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScPodat").ToString <> "01/01/1900" Then
        '    txtCustPoDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScPodat")
        'Else
        '    txtCustPoDate.Text = ""
        'End If


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScCandat").ToString <> "01/01/1900" Then

        '    txtScCancelDate.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScCandat")
        'Else
        '    txtScCancelDate.Text = ""
        'End If


        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScShpdatend") <> "01/01/1900" Then
        '    txtScShipDateEnd.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScShpdatend")
        'Else
        '    txtScShipDateEnd.Text = ""
        'End If



        'If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScShpdatstr") <> "01/01/1900" Then
        '    txtScShipDateStr.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScShpdatstr")
        'Else
        '    txtScShipDateStr.Text = ""
        'End If


        'txtScRemark.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ScRemark")

        txtReprtFlag.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_reprtflg")

        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_dvydat") = "01/01/1900" Then
            txtDvyDat.Text = ""
        Else
            txtDvyDat.Text = Format(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_dvydat"), "MM/dd/yyyy")
        End If


        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_shpstr") = "01/01/1900" Then
            txtHdrShpStr.Text = ""
        Else
            txtHdrShpStr.Text = Format(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_shpstr"), "MM/dd/yyyy")
        End If


        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_shpend") = "01/01/1900" Then
            txtHdrShpEnd.Text = ""
        Else
            txtHdrShpEnd.Text = Format(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_shpend"), "MM/dd/yyyy")
        End If


        display_combo_Specail(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_fty"), cboHdrFty)
        cboHdrCtn.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ctnper")


        txtDremark.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_dremark")
        txtiremark.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_iremark")

        display_combo(rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_pkgven"), cboHdrVen)
        display_combo(rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_pkgven"), cboTabHdrVen)
        cboHdrRemi.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_rmtnce")

        txtHdrAdd.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_address").ToString
        display_combo(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_address").ToString, cboHdrAdd)

        txtHdrSta.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_state")
        txtHdrCty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cntry")
        txtHdrzip.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_zip")
        txtHdrTel.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_tel")
        'cboHdrCtn.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_cntper_fty")

        display_combo(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_address_fty").ToString, cboHdrAdd_fty)

        txtHdrSta_fty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_state_fty")
        txtHdrCty_fty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cntry_fty")
        txtHdrzip_fty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_zip_fty")
        txtHdrTel_fty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_tel_fty")
        cboHdrCtn_fty.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_cntper_fty")

        Dim ttlpri As Decimal

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA") <> 0 Then
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA"), 2)
            Else
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty"), 2)
            End If

        Next

        txtHdrTtlAmt.Text = ttlpri
        txtHdrPriCur.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_curcde").ToString
        txtHdrDCCur.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_curcde").ToString
        txtHdrTACur.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_curcde").ToString
        txtHdrTACur_F.Text = rs_PKORDDTL.Tables("RESULT").Rows(0).Item("pod_curcde").ToString

        txtHdrDC.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_Delamt")
        txtHdrTA.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_TtlDelamt")
        txtHdrTA_F.Text = ttlpri + rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_Delamt")


        txtVerno.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_ver")

        txtPayTrm.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("vbi_paytrm")

        txtGenFlag.Text = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_GenFlag").ToString

        txtGenType.Text = UCase(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_GenType").ToString)




        Me.StatusBar.Items("lblRight").Text = Convert.ToDateTime(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_credat")).ToString("dd/MM/yyyy") & " " _
     & Convert.ToDateTime(rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_upddat")).ToString("dd/MM/yyyy") _
     & " " & rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_updusr")



        ' dgSCTO.DataSource = rs_TOSCHEADER.Tables("RESULT").DefaultView

    End Sub


    Private Sub display_PKREQDTL(ByVal Specseq As Integer)
        flag_disply = True

        Dim loc As Integer = Specseq
        'loc = -1

        'Dim i As Integer
        'i = 0

        'Dim seq As Integer

        'For i = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
        '    seq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")


        '    If Specseq = seq Then
        '        loc = i
        '        Exit For
        '    End If
        'Next i

        'If loc = -1 Then
        '    MsgBox("Request detail not found!")
        '    Exit Sub
        'End If


        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cocde") = cbococde.Text
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_reqno") = ""
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_seq") = txtSeq.Text
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_itemno") = realitem
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_tmpitmno") = tmpitem
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_venno") = venno
        ''rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_venitm") = venitem
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pckunt") = PackUnt
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_inrqty") = inr
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_mtrqty") = master
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ftyprctrm") = ftyprctrm
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_hkprctrm") = hkprctrm
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_trantrm") = trantrm

        txtSeq.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_seq")

        txtItemNo.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_itemno") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_tmpitmno") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_venitm") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_venno")

        txtTerms.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pckunt") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_inrqty") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_mtrqty") & " / " & _
                             rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cft") & " / " & _
                            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ftyprctrm") & " / " & _
                              rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_hkprctrm") & " / " & _
                              rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_trantrm")



        txtPkgItem.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pkgitm").ToString

        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pkgven") = Split(cboPkgVendor.Text, " - ")(0)

        display_combo(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pkgven"), cboPkgVendor)


        txtCate.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cate") '*

        txtDtlSts.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_status")

        txtPkgChDesc.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_chndsc")
        txtPkgEnDesc.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_engdsc")
        txtPkgRemark.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_remark")
        txtEISizeL.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EInchL")
        txtEISizeW.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EInchW")
        txtEISizeH.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EInchH")
        txtECSizeL.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EcmL")
        txtECSizeW.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EcmW")
        txtECSizeH.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_EcmH")
        txtFISizeL.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FInchL")
        txtFISizeW.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FinchW")
        txtFISizeH.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FinchH")
        txtFCSizeL.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FcmL")
        txtFCSizeW.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FcmW")
        txtFCSizeH.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_FcmH")
        txtMatri.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_matral")
        txtTcknes.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_tiknes")
        txtPrtMtd.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_prtmtd")
        txtForntCol.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_clrfot")
        txtBackCol.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_clrbck")
        txtFinish.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_finish")
        cboRemi.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_rmtnce")
        txtPkgAddress.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_addres_fty")
        txtPkgState.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_state_fty")
        txtPkgCtry.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntry_fty")
        txtZip.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_zip_fty")
        txtTel.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_Tel_fty")
        cboPkgCtnPer.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntper_fty")
        txtPkgSTQty.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_sctoqty")
        cboSTOUM.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum")
        txtPkgUnitPriCur.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_curcde")
        txtPkgMult.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_multip")
        txtPkgOrdQty.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ordqty")

        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasper").ToString <> "" Then
            If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasper") <> 0 Then
                txtPkgWastPer.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasper")
            Else
                txtPkgWastPer.Text = ""
            End If
        Else
            txtPkgWastPer.Text = ""
        End If
        txtPkgWast.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasqty")
        txtPkgTtlQty.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ttlordqty")
        txtPkgUnitPri.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_untprc")
        txtTtlAmt.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ttlamtqty")
        txtTtlAmtCur.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_curcde")
        cboOrdUm.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") '"PC"
        cboWastUm.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") '"PC"
        cboTtlUm.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") '"PC"
        cboReceUm.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") '"PC"
        cboStkUm.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") '"PC"



        txtStkqty.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_stkqty")

        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_stkqty") >= 0 Then
            rdoIn.Checked = True
            rdoOut.Checked = False
        Else
            rdoIn.Checked = False
            rdoOut.Checked = True
        End If

        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_receqty") = 1 '*
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") = cbococde.Text

        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") <> "~*ADD*~" Then
            cmdReChose.Enabled = False
        Else
            cmdReChose.Enabled = True
        End If

        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") = "~*DEL*~" Or _
           rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") = "~*NEW*~" Then
            ChkDel.Checked = True
        Else
            ChkDel.Checked = False
        End If

        txtConRemark.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_Conmak")
        'txtForntFin.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_finfot")
        'txtBackFin.Text  = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_finbck")
        txtMatDsc.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_matDsc")
        txtTckDsc.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_tikDsc")
        txtPrtDsc.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_prtDsc")


        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpstr") = "01/01/1900" Then
            txtDtlShpStr.Text = ""
        Else
            txtDtlShpStr.Text = Format(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpstr"), "MM/dd/yyyy")
        End If


        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpend") = "01/01/1900" Then
            txtDtlShpEnd.Text = ""
        Else
            txtDtlShpEnd.Text = Format(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpend"), "MM/dd/yyyy")
        End If


        display_combo_Specail(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_fty"), cboDtlFty)
        If InStr(cboDtlFty.Text.Trim, "-") <> 0 Then
            cboHdrAdd_dtl.Items.Clear()
            cboHdrCtn_dtl.Items.Clear()
            Dim dr() As DataRow
            dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(cboDtlFty.Text.Trim, " - ")(1) & "'")
            If dr.Length <> 0 Then
                For j As Integer = 0 To dr.Length - 1
                    cboHdrAdd_dtl.Items.Add(dr(j)("vci_address").ToString)
                Next
                For j As Integer = 0 To dr.Length - 1
                    cboHdrCtn_dtl.Items.Add(dr(j)("vci_cntctp").ToString)
                Next
            End If
        End If
        ''con cbo

        display_combo_Specail(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_addres_fty"), cboHdrAdd_dtl)
        txtHdrSta_dtl.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_state_fty")
        txtHdrCty_dtl.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntry_fty")
        txtHdrzip_dtl.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_zip_fty")
        cboHdrCtn_dtl.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntper_fty")
        txtHdrTel_dtl.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_Tel_fty")



        txtBonQty.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_Bonqty")






        If loc = rs_PKORDDTL.Tables("RESULT").Rows.Count - 1 Then
            cmdNext.Enabled = False
        Else
            cmdNext.Enabled = True
        End If

        If loc = 0 Then
            cmdBack.Enabled = False
        Else
            cmdBack.Enabled = True
        End If


        If txtBonQty.Text <> txtPkgWast.Text Then
            txtBonQty.ForeColor = Color.Red
        Else
            txtBonQty.ForeColor = Color.Black
        End If


        '---Display MOQ-----
        Dim dr_MOQ() As DataRow
        Dim cate As String = Split(rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cate").ToString, " - ")(0)
        dr_MOQ = rs_SYPAKCAT.Tables("RESULT").Select("ypc_code = '" & cate & "'")
        If dr_MOQ.Length <> 0 Then
            txtMOQ.Text = dr_MOQ(0)("ypc_moq")
        Else
            txtMOQ.Text = 0
        End If

        '---Display Inv Stock-----
        Dim dr_Inv() As DataRow
        Dim item As String = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_pkgitm").ToString
        dr_Inv = rs_ListPkinvhdr.Tables("RESULT").Select("pih_pkgitm = '" & item & "'")
        If dr_Inv.Length <> 0 Then
            txtInvStkQty.Text = dr_Inv(0)("pih_avlqty")
        Else
            txtInvStkQty.Text = 0
        End If


        '----Display In_was
        txtWasIn.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_InWas")

        If mode = "UPDATE" Then


            If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_InWas").ToString = "Y" Then
                txtBonQty.Enabled = False
            ElseIf rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_InWas").ToString = "N" Then
                txtBonQty.Enabled = True
            End If
        End If


        '---Display MOA
        txtMOACur.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_curcde")
        txtMOA.Text = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_MOA")

        flag_disply = True

    End Sub


    Private Sub cmdBack_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdBack.Click




        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub

        End If

        Dim seq As Integer
        seq = txtSeq.Text
        Dim loc As Integer = -1


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If seq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") Then
                loc = i
            End If

        Next

        If loc = -1 Then
            MsgBox("Error Order detail not found!")
            Exit Sub
        End If



        If loc = 0 Then
            MsgBox("First Record")
            Exit Sub
        End If


        ' Dim seque As Integer = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_seq")


        update_PKREQDTL()

        display_PKREQDTL(loc - 1)
        Dim seque As Integer = rs_PKORDDTL.Tables("RESULT").Rows(loc - 1).Item("pod_seq")
        display_dgPKGoodRec(seque)
        display_dgMLTSHP(seque)
        display_dgReqdtl(seque)
        display_dgInvDtl(txtPkgItem.Text)
    End Sub

    Private Sub cmdNext_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdNext.Click

        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub

        End If





        Dim seq As Integer
        seq = txtSeq.Text
        Dim loc As Integer = -1


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If seq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") Then
                loc = i
            End If

        Next

        If loc = -1 Then
            MsgBox("Error Request detail not found!")
            Exit Sub
        End If


        If loc = rs_PKORDDTL.Tables("RESULT").Rows.Count - 1 Then
            MsgBox("Last Reocrd")
            Exit Sub
        End If

        'Dim seque As Integer = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_seq")


        update_PKREQDTL()

        display_PKREQDTL(loc + 1)
        Dim seque As Integer = rs_PKORDDTL.Tables("RESULT").Rows(loc + 1).Item("pod_seq")
        display_dgPKGoodRec(seque)
        display_dgMLTSHP(seque)
        display_dgReqdtl(seque)
        display_dgInvDtl(txtPkgItem.Text)
    End Sub

    Private Sub mmdClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdClear.Click
        Dim tmp_reqno As String
        Dim tmp_cocde As String

        If recordstatus = True Then
            Select Case MsgBox("Record has been modified. Do you want to save before clear the screen?", MsgBoxStyle.YesNoCancel)
                Case MsgBoxResult.Yes
                    If Enq_right_local Then
                        Call mmdSave_Click(sender, e)
                    Else
                        MsgBox("You have no Save record rights!")
                    End If
                    Me.Cursor = Cursors.Default
                Case MsgBoxResult.No
                    tmp_cocde = cbococde.Text
                    tmp_reqno = txtReqno.Text
                    formInit("INIT")
                    txtReqno.Text = tmp_reqno
                    cbococde.Text = tmp_cocde
                    txtReqno.Select()
                    Me.Cursor = Cursors.Default
            End Select
        Else
            tmp_reqno = txtReqno.Text
            tmp_cocde = cbococde.Text
            formInit("INIT")
            txtReqno.Text = tmp_reqno
            cbococde.Text = tmp_cocde
            txtReqno.Select()
            Me.Cursor = Cursors.Default
        End If

    End Sub

    Private Sub mmdExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdExit.Click
        Me.Close()

        'display_dgPKORDDTL()

    End Sub




    Private Sub display_dgPKORDDTL()
        If rs_PKORDDTL.Tables.Count = 0 Then
            Exit Sub
        End If

        dgPKORDDTL.DataSource = rs_PKORDDTL.Tables("RESULT").DefaultView

        dgPKORDDTL.RowHeadersWidth = 18
        dgPKORDDTL.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgPKORDDTL.ColumnHeadersHeight = 18
        dgPKORDDTL.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgPKORDDTL.AllowUserToResizeColumns = True
        dgPKORDDTL.AllowUserToResizeRows = False
        dgPKORDDTL.RowTemplate.Height = 18

        Dim i As Integer

        'If mode = "UPDATE" Or mode = "ADD" Or mode = "READ" Then
        '    For i = 0 To rs_PKORDDTL.Tables("RESULT").Columns.Count - 1
        '        rs_PKORDDTL.Tables("RESULT").Columns(i).ReadOnly = False
        '    Next i
        'End If

        i = 0
        dgPKORDDTL_pod_cocde = i
        dgPKORDDTL.Columns(i).HeaderText = "Company Code"
        dgPKORDDTL.Columns(i).Width = 70
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '1
        dgPKORDDTL_pod_ordno = i
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '2
        dgPKORDDTL_pod_seq = i
        dgPKORDDTL.Columns(i).HeaderText = "Seq"
        dgPKORDDTL.Columns(i).Width = 30
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '3
        dgPKORDDTL_pod_status = i
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '4
        dgPKORDDTL_pod_itemno = i
        dgPKORDDTL.Columns(i).HeaderText = "Item No"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '5
        dgPKORDDTL_pod_tmpitmno = i
        dgPKORDDTL.Columns(i).HeaderText = "Tmp.Item No"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '6
        dgPKORDDTL_pod_venno = i
        dgPKORDDTL.Columns(i).HeaderText = "Printer"
        dgPKORDDTL.Columns(i).Width = 40
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '7
        dgPKORDDTL_pod_venitm = i
        dgPKORDDTL.Columns(i).HeaderText = "Vend Itm No."
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '8
        dgPKORDDTL_pod_pckunt = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '9
        dgPKORDDTL_pod_inrqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Inr"
        dgPKORDDTL.Columns(i).Width = 40
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '10
        dgPKORDDTL_pod_mtrqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Mtr"
        dgPKORDDTL.Columns(i).Width = 60
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1 '11
        dgPKORDDTL_pod_cft = i
        dgPKORDDTL.Columns(i).HeaderText = "CFT"
        dgPKORDDTL.Columns(i).Width = 60
        dgPKORDDTL.Columns(i).Visible = False
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '11
        dgPKORDDTL_pod_ftyprctrm = i
        dgPKORDDTL.Columns(i).HeaderText = "Fty Prc Trm"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '12
        dgPKORDDTL_pod_hkprctrm = i
        dgPKORDDTL.Columns(i).HeaderText = "HK Prc Trm"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '13
        dgPKORDDTL_pod_trantrm = i
        dgPKORDDTL.Columns(i).HeaderText = "Tran Trm"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '14
        dgPKORDDTL_pod_pkgitm = i
        dgPKORDDTL.Columns(i).HeaderText = "Pkg Itm"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '15
        dgPKORDDTL_pod_pkgven = i
        dgPKORDDTL.Columns(i).HeaderText = "Pkg Ven"
        dgPKORDDTL.Columns(i).Width = 90
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '16
        dgPKORDDTL_pod_cate = i
        dgPKORDDTL.Columns(i).HeaderText = "Category"
        dgPKORDDTL.Columns(i).Width = 120
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '17
        dgPKORDDTL_pod_chndsc = i
        dgPKORDDTL.Columns(i).HeaderText = "Chin Desc"
        dgPKORDDTL.Columns(i).Width = 200
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '18
        dgPKORDDTL_pod_engdsc = i
        dgPKORDDTL.Columns(i).HeaderText = "Eng Desc"
        dgPKORDDTL.Columns(i).Width = 200
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '19
        dgPKORDDTL_pod_remark = i
        dgPKORDDTL.Columns(i).HeaderText = "Remark"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '20
        dgPKORDDTL_pod_EInchL = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp L (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '21
        dgPKORDDTL_pod_EInchW = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp W (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '22
        dgPKORDDTL_pod_EInchH = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp H (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '23
        dgPKORDDTL_pod_EcmL = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp L (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '24
        dgPKORDDTL_pod_EcmW = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp W (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '24
        dgPKORDDTL_pod_EcmH = i
        dgPKORDDTL.Columns(i).HeaderText = "Exp H (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '25
        dgPKORDDTL_pod_FInchL = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld L (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '26
        dgPKORDDTL_pod_FinchW = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld W (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '27
        dgPKORDDTL_pod_FinchH = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld H (in)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '28
        dgPKORDDTL_pod_FcmL = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld L (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '29
        dgPKORDDTL_pod_FcmW = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld W (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '30
        dgPKORDDTL_pod_FcmH = i
        dgPKORDDTL.Columns(i).HeaderText = "Fld H (cm)"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '31
        dgPKORDDTL_pod_matral = i
        dgPKORDDTL.Columns(i).HeaderText = "Material"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '32
        dgPKORDDTL_pod_tiknes = i
        dgPKORDDTL.Columns(i).HeaderText = "Tickness"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '33
        dgPKORDDTL_pod_prtmtd = i
        dgPKORDDTL.Columns(i).HeaderText = "Print Method"
        dgPKORDDTL.Columns(i).Width = 90
        dgPKORDDTL.Columns(i).ReadOnly = True

        i = i + 1 '34
        dgPKORDDTL_pod_clrfot = i
        dgPKORDDTL.Columns(i).HeaderText = "Col (Front)"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '35
        dgPKORDDTL_pod_clrbck = i
        dgPKORDDTL.Columns(i).HeaderText = "Col (Back)"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '36
        dgPKORDDTL_pod_finish = i
        dgPKORDDTL.Columns(i).HeaderText = "Finishing"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '36.1
        dgPKORDDTL_pod_matDsc = i
        dgPKORDDTL.Columns(i).HeaderText = "Material Desc"
        dgPKORDDTL.Columns(i).Width = 110
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '36.2
        dgPKORDDTL_pod_tikDsc = i
        dgPKORDDTL.Columns(i).HeaderText = "Tickness Desc"
        dgPKORDDTL.Columns(i).Width = 110
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1
        dgPKORDDTL_pod_prtDsc = i
        dgPKORDDTL.Columns(i).HeaderText = "Print Method Desc"
        dgPKORDDTL.Columns(i).Width = 110
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '37
        dgPKORDDTL_pod_rmtnce = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 160
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '38
        dgPKORDDTL_pod_addres_fty = i
        dgPKORDDTL.Columns(i).HeaderText = "Address"
        dgPKORDDTL.Columns(i).Width = 160
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '39
        dgPKORDDTL_pod_state_fty = i
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '40
        dgPKORDDTL_pod_cntry_fty = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '41
        dgPKORDDTL_pod_zip_fty = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '42
        dgPKORDDTL_pod_Tel_fty = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '43
        dgPKORDDTL_pod_cntper_fty = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '44
        dgPKORDDTL_pod_sctoqty = i
        dgPKORDDTL.Columns(i).HeaderText = "SC/TO Qty"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '45
        dgPKORDDTL_pod_qtyum = i
        dgPKORDDTL.Columns(i).HeaderText = "Qty UM"
        dgPKORDDTL.Columns(i).Width = 60
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '46
        dgPKORDDTL_pod_curcde = i
        dgPKORDDTL.Columns(i).HeaderText = "CCYy"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        i = i + 1 '47
        dgPKORDDTL_pod_multip = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 60
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '48
        dgPKORDDTL_pod_ordqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Pack. Ord Qty"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '48.1
        dgPKORDDTL_pod_stkqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Pack. Stock Qty"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '49
        dgPKORDDTL_pod_wasper = i
        dgPKORDDTL.Columns(i).HeaderText = "Waste %"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        dgPKORDDTL.Columns(i).ReadOnly = True

        i = i + 1 '50
        dgPKORDDTL_pod_wasqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Was Qty"
        dgPKORDDTL.Columns(i).Width = 100

        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '51
        dgPKORDDTL_pod_ttlordqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Ttl Ord Qty"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '52
        dgPKORDDTL_pod_untprc = i
        dgPKORDDTL.Columns(i).HeaderText = "Unit Prc"
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '53
        dgPKORDDTL_pod_ttlamtqty = i
        dgPKORDDTL.Columns(i).HeaderText = "Ttl Amt"
        dgPKORDDTL.Columns(i).Width = 100
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
        i = i + 1 '54
        dgPKORDDTL_pod_receqty = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 50
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '55
        dgPKORDDTL_pod_Reqno = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '56
        dgPKORDDTL_pod_Reqseq = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 60
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '56
        dgPKORDDTL_pod_Conmak = i
        dgPKORDDTL.Columns(i).HeaderText = "Consignee Remark"
        dgPKORDDTL.Columns(i).Width = 200
        dgPKORDDTL.Columns(i).Visible = True
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '57
        dgPKORDDTL_pod_creusr = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '58
        dgPKORDDTL_pod_updusr = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 200
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '59
        dgPKORDDTL_pod_credat = i
        dgPKORDDTL.Columns(i).HeaderText = ""
        dgPKORDDTL.Columns(i).Width = 80
        dgPKORDDTL.Columns(i).ReadOnly = True
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1 '60
        dgPKORDDTL_pod_upddat = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1 '61
        dgPKORDDTL_pod_timstp = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_bonqty = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_shpstr = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_shpend = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_fty = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_InWas = i
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL_pod_MOA = i
        dgPKORDDTL.Columns(i).Visible = False


        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False

        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False
        i = i + 1
        dgPKORDDTL.Columns(i).Visible = False
    End Sub


    Private Sub cmdCloseOrd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCloseOrd.Click




        Select Case MsgBox("Do you want to Close Order?", MsgBoxStyle.YesNoCancel)
            Case MsgBoxResult.Yes

                gspStr = "sp_update_PGM00004_CLOSE '" & cbococde.Text & "','" & txtReqno.Text & "','" & "CLO" & "','" & gsUsrID & " '"
                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading cmdCloseOrd_Click sp_update_PGM00004_CLOSE :" & rtnStr)
                    Exit Sub
                End If

                MsgBox("Record Saved")
                recordstatus = False
                mmdClear_Click(sender, e)
            Case MsgBoxResult.No
                Exit Sub
        End Select








    End Sub

    Private Function checkTimeStamp() As Boolean
        Dim save_timestamp As Long
        Dim curr_timestamp As Long

        gspStr = "sp_select_PKORDHDR '" & cbococde.Text & "','" & txtReqno.Text & "'"
        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading checkTimeStamp sp_select_VNBASINF :" & rtnStr)
            Exit Function
        End If

        save_timestamp = rs.Tables("RESULT").Rows(0).Item("poh_timstp")
        curr_timestamp = rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_timstp")

        If save_timestamp <> curr_timestamp Then
            checkTimeStamp = False
        Else
            checkTimeStamp = True
        End If

    End Function


    Private Function check_ttlgoods() As Boolean
        If rs_PKMLTSHP.Tables("RESULT").Rows.Count = 0 And rs_pkordrec.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        'Start------------Multiple Shipment-------------'

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            Dim ttlordqty As Integer

            Dim stkqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty")
            Dim ordqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordqty")
            Dim bonqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_bonqty")
            If stkqty < 0 Then
                ttlordqty = ordqty + bonqty
            ElseIf stkqty >= 0 Then
                ttlordqty = stkqty + ordqty + bonqty
            End If


            Dim seq As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")
            Dim dr() As DataRow = rs_PKMLTSHP.Tables("RESULT").Select("Del = '' and pms_ordseq = " & seq)
            If dr.Length = 0 Then
                Continue For
            End If
            Dim sum As Integer = 0
            For x As Integer = 0 To dr.Length - 1
                sum = sum + dr(x)("pms_shpqty")
            Next

            If sum <> ttlordqty Then
                Dim loc As Integer
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                'MsgBox("Multiple Shipment Total Qty must equal to Total Order Qty.")
                MsgBox("Multiple Shipment Total Qty must equal to Order Qty Plus Wasage Qty.")
                Return False
                Exit For
            End If

        Next

        'End------------Multiple Shipment-------------'


        'Start----------Goods Receive-------------------


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            Dim ttlordqty As Integer

            Dim stkqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty")
            Dim ordqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordqty")
            Dim bonqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_bonqty")
            If stkqty < 0 Then
                ttlordqty = ordqty + bonqty - (stkqty * -1)
            ElseIf stkqty >= 0 Then
                ttlordqty = stkqty + ordqty + bonqty
            End If


            Dim seq As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")
            Dim dr() As DataRow = rs_pkordrec.Tables("RESULT").Select("Del = '' and por_ordseq = " & seq)
            If dr.Length = 0 Then
                Continue For
            End If
            Dim sum As Integer = 0
            For x As Integer = 0 To dr.Length - 1
                sum = sum + dr(x)("por_recqty")
            Next

            If sum > ttlordqty Then
                Dim loc As Integer
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox("Goods Receive Qty should be less than Total Order Qty.")
                Return False
                Exit For
            End If

        Next


        'End----------Goods Receive-------------------


        Return True



    End Function




    Private Sub mmdSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdSave.Click
        If mode = "UPDATE" Then
            If Not checkTimeStamp() Then
                MsgBox("Data does not synchronous please refresh.", vbInformation, gsCompany)
                Me.Cursor = Cursors.Default
                Exit Sub
            End If
        End If

        update_PKREQDTL()

        If check_valid() = False Then
            Exit Sub
        End If

        If check_ttlgoods() = False Then
            Exit Sub
        End If


        If check_stk() = False Then
            Exit Sub
        End If


        If save_pkordhdr() = True Then

        Else
            MsgBox("Header Save Fail")
            Exit Sub
        End If

        If save_pkorddtl() = True Then

        Else
            MsgBox("Detail Save Fail")
            Exit Sub
        End If

        If save_pkordrec() = True Then

        Else
            MsgBox("Goods Receive Save Fail")
            Exit Sub
        End If


        If save_pkmtlshp() = True Then

        Else
            MsgBox("Multiple Shipment Save Fail")
            Exit Sub
        End If


        If save_pkDIS() = True Then

        Else
            MsgBox("Discount Save Fail")
            Exit Sub
        End If

        If save_pkPRE() = True Then

        Else
            MsgBox("Presuim Save Fail")
            Exit Sub
        End If

        If save_pkREPORD() = True Then
        Else
            MsgBox("Re-Print Order Save Fail")
            Exit Sub
        End If

        MsgBox("Record Saved")
        recordstatus = False
        mmdClear_Click(sender, e)
        recordstatus = False
        mmdClear_Click(sender, e)
        recordstatus = False
        mmdClear_Click(sender, e)

    End Sub

    Private Function check_stk() As Boolean

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1

            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty") >= 0 Then



                Dim ordqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordqty")
                Dim wastqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_wasqty")
                Dim stkqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty")
                Dim pkgitm As String = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm")
                Dim pastqty As Integer = 0
                Dim seq As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")


                Dim dr() As DataRow
                dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & pkgitm & "'")

                Dim sumqty As Integer = 0

                For x As Integer = 0 To dr.Length - 1
                    sumqty = sumqty + dr(x)("pih_avlqty")
                Next

                Dim drpast() As DataRow

                drpast = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & pkgitm & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & seq)
                If drpast.Length <> 0 Then
                    pastqty = drpast(0)("pih_avlqty")
                Else
                    pastqty = 0
                End If



                If (sumqty - pastqty + stkqty) < 0 Then

                    MsgBox("Cannot lower than current stock qty (" & pastqty - sumqty & ").")
                    display_PKREQDTL(i)
                    txtStkqty.Focus()
                    Return False
                    Exit Function
                End If


            Else


                Dim ordqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordqty")
                Dim wastqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_wasqty")
                Dim stkqty As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty") * -1
                Dim pkgitm As String = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm")
                Dim pastqty As Integer = 0
                Dim seq As Integer = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")


                Dim dr() As DataRow
                dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & pkgitm & "'")

                Dim sumqty As Integer = 0

                For x As Integer = 0 To dr.Length - 1
                    sumqty = sumqty + dr(x)("pih_avlqty")
                Next

                Dim drpast() As DataRow

                drpast = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & pkgitm & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & seq)
                If drpast.Length <> 0 Then
                    pastqty = drpast(0)("pih_avlqty")
                Else
                    pastqty = 0
                End If


                If (sumqty - pastqty - stkqty) < 0 Then

                    MsgBox("The inventory stock qty is (" & sumqty - pastqty & ").")
                    display_PKREQDTL(i)
                    txtStkqty.Focus()
                    Return False
                    Exit Function
                End If

            End If

        Next

        Return True



    End Function

    Private Function save_pkordhdr() As Boolean

        If rs_PKORDHDR.Tables("RESULT").Rows.Count = 0 Then
            Return False
            Exit Function
        End If




        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~" Then


            Dim dvydat As String
            If txtDvyDat.Text = "  /  /" Then
                dvydat = "01/01/1900"
            Else
                dvydat = txtDvyDat.Text
            End If
            Dim dremark As String = Replace(txtDremark.Text, "'", "''")
            Dim iremark As String = Replace(txtiremark.Text, "'", "''")

            Dim fty As String
            Dim shpstr As String
            Dim shpend As String

            If txtHdrShpStr.Text = "  /  /" Then
                shpstr = "01/01/1900"
            Else
                shpstr = txtHdrShpStr.Text
            End If

            If txtHdrShpEnd.Text = "  /  /" Then
                shpend = "01/01/1900"
            Else
                shpend = txtHdrShpEnd.Text
            End If

            'Dim address As String = Replace(txtHdrAdd.Text, "'", "''")
            Dim address As String = Replace(cboHdrAdd.Text, "'", "''")

            Dim state As String = Replace(txtHdrSta.Text, "'", "''")
            Dim zip As String = Replace(txtHdrzip.Text, "'", "''")
            Dim country As String = Replace(txtHdrCty.Text, "'", "''")


            Dim address_fty As String = Replace(cboHdrAdd_fty.Text, "'", "''")
            Dim state_fty As String = Replace(txtHdrSta_fty.Text, "'", "''")
            Dim zip_fty As String = Replace(txtHdrzip_fty.Text, "'", "''")
            Dim country_fty As String = Replace(txtHdrCty_fty.Text, "'", "''")
            Dim ctnper_fty As String = Replace(cboHdrCtn_fty.Text, "'", "''")
            Dim tel_fty As String = Replace(txtHdrTel_fty.Text, "'", "''")

            Dim count As Integer

            If cboHdrFty.Text <> "" Then
                count = CountCharacter(cboHdrFty.Text, " - ")
                fty = Split(cboHdrFty.Text, " - ")(count)
            Else
                fty = ""
            End If


            Dim ttlamt As Decimal

            If txtHdrTtlAmt.Text <> "" Then
                ttlamt = txtHdrTtlAmt.Text
                ttlamt = round(ttlamt, 2)
            Else
                MsgBox("Header Total Amount Is Empty , Please Check.")
                Return False
                Exit Function
            End If


            Dim ctnper As String

            If cboHdrCtn.Text <> "" Then
                ctnper = cboHdrCtn.Text
            Else
                ctnper = ""
            End If



            Dim tel As String

            tel = txtHdrTel.Text



            Dim DCAMT As Decimal

            If txtHdrDC.Text = "" Then
                DCAMT = 0
            Else
                DCAMT = txtHdrDC.Text
                DCAMT = round(DCAMT, 2)
            End If


            Dim TTLDCAMT As Decimal

            If txtHdrTA.Text = "" Then
                TTLDCAMT = 0
            Else
                TTLDCAMT = txtHdrTA.Text
                TTLDCAMT = round(TTLDCAMT, 2)
            End If

            Dim reprtflg As String

            reprtflg = txtReprtFlag.Text.ToString.Trim


            gspStr = "sp_update_PKORDHDR '" & cbococde.Text & "','" & Trim(txtReqno.Text) & "','" & dvydat & "',N'" & dremark & _
            "',N'" & iremark & "','" & shpstr & "','" & shpend & "','" & fty & "',N'" & _
            address & "'," & ttlamt & ",'" & state & "','" & zip & "','" & country & "','" & ctnper & "','" & tel & _
              "','" & address_fty & "','" & state_fty & "','" & zip_fty & "','" & country_fty & "','" & ctnper_fty & "','" & tel_fty & _
            "'," & DCAMT & "," & TTLDCAMT & ",'" & _
            reprtflg & "','" & gsUsrID & "'"

            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading save_pkordhdr sp_update_PKORDHDR :" & rtnStr)
                Return False
                Exit Function
            End If




        End If


        Return True


    End Function

    Private Function CountCharacter(ByVal value As String, ByVal ch As String) As Integer
        Dim counter As Integer
        Dim a As Array
        a = Split(value, " - ")
        counter = a.Length - 1
        Return counter
    End Function

    Private Function save_pkmtlshp() As Boolean


        If rs_PKMLTSHP.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        Dim del As String
        Dim pms_cocde As String
        Dim pms_ordno As String
        Dim pms_ordseq As Integer
        Dim pms_shpseq As Integer
        Dim pms_shpstrdat As DateTime
        Dim pms_shpenddat As DateTime
        Dim pms_shpqty As Integer
        Dim pms_um As String
        Dim pms_fty As String

        Dim pms_address As String
        Dim pms_state As String
        Dim pms_cntry As String
        Dim pms_zip As String
        Dim pms_cntper As String
        Dim pms_tel As String

        Dim pms_remark As String
        Dim pms_creusr As String
        Dim count As Integer


        For i As Integer = 0 To rs_PKMLTSHP.Tables("RESULT").Rows.Count - 1
            count = 0
            del = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("Del")
            pms_cocde = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_cocde")
            pms_ordno = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_ordno")
            pms_ordseq = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_ordseq")
            pms_shpseq = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpseq")
            pms_shpstrdat = IIf(IsDBNull(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpstrdat")), "1900-01-01", rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpstrdat"))
            pms_shpenddat = IIf(IsDBNull(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpenddat")), "1900-01-01", rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpenddat"))
            pms_shpqty = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpqty")
            pms_um = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_um")

            count = CountCharacter(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_fty"), " - ")
            pms_fty = Split(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_fty"), " - ")(count)

            pms_address = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_address"), "'", "''")
            pms_state = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_state"), "'", "''")
            pms_cntry = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_cntry"), "'", "''")
            pms_zip = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_zip"), "'", "''")
            pms_cntper = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_cntper"), "'", "''")
            pms_tel = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_tel"), "'", "''")

            pms_remark = Replace(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_remark"), "'", "''")
            pms_creusr = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_creusr")

            If del = "Y" Then
                gspStr = "sp_Physical_Delete_PKMTLSHP '" & pms_cocde & "','" & pms_ordno & "'," & pms_ordseq & "," & pms_shpseq

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkmtlshp sp_Physical_Delete_PKMTLSHP :" & rtnStr)
                    Return False
                    Exit Function
                End If


            ElseIf pms_creusr = "~*ADD*~" Then
                gspStr = "sp_insert_PKMTLSHP '" & pms_cocde & "','" & pms_ordno & "'," & pms_ordseq & "," & pms_shpseq & ",'" & pms_shpstrdat & "','" & _
                                                pms_shpenddat & "'," & pms_shpqty & ",'" & pms_um & "','" & pms_fty & _
                                                "','" & pms_address & _
                                                "','" & pms_state & _
                                                "','" & pms_cntry & _
                                                "','" & pms_zip & _
                                                "','" & pms_cntper & _
                                                "','" & pms_tel & _
                                                "','" & pms_remark & _
                                                "','" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkmtlshp sp_insert_PKMTLSHP :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf pms_creusr = "~*UPD*~" Then

                gspStr = "sp_update_PKMTLSHP '" & pms_cocde & "','" & pms_ordno & "'," & pms_ordseq & "," & pms_shpseq & ",'" & pms_shpstrdat & "','" & _
                                                 pms_shpenddat & "'," & pms_shpqty & ",'" & pms_um & "','" & pms_fty & _
                                                                                                 "','" & pms_address & _
                                                "','" & pms_state & _
                                                "','" & pms_cntry & _
                                                "','" & pms_zip & _
                                                "','" & pms_cntper & _
                                               "','" & pms_tel & _
                                                 "','" & pms_remark & "','" & gsUsrID & "'"

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkmtlshp sp_update_PKMTLSHP :" & rtnStr)
                    Return False
                    Exit Function
                End If
            End If

        Next

        Return True


    End Function



    Private Function save_pkordrec() As Boolean


        If rs_pkordrec.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        Dim por_Del As String
        Dim por_cocde As String
        Dim por_ordno As String
        Dim por_ordseq As Integer
        Dim por_recseq As Integer
        Dim por_recdate As DateTime
        Dim por_recqty As Integer
        Dim por_um As String
        Dim por_remark As String
        Dim por_invno As String
        Dim por_creusr As String
        Dim por_fty As String
        Dim por_type As String
        Dim por_extqty As Integer
        Dim count As Integer


        For i As Integer = 0 To rs_pkordrec.Tables("RESULT").Rows.Count - 1
            count = 0
            por_cocde = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_cocde")
            por_ordno = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_ordno")
            por_ordseq = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_ordseq")
            por_recseq = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recseq")
            por_recdate = IIf(IsDBNull(rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recdate")), "1900-01-01", rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recdate"))
            por_recqty = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recqty")
            por_um = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_um")
            por_remark = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_remark")
            por_invno = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_invno")
            por_creusr = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_creusr")
            por_Del = rs_pkordrec.Tables("RESULT").Rows(i).Item("Del")
            por_type = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_type")
            por_extqty = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_extqty")

            count = CountCharacter(rs_pkordrec.Tables("RESULT").Rows(i).Item("por_fty"), " - ")
            por_fty = Split(rs_pkordrec.Tables("RESULT").Rows(i).Item("por_fty"), " - ")(count)

            If por_Del = "Y" Then

                gspStr = "sp_Physical_Delete_PKORDREC '" & por_cocde & "','" & por_ordno & "'," & por_ordseq & "," & por_recseq

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkordrec sp_Physical_Delete_PKORDREC :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf por_creusr = "~*ADD*~" Then
                gspStr = "sp_insert_PKORDREC '" & por_cocde & "','" & por_ordno & "'," & por_ordseq & "," & por_recseq & ",'" & por_recdate & "'," & _
                                                por_recqty & ",'" & por_um & "','" & por_remark & "','" & por_invno & "','" & por_type & "','" & _
                                                por_fty & "'," & por_extqty & ",'" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkordrec sp_insert_PKORDREC :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf por_creusr = "~*UPD*~" Then

                gspStr = "sp_update_PKORDREC '" & por_cocde & "','" & por_ordno & "'," & por_ordseq & "," & por_recseq & ",'" & por_recdate & "'," & _
                                                por_recqty & ",'" & por_um & "','" & por_remark & "','" & por_invno & "','" & por_type & "','" & _
                                                por_fty & "'," & por_extqty & ",'" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkordrec sp_update_PKORDREC :" & rtnStr)
                    Return False
                    Exit Function
                End If
            End If

        Next

        Return True


    End Function



    Private Function save_pkorddtl() As Boolean


        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        Dim pod_cocde As String
        Dim pod_ordno As String
        Dim pod_ordseq As Integer
        Dim pod_stkqty As Integer
        Dim pod_wasper As Decimal
        Dim pod_wasqty As Integer
        Dim pod_ttlqty As Integer
        Dim pod_ttlamt As Decimal
        Dim pod_creusr As String
        Dim pod_conmak As String
        Dim pod_pkgitm As String
        Dim pod_ordqty As Integer
        Dim pod_fty As String

        Dim pod_addres_fty As String
        Dim pod_state_fty As String
        Dim pod_cntry_fty As String
        Dim pod_zip_fty As String
        Dim pod_cntper_fty As String
        Dim pod_Tel_fty As String

        Dim pod_shpstr As String
        Dim pod_shpend As String
        Dim pod_bonqty As String
        Dim pod_MOA As Decimal
        Dim count As Integer
        Dim pod_qtyum As String

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            count = 0
            pod_cocde = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_cocde")
            pod_ordno = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordno")
            pod_ordseq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq")
            pod_stkqty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty")
            pod_wasper = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_wasper")
            pod_wasqty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_wasqty")
            pod_ttlqty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlordqty")
            pod_ttlamt = round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty"), 2)
            pod_conmak = Replace(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_Conmak"), "'", "''")
            pod_pkgitm = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm")
            pod_ordqty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ordqty")
            'pod_fty = IIf(Trim(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_fty").ToString) = "", "", Split(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_fty"), " - ")(0))

            If Trim(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_fty").ToString) = "" Then
                pod_fty = ""
            Else
                count = CountCharacter(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_fty"), " - ")
                pod_fty = Split(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_fty"), " - ")(count)
            End If

            pod_addres_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_addres_fty")
            pod_state_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_state_fty")
            pod_cntry_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_cntry_fty")
            pod_zip_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_zip_fty")
            pod_cntper_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_cntper_fty")
            pod_Tel_fty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_Tel_fty")

            pod_shpstr = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_shpstr")
            pod_shpend = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_shpend")
            pod_bonqty = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_bonqty")
            pod_creusr = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_creusr")
            pod_MOA = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA")

            pod_qtyum = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_qtyum")

            'Do Update qtyum SP

            If pod_creusr = "~*ADD*~" Then
                'gspStr = "sp_insert_PKORDREC '" & por_cocde & "','" & por_ordno & "'," & por_ordseq & "," & por_recseq & ",'" & por_recdate & "'," & _
                '                                por_recqty & ",'" & por_um & "','" & por_remark & "','" & por_invno & "','" & gsUsrID & "'"



                'rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                'If rtnLong <> RC_SUCCESS Then
                '    MsgBox("Error on loading save_pkordrec sp_insert_PKORDREC :" & rtnStr)
                '    Return False
                '    Exit Function
                'End If

            ElseIf pod_creusr = "~*UPD*~" Then

                gspStr = "sp_update_PKORDDTL '" & pod_cocde & "','" & pod_ordno & "'," & pod_ordseq & "," & pod_stkqty & "," & pod_wasper & "," & _
                pod_wasqty & "," & pod_ttlqty & "," & pod_ttlamt & ",N'" & pod_conmak & "','" & pod_pkgitm & "'," & pod_ordqty & _
                "," & pod_bonqty & ",'" & pod_fty & _
                "','" & pod_addres_fty & _
                "','" & pod_state_fty & _
                "','" & pod_cntry_fty & _
                "','" & pod_zip_fty & _
                "','" & pod_cntper_fty & _
                "','" & pod_Tel_fty & _
                "','" & pod_shpstr & _
                "','" & pod_shpend & "'," & pod_MOA & ",'" & pod_qtyum & "','" & gsUsrID & "'"

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkordrec sp_update_PKORDDTL :" & rtnStr)
                    Return False
                    Exit Function
                End If
            End If

        Next

        Return True


    End Function







    Private Function check_valid() As Boolean
        Dim seq As Integer
        Dim loc As Integer

        If rs_pkordrec.Tables("RESULT").Rows.Count = 0 And rs_PKMLTSHP.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If


        For i As Integer = 0 To rs_pkordrec.Tables("RESULT").Rows.Count - 1  ''Goods Receive Checking
            If rs_pkordrec.Tables("RESULT").Rows(i).Item("Del") = "Y" Then
                Continue For
            End If

            If IsDate(rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recdate")) = False Then
                seq = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox(("Please Input valid Receive Date [MM/dd/yyyy]"))
                Return False
                Exit Function

            ElseIf (rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recdate") <= Now.Date) = False Then
                seq = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox("Please input the date that earlier than today.")
                Return False
                Exit Function

            End If


            If IsNumeric(rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recqty")) = False Or _
            rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recqty").ToString.Contains(".") = True Or _
            rs_pkordrec.Tables("RESULT").Rows(i).Item("por_recqty") = 0 Then
                seq = rs_pkordrec.Tables("RESULT").Rows(i).Item("por_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox(("Please Input valid Receive Qty and Qty must not be 0"))
                Return False
                Exit Function



            End If



        Next


        For i As Integer = 0 To rs_PKMLTSHP.Tables("RESULT").Rows.Count - 1  ''Mult Ship Checking 

            If rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("Del") = "Y" Then
                Continue For
            End If

            If IsDate(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpstrdat")) = False Or _
            IsDate(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpenddat")) = False Then
                seq = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox(("Please Input valid Ship Date [MM/dd/yyyy]"))
                Return False
                Exit Function



            End If


            If IsNumeric(rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpqty")) = False Or _
            rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpqty").ToString.Contains(".") = True Or _
            rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_shpqty") = 0 Then
                seq = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox(("Please Input valid Ship Qty and Qty must not be 0"))
                Return False
                Exit Function



            End If


            If rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_fty") = "" Then

                seq = rs_PKMLTSHP.Tables("RESULT").Rows(i).Item("pms_ordseq")
                For ii As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                    If seq = rs_PKORDDTL.Tables("RESULT").Rows(ii).Item("pod_seq") Then
                        loc = ii
                    End If
                Next
                display_PKREQDTL(loc)
                display_dgPKGoodRec(seq)
                display_dgMLTSHP(seq)
                MsgBox(("Please select Factory"))
                Return False
                Exit Function



            End If



        Next










        Return True


    End Function

    Private Sub dgGoodRec_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgGoodRec.CellClick
        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") <> "APV" Then
            Exit Sub
        End If


        If dgGoodRec.RowCount = 0 Then
            Exit Sub
        End If

        If e.RowIndex = -1 Or e.ColumnIndex = -1 Then
            Exit Sub
        End If


        If dgGoodRec.CurrentCell.ColumnIndex = 7 Then
            comboBoxCell(dgGoodRec, "VN")
        ElseIf dgGoodRec.CurrentCell.ColumnIndex = 6 Then
            comboBoxCell(dgGoodRec, "type")
        End If







    End Sub





    Private Sub dgGoodRec_CellEndEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgGoodRec.CellEndEdit
        If IsDBNull(dgGoodRec.Item(8, dgGoodRec.CurrentCell.RowIndex).Value) = True Then
            dgGoodRec.Item(8, dgGoodRec.CurrentCell.RowIndex).Value = 0
        End If

        If IsDBNull(dgGoodRec.Item(9, dgGoodRec.CurrentCell.RowIndex).Value) = True Then
            dgGoodRec.Item(9, dgGoodRec.CurrentCell.RowIndex).Value = 0
        End If



        If dgGoodRec.Item(13, e.RowIndex).Value <> "~*ADD*~" Then
            dgGoodRec.Item(13, e.RowIndex).Value = "~*UPD*~"

        End If




        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgGoodRec.CurrentCell.ColumnIndex

                Case 7
                    'dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value = Split(dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value, " - ")(0)
                    dgGoodRec.Item(7, dgGoodRec.CurrentCell.RowIndex) = txtCell
                Case 6

                    dgGoodRec.Item(6, dgGoodRec.CurrentCell.RowIndex) = txtCell

            End Select
        Catch
        End Try




        recordstatus = True
    End Sub

    Private Sub dgGoodRec_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgGoodRec.CellValidating
        Dim row As DataGridViewRow = dgGoodRec.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then
            Select Case e.ColumnIndex




                Case 5 'Date

                    If strNewVal = "" Then
                        Exit Sub
                    End If


                    If strNewVal.Length = 10 And IsDate(strNewVal) = True Then


                        If Convert.ToDateTime(Now.Date) < Convert.ToDateTime(strNewVal) Then
                            MsgBox("Receive Date must earlier than System Date")
                            e.Cancel = True
                            Exit Sub
                        End If


                        If Convert.ToDateTime(txtIssDate.Text) > Convert.ToDateTime(strNewVal) Then
                            MsgBox("Receive Date cannot earlier than PO Issue Date")
                            e.Cancel = True
                            Exit Sub
                        End If









                        'ElseIf Convert.ToDateTime(strNewVal).Year < 2000 And strNewVal <> "01/01/1900" Then

                        '    If e.ColumnIndex = dgMShp_tds_ftyshpstr Then
                        '        MsgBox("Please Input valid Fty Ship Start Date [MM/dd/yyyy] & Year must be larger than 2000!")
                        '        e.Cancel = True
                        '    ElseIf e.ColumnIndex = dgMShp_tds_ftyshpend Then
                        '        MsgBox("Please Input valid Fty Ship End Date [MM/dd/yyyy] & Year must be larger than 2000!")
                        '        e.Cancel = True
                        '    ElseIf e.ColumnIndex = dgMShp_tds_cushpstr Then
                        '        MsgBox("Please Input valid Cust Ship Start Date [MM/dd/yyyy] & Year must be larger than 2000!")
                        '        e.Cancel = True
                        '    ElseIf e.ColumnIndex = dgMShp_tds_cushpend Then
                        '        MsgBox("Please Input valid Cust Ship End Date [MM/dd/yyyy] & Year must be larger than 2000!")
                        '        e.Cancel = True

                        '    End If
                    Else

                        MsgBox("Please input valid Date [MM/dd/yyyy]")
                        e.Cancel = True

                    End If




                Case 8, 9


                    If strNewVal = "" Then

                        Exit Sub
                    End If


                    If Not IsNumeric(strNewVal) Then
                        MsgBox("Invalid Quantity!")
                        e.Cancel = True
                        Exit Sub
                    End If

                    If strNewVal.Contains(".") = True Then
                        MsgBox("Invalid Quantity!")
                        e.Cancel = True
                        Exit Sub
                    End If

                    If Convert.ToInt32(strNewVal) < 0 Then
                        MsgBox("Quantity cannot be Negative.")
                        e.Cancel = True
                        Exit Sub
                    End If





            End Select
        End If
    End Sub

    Private Sub dgGoodRec_EditingControlShowing(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgGoodRec.EditingControlShowing


        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgGoodRec.CurrentCell.ColumnIndex
            Case 5
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    AddHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress
                    'AddHandler txtbox.TextChanged, AddressOf txt_dgSummary_TextChanged
                End If
            Case 7, 6
                If TypeOf (e.Control) Is DataGridViewComboBoxEditingControl Then
                    Dim cboBox As ComboBox = CType(e.Control, ComboBox)
                    If Not cboBox Is Nothing Then
                        'RemoveHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                        'AddHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                    End If
                End If
            Case Else
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress
                End If
        End Select


    End Sub

    Private Sub txt_datagridDates_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        If e.KeyChar = vbBack Or (dgGoodRec.CurrentCell.ColumnIndex <> 5) Then

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


    Private Sub txt_datagridDates_KeyPress2(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        If e.KeyChar = vbBack Or (dgMltShp.CurrentCell.ColumnIndex <> 5 And dgMltShp.CurrentCell.ColumnIndex <> 6) Then

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


    Private Sub dgGoodRec_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgGoodRec.GotFocus
        Got_Focus_Grid = "GoodsRec"
    End Sub






    Private Sub display_dgMLTSHP(ByVal seq As Integer)
        If rs_PKMLTSHP.Tables.Count = 0 Then
            Exit Sub

        End If

        rs_PKMLTSHP.Tables("RESULT").DefaultView.Sort = "pms_ordseq , pms_shpseq"



        dgMltShp.DataSource = rs_PKMLTSHP.Tables("RESULT").DefaultView

        If rs_PKMLTSHP.Tables("RESULT").Rows.Count > 0 Then
            Dim sFilter As String
            sFilter = "pms_ordseq = " & seq
            rs_PKMLTSHP.Tables("RESULT").DefaultView.RowFilter = sFilter
            'dgMShp.DataSource = rs_TODTLSHP.Tables("RESULT").DefaultView
        End If




        dgMltShp.RowHeadersWidth = 18
        dgMltShp.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgMltShp.ColumnHeadersHeight = 18
        dgMltShp.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgMltShp.AllowUserToResizeColumns = True
        dgMltShp.AllowUserToResizeRows = False
        dgMltShp.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_PKMLTSHP.Tables("RESULT").Columns.Count - 1
            rs_PKMLTSHP.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgMltShp.Columns.Count - 1

            Select Case i

                Case 0

                    dgMltShp.Columns(i).HeaderText = "Del"
                    dgMltShp.Columns(i).Width = 30

                Case 1

                    dgMltShp.Columns(i).HeaderText = "Company code"

                    dgMltShp.Columns(i).Visible = False

                Case 2
                    dgMltShp.Columns(i).HeaderText = "Order no"

                    dgMltShp.Columns(i).Visible = False

                Case 3
                    dgMltShp.Columns(i).HeaderText = "Order seq"

                    dgMltShp.Columns(i).Visible = False
                Case 4
                    dgMltShp.Columns(i).HeaderText = "Seq"
                    dgMltShp.Columns(i).Width = 40
                    dgMltShp.Columns(i).ReadOnly = True
                Case 5
                    dgMltShp.Columns(i).HeaderText = "Delivery Date"
                    dgMltShp.Columns(i).Width = 90
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 6
                    dgMltShp.Columns(i).HeaderText = "Ship End Date"
                    'dgMltShp.Columns(i).Width = 95
                    'If mode <> "ReadOnly" Then
                    '    dgMltShp.Columns(i).ReadOnly = False
                    'End If
                    dgMltShp.Columns(i).Visible = False
                Case 7
                    dgMltShp.Columns(i).HeaderText = "Qty"
                    dgMltShp.Columns(i).Width = 60
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 8
                    dgMltShp.Columns(i).HeaderText = "um"
                    dgMltShp.Columns(i).Visible = False

                Case 9
                    dgMltShp.Columns(i).HeaderText = "Fty"
                    dgMltShp.Columns(i).Width = 120
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 10
                    dgMltShp.Columns(i).HeaderText = "Address"
                    dgMltShp.Columns(i).Width = 250
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 11
                    dgMltShp.Columns(i).HeaderText = "State"
                    dgMltShp.Columns(i).Width = 120
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 12
                    dgMltShp.Columns(i).HeaderText = "Country"
                    dgMltShp.Columns(i).Width = 90
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 13
                    dgMltShp.Columns(i).HeaderText = "Zip"
                    dgMltShp.Columns(i).Width = 80
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 14
                    dgMltShp.Columns(i).HeaderText = "Tel"
                    dgMltShp.Columns(i).Width = 120
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If
                Case 15
                    dgMltShp.Columns(i).HeaderText = "Contact Person"
                    dgMltShp.Columns(i).Width = 120
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If

                Case 16
                    dgMltShp.Columns(i).HeaderText = "Remark"
                    dgMltShp.Columns(i).Width = 200
                    If mode <> "ReadOnly" Then
                        dgMltShp.Columns(i).ReadOnly = False
                    End If


                Case Else
                    dgMltShp.Columns(i).Visible = False
            End Select



        Next

    End Sub








    Private Sub display_dgPKGoodRec(ByVal seq As Integer)
        If rs_pkordrec.Tables.Count = 0 Then
            Exit Sub
        End If

        If rs_pkordrec.Tables("RESULT").Rows.Count > 0 Then
            Dim sFilter As String
            sFilter = "por_ordseq = " & seq
            rs_pkordrec.Tables("RESULT").DefaultView.RowFilter = sFilter
            'dgMShp.DataSource = rs_TODTLSHP.Tables("RESULT").DefaultView
        End If



        dgGoodRec.DataSource = rs_pkordrec.Tables("RESULT").DefaultView

        'dgGoodRec.RowHeadersWidth = 18
        'dgGoodRec.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        'dgGoodRec.ColumnHeadersHeight = 18
        'dgGoodRec.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        'dgGoodRec.AllowUserToResizeColumns = True
        'dgGoodRec.AllowUserToResizeRows = False
        'dgGoodRec.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_pkordrec.Tables("RESULT").Columns.Count - 1
            rs_pkordrec.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgGoodRec.Columns.Count - 1

            Select Case i



                Case 0
                    dgGoodRec.Columns(i).HeaderText = "Del"
                    dgGoodRec.Columns(i).Width = 30
                    dgGoodRec.Columns(i).Visible = True
                    dgGoodRec.Columns(i).ReadOnly = True
                Case 1

                    dgGoodRec.Columns(i).HeaderText = "Company Code"
                    dgGoodRec.Columns(i).Width = 70
                    dgGoodRec.Columns(i).Visible = False
                Case 2

                    dgGoodRec.Columns(i).Visible = False
                Case 3
                    dgGoodRec.Columns(i).Visible = False
                Case 4
                    dgGoodRec.Columns(i).HeaderText = "Seq"
                    dgGoodRec.Columns(i).Width = 40
                    dgGoodRec.Columns(i).ReadOnly = True
                Case 5
                    dgGoodRec.Columns(i).HeaderText = "Receive Date"
                    dgGoodRec.Columns(i).Width = 70
                    If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
                        dgGoodRec.Columns(i).ReadOnly = False
                    End If
                Case 6
                    dgGoodRec.Columns(i).HeaderText = "Type"
                    dgGoodRec.Columns(i).Width = 70

                    dgGoodRec.Columns(i).ReadOnly = True

                Case 7
                    dgGoodRec.Columns(i).HeaderText = "Receive Location"
                    dgGoodRec.Columns(i).Width = 100

                    dgGoodRec.Columns(i).ReadOnly = True

                Case 8
                    dgGoodRec.Columns(i).HeaderText = "Receive Qty"
                    dgGoodRec.Columns(i).Width = 60
                    If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
                        dgGoodRec.Columns(i).ReadOnly = False
                    End If

                Case 9


                    dgGoodRec.Columns(i).HeaderText = "Extra Qty"
                    dgGoodRec.Columns(i).Width = 50
                    If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
                        dgGoodRec.Columns(i).ReadOnly = False
                    End If



                Case Else
                    dgGoodRec.Columns(i).Visible = False
            End Select



        Next

    End Sub


    Private Sub mmdInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdInsRow.Click
        If BaseTabControl1.SelectedIndex = 1 Then
            If Got_Focus_Grid = "GoodsRec" Then

                If cboStatus.Text <> "APV - Approved" Then
                    Exit Sub
                End If

                Dim rowcount As Integer
                rowcount = rs_pkordrec.Tables("RESULT").Rows.Count
                'Dim dr() As DataRow = rs_TODTLSHP.Tables("RESULT").Select("tds_toordno = ''")
                Dim dr() As DataRow = rs_pkordrec.Tables("RESULT").Select("por_recqty = 0 and por_ordseq = " & txtSeq.Text)
                Dim dr2() As DataRow = rs_pkordrec.Tables("RESULT").Select("por_ordseq = " & txtSeq.Text, "por_recseq ASC")
                'sFilter = "tds_toordseq = " & seq & " and tds_verno = " & ver

                Dim maxseq As Integer

                Dim tb As New DataTable
                tb = rs_pkordrec.Tables("RESULT").Clone

                Dim datar As DataRow

                For Each datar In dr2
                    tb.ImportRow(datar)
                Next

                Dim seqObject As Object = tb.Compute("Max(por_recseq)", "")
                Dim seq As Integer
                If IsDBNull(seqObject) Then
                    seq = 0 + 1
                Else
                    seq = Convert.ToInt32(seqObject) + 1
                End If
                'For i As Integer = 0 To dr2.Length
                '    maxseq = i
                'Next
                'maxseq += 1


                If dr.Length = 0 Then

                    dgGoodRec.Focus()
                    rs_pkordrec.Tables("RESULT").Rows.Add()

                    '  rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("Gen") = ""
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("Del") = ""
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_cocde") = cbococde.Text
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_ordno") = txtReqno.Text
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_ordseq") = txtSeq.Text
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_recseq") = seq
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_recdate") = DBNull.Value

                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_type") = "Production"
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_fty") = ""
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_extqty") = 0

                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_recqty") = 0
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_um") = ""
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_remark") = ""
                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_invno") = ""


                    rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("por_creusr") = "~*ADD*~"
                    recordstatus = True


                    dgGoodRec.CurrentCell = dgGoodRec.Rows(seq - 1).Cells(5)
                    dgGoodRec.BeginEdit(True)

                End If

                '  display_dgPKGoodRec(txtSeq.Text)









            ElseIf Got_Focus_Grid = "MS" Then

                If mode = "ReadOnly" Then
                    Exit Sub
                End If



                Dim rowcount As Integer
                rowcount = rs_PKMLTSHP.Tables("RESULT").Rows.Count
                'Dim dr() As DataRow = rs_TODTLSHP.Tables("RESULT").Select("tds_toordno = ''")
                Dim dr() As DataRow = rs_PKMLTSHP.Tables("RESULT").Select("pms_shpqty = 0 and pms_ordseq = " & txtSeq.Text)
                Dim dr2() As DataRow = rs_PKMLTSHP.Tables("RESULT").Select("pms_ordseq = " & txtSeq.Text, "pms_shpseq ASC")
                'sFilter = "tds_toordseq = " & seq & " and tds_verno = " & ver

                Dim maxseq As Integer

                Dim tb As New DataTable
                tb = rs_PKMLTSHP.Tables("RESULT").Clone

                Dim datar As DataRow

                For Each datar In dr2
                    tb.ImportRow(datar)
                Next

                Dim seqObject As Object = tb.Compute("Max(pms_shpseq)", "")
                Dim seq As Integer
                If IsDBNull(seqObject) Then
                    seq = 0 + 1
                Else
                    seq = Convert.ToInt32(seqObject) + 1
                End If
                'For i As Integer = 0 To dr2.Length
                '    maxseq = i
                'Next
                'maxseq += 1


                If dr.Length = 0 Then
                    dgMltShp.Focus()
                    rs_PKMLTSHP.Tables("RESULT").Rows.Add()

                    '  rs_pkordrec.Tables("RESULT").Rows(rowcount).Item("Gen") = ""
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("Del") = ""
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_cocde") = cbococde.Text
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_ordno") = txtReqno.Text
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_ordseq") = txtSeq.Text
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_shpseq") = seq

                    If txtHdrShpStr.Text <> "  /  /" Then
                        rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_shpstrdat") = txtHdrShpStr.Text
                    Else
                        rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_shpstrdat") = DBNull.Value
                    End If
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_shpenddat") = "1900-01-01"
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_shpqty") = 0
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_um") = ""
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_fty") = ""
                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_remark") = ""



                    rs_PKMLTSHP.Tables("RESULT").Rows(rowcount).Item("pms_creusr") = "~*ADD*~"



                    recordstatus = True

                    dgMltShp.CurrentCell = dgMltShp.Rows(seq - 1).Cells(5)
                    dgMltShp.BeginEdit(True)
                End If

                '  display_dgMLTSHP(txtSeq.Text)


            End If

        ElseIf BaseTabControl1.SelectedIndex = 0 Then

            If Got_Focus_Grid = "DIS" Then

                If mode = "ReadOnly" Then
                    Exit Sub
                End If



                Dim rowcount As Integer
                rowcount = rs_PKDISPRM_D.Tables("RESULT").Rows.Count
                'Dim dr() As DataRow = rs_TODTLSHP.Tables("RESULT").Select("tds_toordno = ''")
                Dim dr() As DataRow = rs_PKDISPRM_D.Tables("RESULT").Select("pdp_cde = '' and pdp_type = 'D' ")



                If dr.Length = 0 Then




                    rs_PKDISPRM_D.Tables("RESULT").Rows.Add()
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("DEL") = ""
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_cocde") = cbococde.Text
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_ordno") = txtReqno.Text
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_type") = "D"
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_seqno") = rowcount + 1
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_cde") = ""
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_dsc") = ""
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_pctamt") = "Percentage"
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_pct") = 0
                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_amt") = 0

                    rs_PKDISPRM_D.Tables("RESULT").Rows(rowcount).Item("pdp_creusr") = "~*ADD*~"

                    recordstatus = True



                End If





            ElseIf Got_Focus_Grid = "PRE" Then


                If mode = "ReadOnly" Then
                    Exit Sub
                End If



                Dim rowcount As Integer
                rowcount = rs_PKDISPRM_P.Tables("RESULT").Rows.Count
                'Dim dr() As DataRow = rs_TODTLSHP.Tables("RESULT").Select("tds_toordno = ''")
                Dim dr() As DataRow = rs_PKDISPRM_P.Tables("RESULT").Select("pdp_cde = '' and pdp_type = 'P' ")



                If dr.Length = 0 Then

                    rs_PKDISPRM_P.Tables("RESULT").Rows.Add()
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("DEL") = ""
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_cocde") = cbococde.Text
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_ordno") = txtReqno.Text
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_type") = "P"
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_seqno") = rowcount + 1
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_cde") = ""
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_dsc") = ""
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_pctamt") = "Percentage"
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_pct") = 0
                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_amt") = 0

                    rs_PKDISPRM_P.Tables("RESULT").Rows(rowcount).Item("pdp_creusr") = "~*ADD*~"

                    recordstatus = True



                End If


            End If


        End If
    End Sub

    Private Sub txtStkqty_Enter(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtStkqty.Enter
        If IsNumeric(txtStkqty.Text) = True Then
            If txtStkqty.Text = 0 Then
                If rdoOut.Checked = True Then
                    txtStkqty.Text = "-"
                End If
            End If
        End If
    End Sub

    Private Sub txtStkqty_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtStkqty.KeyDown
        If e.KeyValue = Keys.Delete Then
            flag_panpack_keypress = True
            recordstatus = True
            SetAsUpdate(txtSeq.Text)
        End If
    End Sub



    Private Sub txtStkqty_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtStkqty.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8 Or Asc(e.KeyChar) = 45 Or Asc(e.KeyChar) = 13) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If


        flag_panpack_keypress = True
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtStkqty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtStkqty.TextChanged
        If flag_panpack_keypress = True Then
            flag_panpack_keypress = False





            If rdoIn.Checked = True Then
                If txtStkqty.Text = "" Then
                    'txtStkqty.Text = 0
                    'txtStkqty.SelectionStart = 1
                    Exit Sub
                End If
            End If

            If rdoOut.Checked = True Then

                If txtStkqty.Text = "-" Then
                    txtStkqty.SelectionStart = 1
                    Exit Sub
                End If

                If txtStkqty.Text = "" Then
                    txtStkqty.Text = "-"
                    txtStkqty.SelectionStart = 1
                    Exit Sub
                End If
            End If

            If IsNumeric(txtStkqty.Text) Then





                If rdoIn.Checked = True Then
                    Dim ordqty As Integer = txtPkgOrdQty.Text
                    Dim stkqty As Integer = txtStkqty.Text
                    'Dim sumqty As Integer = ordqty + stkqty
                    Dim sumqty As Integer = ordqty
                    Dim cate As String = Split(txtCate.Text, " - ")(0)

                    Dim dr() As DataRow
                    dr = rs_syswasge.Tables("RESULT").Select("pwa_code = '" & cate & "' and pwa_qtyfrm <= " & sumqty & " and pwa_qtyto >= " & sumqty)

                    'gspStr = "sp_select_PKWASGE_PKG02 '" & Split(txtCate.Text, " - ")(0) & "'," & txtPkgOrdQty.Text
                    'rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                    'If rtnLong <> RC_SUCCESS Then
                    '    MsgBox("Error on loading txtPkgOrdQty_LostFocus sp_select_PKWASGE_PKG02 :" & rtnStr)
                    '    Exit Sub
                    'End If

                    If dr.Length <> 0 Then
                        If dr(0)("pwa_um") = "%" Then

                            txtPkgWastPer.Text = Fix(dr(0).Item("pwa_wasage"))
                            ' txtPkgWast.Text = Math.Round(sumqty * dr(0).Item("pwa_wasage") / 100)
                            txtPkgWast.Text = Math.Round(sumqty * dr(0).Item("pwa_wasage") / 100, 0, MidpointRounding.AwayFromZero)
                            '  wasqty = Math.Round(ttlordqty * dr_wasage(0).Item("pwa_wasage") / 100, 0, MidpointRounding.AwayFromZero)

                        Else
                            txtPkgWastPer.Text = ""
                            txtPkgWast.Text = Fix(dr(0).Item("pwa_wasage"))
                        End If


                    End If
                End If
            Else
                MsgBox("Please input valid Order Qty")
                Exit Sub
            End If


            'txtBonQty.Text = txtPkgWast.Text
            'txtBonQty.ForeColor = Color.Black

            'If txtPkgWast.Text <> txtBonQty.Text Then
            '    txtBonQty.ForeColor = Color.Red
            'Else
            '    txtBonQty.ForeColor = Color.Black
            'End If



            calTotalOrdQty()
            calTotalAMT()
        End If
    End Sub

    Private Sub txtStkqty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtStkqty.Validated

        If txtStkqty.Text = "-" Then
            txtStkqty.Text = 0
        End If

        If txtStkqty.Text = "" Then
            txtStkqty.Text = 0
        End If


        txtStkqty.Text = Convert.ToInt32(txtStkqty.Text)


        If rdoIn.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current > 0 Then

            Else
                txtStkqty.Text = current * -1
            End If


            Dim dr() As DataRow
            dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "'")

            If dr.Length = 0 Then
                ' txtStkqty.Text = 0
            ElseIf dr.Length <> 0 Then

                Dim sumqty As Integer = 0

                For i As Integer = 0 To dr.Length - 1
                    sumqty = sumqty + dr(i)("pih_avlqty")
                Next

                Dim pastqty As Integer
                Dim pastrow() As DataRow

                pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & txtSeq.Text)
                If pastrow.Length <> 0 Then
                    pastqty = pastrow(0)("pih_avlqty")
                Else
                    pastqty = 0
                End If

                Dim currentqty As Integer = Convert.ToInt32(txtStkqty.Text)
                Dim wasageqty As Integer = txtPkgWast.Text
                Dim ordqty As Integer = txtPkgOrdQty.Text


                If (sumqty - pastqty + currentqty) < 0 Then
                    txtStkqty.Text = pastqty
                    MsgBox("Cannot lower than current stock qty (" & pastqty - sumqty & ").")
                End If




            End If


        ElseIf rdoOut.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current > 0 Then
                txtStkqty.Text = current * -1
            Else

            End If


            If txtStkqty.Text <> 0 Then

                Dim dr() As DataRow
                dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "'")


                If dr.Length = 0 Then

                    MsgBox("Packaging Item not found in inventory")
                    txtStkqty.Text = 0


                ElseIf dr.Length <> 0 Then


                    Dim sumqty As Integer = 0


                    For i As Integer = 0 To dr.Length - 1
                        sumqty = sumqty + dr(i)("pih_avlqty")
                    Next

                    Dim pastqty As Integer
                    Dim pastrow() As DataRow

                    pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & txtSeq.Text)
                    If pastrow.Length <> 0 Then
                        pastqty = pastrow(0)("pih_avlqty")
                    Else
                        pastqty = 0
                    End If


                    'Dim maxqty As Integer = dr(0)("pih_avlqty")
                    Dim currentqty As Integer = Convert.ToInt32(txtStkqty.Text) * -1
                    Dim wasageqty As Integer = txtPkgWast.Text
                    Dim ordqty As Integer = txtPkgOrdQty.Text
                    Dim bonqty As Integer = txtBonQty.Text


                    If (sumqty - pastqty - currentqty) < 0 Then
                        txtStkqty.Text = 0
                        MsgBox("The inventory stock qty is (" & sumqty - pastqty & ").") 'sumqty - pastqty
                    Else

                        ' If currentqty > (wasageqty + ordqty) Then
                        If currentqty > (bonqty + ordqty) Then
                            txtStkqty.Text = (bonqty + ordqty) * -1

                        End If

                    End If

                End If
            End If



        End If

        calTotalOrdQty()
        calTotalAMT()

        update_PKREQDTL()

        Dim ttlpri As Decimal

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA") <> 0 Then
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA"), 2)
            Else
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty"), 2)
            End If

        Next

        txtHdrTtlAmt.Text = ttlpri


        Dim HdrTtlam As Decimal
        Dim HdrDCAMT As Decimal

        HdrTtlam = txtHdrTtlAmt.Text
        If txtHdrDC.Text = "" Then
            HdrDCAMT = 0
        Else
            HdrDCAMT = txtHdrDC.Text
        End If

        txtHdrTA_F.Text = HdrTtlam + HdrDCAMT


        Dim hdrTA_F As Decimal
        hdrTA_F = txtHdrTA_F.Text

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)


                If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)

                If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        Dim total_Dis As Decimal = 0
        Dim total_Pre As Decimal = 0

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
            End If
        Next


        txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre


        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

    End Sub


    Private Function round(ByVal a As Double, ByVal Value As Double) As Double
        Dim S As String

        S = "0"

        If Value = 0 Then S = "0"
        If Value = 1 Then S = "0.0"
        If Value = 2 Then S = "0.00"
        If Value = 3 Then S = "0.000"
        If Value = 4 Then S = "0.0000"
        If Value = 5 Then S = "0.00000"
        If Value = 6 Then S = "0.000000"
        If Value = 7 Then S = "0.0000000"
        If Value = 8 Then S = "0.00000000"
        If Value = 9 Then S = "0.000000000"
        If Value = 10 Then S = "0.0000000000"

        round = CDbl(Format(a, S))
    End Function



    Private Sub calTotalAMT()

        'If txtGenFlag.Text = "Total Amount" Then
        '    Exit Sub
        'End If

        Dim totalOrderQty As Integer
        Dim unitprice As Decimal

        If txtPkgTtlQty.Text = "" Then
            totalOrderQty = 0
        Else
            totalOrderQty = txtPkgTtlQty.Text
        End If

        If txtPkgUnitPri.Text = "" Then
            unitprice = 0
        Else
            unitprice = txtPkgUnitPri.Text

        End If


        txtTtlAmt.Text = round(totalOrderQty * round(unitprice, 5), 2)


    End Sub
    Private Sub calTotalOrdQty()

        Dim orderqty As Integer

        If txtPkgOrdQty.Text = "" Then
            orderqty = 0
        Else
            orderqty = txtPkgOrdQty.Text
        End If


        'Dim Wast As Integer


        'If txtPkgWast.Text = "" Then
        '    Wast = 0
        'Else
        '    Wast = txtPkgWast.Text
        'End If



        Dim Bon As Integer


        If txtBonQty.Text = "" Then
            Bon = 0
        Else
            Bon = txtBonQty.Text
        End If


        Dim stock As Integer

        If txtStkqty.Text = "" Then
            stock = 0
        Else
            stock = txtStkqty.Text
        End If


        txtPkgTtlQty.Text = orderqty + Bon + stock


    End Sub







    Private Sub txtStkqty_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtStkqty.Validating
        If txtStkqty.Text = "" Or txtStkqty.Text = "-" Then
            Exit Sub
        End If




        If IsNumeric(txtStkqty.Text) = False Then

            MsgBox("Please input valid integer")
            txtStkqty.Focus()
            e.Cancel = True
        End If
    End Sub

    Private Sub txtPkgWast_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtPkgWast.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If

        recordstatus = True
        flag_panpack_keypress = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtPkgWast_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPkgWast.TextChanged
        If flag_panpack_keypress = True Then
            flag_panpack_keypress = False

            txtPkgWastPer.Text = ""

            If txtPkgWast.Text = "" Then
                txtPkgWast.Text = 0
            End If

            calTotalOrdQty()
            calTotalAMT()
        End If






    End Sub

    Private Sub txtPkgWast_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPkgWast.Validated

    End Sub

    Private Sub txtPkgWast_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtPkgWast.Validating
        If txtPkgWast.Text = "" Then
            Exit Sub
        End If

        If IsNumeric(txtPkgWast.Text) = False Then

            MsgBox("Please input valid integer")
            txtPkgWast.Focus()
            e.Cancel = True
        End If
    End Sub



    Private Sub update_PKREQDTL()

        'If flag_disply = True Then
        '    Exit Sub
        'End If

        If rs_PKORDDTL.Tables("RESULT").Rows.Count = 0 Then
            Exit Sub

        End If

        If Trim(txtSeq.Text) = "" Then
            Exit Sub
        End If

        Dim seq As Integer
        seq = txtSeq.Text
        Dim loc As Integer = -1


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If seq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") Then
                loc = i
            End If

        Next

        If loc = -1 Then
            MsgBox("Error Request detail not found!")
            Exit Sub
        End If



        'Dim realitem As String
        'Dim tmpitem As String
        'Dim venitem As String
        'Dim venno As String

        'Dim PackUnt As String
        'Dim inr As Integer
        'Dim master As Integer
        'Dim ftyprctrm As String
        'Dim hkprctrm As String
        'Dim trantrm As String
        'Dim cft As Decimal

        'realitem = Split(txtItemNo.Text, " / ")(0)
        'tmpitem = Split(txtItemNo.Text, " / ")(1)
        'venitem = Split(txtItemNo.Text, " / ")(2)
        'venno = Split(txtItemNo.Text, " / ")(3)

        'PackUnt = Split(txtTerms.Text, " / ")(0)
        'inr = Split(txtTerms.Text, " / ")(1)
        'master = Split(txtTerms.Text, " / ")(2)
        'cft = Split(txtTerms.Text, " / ")(3)
        'ftyprctrm = Split(txtTerms.Text, " / ")(4)
        'hkprctrm = Split(txtTerms.Text, " / ")(5)
        'trantrm = Split(txtTerms.Text, " / ")(6)


        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_cocde") = cbococde.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_reqno") = ""
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_seq") = txtSeq.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_itemno") = realitem
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_tmpitmno") = tmpitem
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_venno") = venno
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_venitm") = venitem
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_pckunt") = PackUnt
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_inrqty") = inr
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_mtrqty") = master
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_cft") = cft
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_ftyprctrm") = ftyprctrm
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_hkprctrm") = hkprctrm
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_trantrm") = trantrm
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_pkgitm") = txtPkgItem.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_pkgven") = Split(cboPkgVendor.Text, " - ")(0)
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_cate") = txtCate.Text '*
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_chndsc") = txtPkgChDesc.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_engdsc") = txtPkgEnDesc.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_remark") = txtPkgRemark.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EInchL") = txtEISizeL.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EInchW") = txtEISizeW.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EInchH") = txtEISizeH.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EcmL") = txtECSizeL.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EcmW") = txtECSizeW.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_EcmH") = txtECSizeH.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FInchL") = txtFISizeL.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FinchW") = txtFISizeW.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FinchH") = txtFISizeH.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FcmL") = txtFCSizeL.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FcmW") = txtFCSizeW.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_FcmH") = txtFCSizeH.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_matral") = txtMatri.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_tiknes") = txtTcknes.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_prtmtd") = txtPrtMtd.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_clrfot") = txtForntCol.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_clrbck") = txtBackCol.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_finish") = txtFinish.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_rmtnce") = cboRemi.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_addres") = txtPkgAddress.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_state") = txtPkgState.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_cntry") = txtPkgCtry.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_zip") = txtZip.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_Tel") = txtTel.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_cntper") = cboPkgCtnPer.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_sctoqty") = txtPkgSTQty.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_qtyum") = cboSTOUM.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_curcde") = txtPkgUnitPriCur.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_multip") = 1 'care txtPkgMult.Text
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_ordqty") = txtPkgOrdQty.Text


        If txtPkgWastPer.Text = "" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasper") = 0
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasper") = txtPkgWastPer.Text
        End If


        If txtBonQty.Text = "" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_bonqty") = 0
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_bonqty") = txtBonQty.Text
        End If

        If cboDtlFty.Text <> "" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_fty") = cboDtlFty.Text
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_fty") = ""
        End If

        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_addres_fty") = cboHdrAdd_dtl.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_state_fty") = txtHdrSta_dtl.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntry_fty") = txtHdrCty_dtl.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_zip_fty") = txtHdrzip_dtl.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_tel_fty") = txtHdrTel_dtl.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_cntper_fty") = cboHdrCtn_dtl.Text


        If txtDtlShpEnd.Text = "  /  /" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpend") = "01/01/1900"
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpend") = txtDtlShpEnd.Text
        End If

        If txtDtlShpStr.Text = "  /  /" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpstr") = "01/01/1900"
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_shpstr") = txtDtlShpStr.Text
        End If



        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_wasqty") = txtPkgWast.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ttlordqty") = txtPkgTtlQty.Text
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("prd_untprc") = txtPkgUnitPri.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_ttlamtqty") = txtTtlAmt.Text
        'rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("prd_receqty") = 1 '*
        'rs_PKREQDTL.Tables("RESULT").Rows(loc).Item("prd_creusr") = cbococde.Text

        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_stkqty") = txtStkqty.Text
        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_Conmak") = txtConRemark.Text

        If IsNumeric(txtMOA.Text) Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_MOA") = txtMOA.Text
        Else
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_MOA") = 0
        End If

        rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_qtyum") = cboTtlUm.Text

    End Sub

    Private Sub SetAsUpdate(ByVal seq As String)

        Dim loc As Integer = -1


        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If seq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") Then
                loc = i
            End If

        Next

        If loc = -1 Then
            MsgBox("Error Request detail not found!")
            Exit Sub
        End If


        If rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") <> "~*ADD*~" Then
            rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_creusr") = "~*UPD*~"

        End If




    End Sub



    Private Sub BaseTabControl1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BaseTabControl1.SelectedIndexChanged
        If BaseTabControl1.SelectedIndex = 2 Then


            'If rs_PKREQDTL.Tables("RESULT").Rows.Count <> 0 Then
            '    If CheckValid() = False Then
            '        Exit Sub
            '    End If
            'End If
            update_PKREQDTL()

            ' display_dgSummary()
        ElseIf BaseTabControl1.SelectedIndex = 1 Then
            If dgPKORDDTL.RowCount > 0 Then
                If dgPKORDDTL.SelectedCells.Count = 1 Or dgPKORDDTL.SelectedRows.Count = 1 Then
                    Dim dgseq As Integer
                    Dim ver As Integer

                    If dgPKORDDTL.SelectedCells.Count = 1 Then
                        dgseq = dgPKORDDTL.Item(dgPKORDDTL_pod_seq, dgPKORDDTL.SelectedCells.Item(0).RowIndex).Value

                    Else
                        dgseq = dgPKORDDTL.SelectedRows.Item(0).Cells(dgPKORDDTL_pod_seq).Value

                    End If

                    ' If Not (seq = txtSeq.Text And ver = txtVerNo.Text) Then

                    Dim loc As Integer = -1


                    For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
                        If dgseq = rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") Then
                            loc = i
                        End If

                    Next

                    If loc = -1 Then
                        MsgBox("Error Order detail not found!")
                        Exit Sub
                    End If


                    display_PKREQDTL(loc)

                    Dim seque As Integer = rs_PKORDDTL.Tables("RESULT").Rows(loc).Item("pod_seq")
                    display_dgPKGoodRec(seque)
                    display_dgMLTSHP(seque)

                    'End If
                End If
            End If
        ElseIf BaseTabControl1.SelectedIndex = 0 Then

            'If mode = "INIT" Then
            '    Exit Sub
            'End If


            'update_PKREQDTL()


            'Dim ttlpri As Decimal

            'For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            '    ttlpri = ttlpri + rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty")
            'Next

            'txtHdrTtlAmt.Text = ttlpri


        End If
    End Sub

    Private Sub txtPkgOrdQty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPkgOrdQty.TextChanged

    End Sub

    Private Sub cmdRelease_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRelease.Click
        FrmPGM00008 = New PGM00008
        FrmPGM00008.txtFrom.Text = txtReqno.Text
        FrmPGM00008.txtTo.Text = txtReqno.Text
        FrmPGM00008.company = cbococde.Text

        FrmPGM00008.txtFrom.Enabled = False
        FrmPGM00008.txtTo.Enabled = False
        FrmPGM00008.optRel.Enabled = False
        FrmPGM00008.optUnr.Enabled = False

        If cboStatus.Text.Split(" -")(0) = "REL" Then
            FrmPGM00008.optUnr.Checked = True
        Else
            FrmPGM00008.optRel.Checked = True
        End If

        FrmPGM00008.ShowDialog()
    End Sub

    Private Sub Label30_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label30.Click

    End Sub

    Private Sub txtConRemark_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtConRemark.KeyPress
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtConRemark_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtConRemark.TextChanged

    End Sub

    Private Sub txtDvyDat_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDvyDat.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtDvyDat_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtDvyDat.KeyUp
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtDvyDat_MaskInputRejected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MaskInputRejectedEventArgs) Handles txtDvyDat.MaskInputRejected

    End Sub

    Private Sub txtDremark_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDremark.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtiremark_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtiremark.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub
    Private Sub txtDremark_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDremark.TextChanged

    End Sub

    Private Sub txtDvyDat_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtDvyDat.Validating

        If (IsDate(txtDvyDat.Text) = True And txtDvyDat.Text.Length = 10) Or txtDvyDat.Text = "  /  /" Then


        Else
            MsgBox("Please Input valid Delivery Date.[MM/dd/yyyy]")
            BaseTabControl1.SelectedIndex = 0
            txtDvyDat.Focus()
        End If
    End Sub



    Private Sub rdoIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdoIn.Click
        SetAsUpdate(txtSeq.Text)
        recordstatus = True




        Dim pastrow() As DataRow

        pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & txtSeq.Text)
        If pastrow.Length <> 0 Then
            txtStkqty.Text = pastrow(0)("pih_avlqty")
        Else
            txtStkqty.Text = 0
        End If


        Dim ordqty As Integer = txtPkgOrdQty.Text
        Dim stkqty As Integer = txtStkqty.Text
        ' Dim sumqty As Integer = ordqty + stkqty
        Dim sumqty As Integer = ordqty
        Dim cate As String = Split(txtCate.Text, " - ")(0)

        Dim dr2() As DataRow
        dr2 = rs_syswasge.Tables("RESULT").Select("pwa_code = '" & cate & "' and pwa_qtyfrm <= " & sumqty & " and pwa_qtyto >= " & sumqty)

        'gspStr = "sp_select_PKWASGE_PKG02 '" & Split(txtCate.Text, " - ")(0) & "'," & txtPkgOrdQty.Text
        'rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        'If rtnLong <> RC_SUCCESS Then
        '    MsgBox("Error on loading txtPkgOrdQty_LostFocus sp_select_PKWASGE_PKG02 :" & rtnStr)
        '    Exit Sub
        'End If

        If dr2.Length <> 0 Then
            If dr2(0)("pwa_um") = "%" Then

                txtPkgWastPer.Text = Fix(dr2(0).Item("pwa_wasage"))
                'txtPkgWast.Text = Math.Round(sumqty * dr2(0).Item("pwa_wasage") / 100)
                txtPkgWast.Text = Math.Round(sumqty * dr2(0).Item("pwa_wasage") / 100, 0, MidpointRounding.AwayFromZero)

            Else
                txtPkgWastPer.Text = ""
                txtPkgWast.Text = Fix(dr2(0).Item("pwa_wasage"))
            End If


        End If



        calTotalOrdQty()
        calTotalAMT()






        If rdoIn.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current > 0 Then
                Exit Sub
            Else
                txtStkqty.Text = current * -1
            End If


        ElseIf rdoOut.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current >= 0 Then
                txtStkqty.Text = current * -1
            Else
                Exit Sub
            End If


        End If
        calTotalOrdQty()
        calTotalAMT()

    End Sub



    Private Sub rdoOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdoOut.Click





        SetAsUpdate(txtSeq.Text)
        recordstatus = True



        Dim ordqty As Integer = txtPkgOrdQty.Text
        Dim stkqty As Integer = 0
        ' Dim sumqty As Integer = ordqty + stkqty
        Dim sumqty As Integer = ordqty
        Dim cate As String = Split(txtCate.Text, " - ")(0)

        Dim dr2() As DataRow
        dr2 = rs_syswasge.Tables("RESULT").Select("pwa_code = '" & cate & "' and pwa_qtyfrm <= " & sumqty & " and pwa_qtyto >= " & sumqty)

        'gspStr = "sp_select_PKWASGE_PKG02 '" & Split(txtCate.Text, " - ")(0) & "'," & txtPkgOrdQty.Text
        'rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
        'If rtnLong <> RC_SUCCESS Then
        '    MsgBox("Error on loading txtPkgOrdQty_LostFocus sp_select_PKWASGE_PKG02 :" & rtnStr)
        '    Exit Sub
        'End If

        If dr2.Length <> 0 Then
            If dr2(0)("pwa_um") = "%" Then

                txtPkgWastPer.Text = Fix(dr2(0).Item("pwa_wasage"))
                'txtPkgWast.Text = Math.Round(sumqty * dr2(0).Item("pwa_wasage") / 100)
                txtPkgWast.Text = Math.Round(sumqty * dr2(0).Item("pwa_wasage") / 100, 0, MidpointRounding.AwayFromZero)

            Else
                txtPkgWastPer.Text = ""
                txtPkgWast.Text = Fix(dr2(0).Item("pwa_wasage"))
            End If


        End If

        'follow valided

        calTotalOrdQty()
        calTotalAMT()



        Dim dr() As DataRow
        dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "'")


        If dr.Length = 0 Then
            txtStkqty.Text = 0
        ElseIf dr.Length <> 0 Then


            Dim summaxqty As Integer = 0

            For i As Integer = 0 To dr.Length - 1
                summaxqty = summaxqty + dr(i)("pih_avlqty")
            Next

            Dim pastqty As Integer
            Dim pastrow() As DataRow

            pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & txtPkgItem.Text & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & txtSeq.Text)
            If pastrow.Length <> 0 Then
                pastqty = pastrow(0)("pih_avlqty")
            Else
                pastqty = 0
            End If

            'Dim maxqty As Integer = dr(0)("pih_avlqty")
            ' Dim currentqty As Integer = Convert.ToInt32(txtStkqty.Text) * -1
            Dim wasageqty As Integer = txtPkgWast.Text
            Dim pkgordqty As Integer = txtPkgOrdQty.Text
            Dim bonqty As Integer = txtBonQty.Text


            If (summaxqty - pastqty - 0) <= 0 Then
                txtStkqty.Text = 0

            Else
                'If (summaxqty - pastqty) > (wasageqty + ordqty) Then
                If (summaxqty - pastqty) > (bonqty + ordqty) Then
                    'txtStkqty.Text = wasageqty + ordqty
                    txtStkqty.Text = bonqty + ordqty
                Else
                    txtStkqty.Text = (summaxqty - pastqty)
                End If
            End If




            'Dim pkgordqty As Integer = txtPkgOrdQty.Text
            'Dim wasge As Integer = txtPkgWast.Text

            'If dr(0)("pih_avlqty") > pkgordqty + wasge Then
            '    txtStkqty.Text = pkgordqty + wasge
            'Else
            '    txtStkqty.Text = dr(0)("pih_avlqty")
            'End If
        End If

        calTotalOrdQty()
        calTotalAMT()



        If rdoIn.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current > 0 Then
                Exit Sub
            Else
                txtStkqty.Text = current * -1
            End If


        ElseIf rdoOut.Checked = True Then

            Dim current As Integer = txtStkqty.Text

            If current >= 0 Then
                txtStkqty.Text = current * -1
            Else
                Exit Sub
            End If


        End If


        calTotalOrdQty()
        calTotalAMT()

    End Sub


    Private Sub rdoIn_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdoIn.CheckedChanged

    End Sub

    Private Sub txtPkgUnitPri_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPkgUnitPri.TextChanged

    End Sub

    Private Sub mmdSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdSearch.Click
        Dim frmSYM00018 As New SYM00018

        frmSYM00018.keyName = txtReqno.Name
        frmSYM00018.strModule = "PG"

        frmSYM00018.show_frmSYM00018(Me)


    End Sub

    Private Sub dgMltShp_CellBeginEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellCancelEventArgs) Handles dgMltShp.CellBeginEdit
        dgMltShpEditCellRow = sender.CurrentCell.RowIndex
        dgMltShpEditCellCol = sender.CurrentCell.ColumnIndex
    End Sub

    Private Sub dgMltShp_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMltShp.CellClick
        If mode = "ReadOnly" Then
            Exit Sub
        End If '

        If dgMltShp.RowCount = 0 Then
            Exit Sub
        End If

        If e.RowIndex = -1 Or e.ColumnIndex = -1 Then
            Exit Sub
        End If

        Try
            If dgMltShp.RowCount > 0 Then
                If dgMltShp.CurrentCell.ColumnIndex = 9 Then
                    comboBoxCell(dgMltShp, "VN")
                End If
                If dgMltShp.CurrentCell.ColumnIndex = 10 Then
                    comboBoxCell(dgMltShp, "AD")
                End If
                If dgMltShp.CurrentCell.ColumnIndex = 15 Then
                    comboBoxCell(dgMltShp, "CT")
                End If
            End If
        Catch
        End Try

      

    End Sub




    Private Sub comboBoxCell(ByVal dgv As DataGridView, ByVal typ As String)
        Dim cboCell As New DataGridViewComboBoxCell
        Dim iCol As Integer = dgv.CurrentCell.ColumnIndex
        Dim iRow As Integer = dgv.CurrentCell.RowIndex

        Dim row As DataGridViewRow = dgv.CurrentRow

        'dgv.Rows(iRow).Cells(iCol).ReadOnly = True

        Dim i As Integer
        Try
            Select Case typ
                Case "VN"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("")

                    Dim dr() As DataRow
                    dr = rs_VNBASINF_MS.Tables("RESULT").Select("vbi_vensts = 'A'", "vbi_vensna")


                    For i = 0 To dr.Length - 1
                        'If rs_VNBASINF_MS.Tables("RESULT").Rows(i).Item("vbi_vensts") = "A" Then
                        cboCell.Items.Add(dr(i).Item("vbi_vensna") & " - " & dr(i).Item("vbi_venno"))

                        'End If
                    Next i

                    'For i = 0 To rs_VNBASINF_MS.Tables("RESULT").Rows.Count - 1
                    '    If rs_VNBASINF_MS.Tables("RESULT").Rows(i).Item("vbi_vensts") = "A" Then
                    '        cboCell.Items.Add(rs_VNBASINF_MS.Tables("RESULT").Rows(i).Item("vbi_venno") & " - " & rs_VNBASINF_MS.Tables("RESULT").Rows(i).Item("vbi_vensna"))
                    '    End If
                    'Next i

                Case "AD"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("")

                    Dim dr() As DataRow
                    dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(dgMltShp.Rows(dgMltShpEditCellRow).Cells(9).Value, " - ")(1) & "'")

                    'For i = 0 To dr.Length - 1
                    '    cboCell.Items.Add(dr(i).Item("vbi_vensna") & " - " & dr(i).Item("vbi_venno"))
                    'Next i
                    If dr.Length <> 0 Then
                        For j As Integer = 0 To dr.Length - 1
                            cboCell.Items.Add(dr(j)("vci_address").ToString)
                        Next
                        'For j As Integer = 0 To dr.Length - 1
                        '    cboHdrCtn_dtl.Items.Add(dr(j)("vci_cntctp").ToString)
                        'Next
                    End If


                Case "CT"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("")

                    Dim dr() As DataRow
                    dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(dgMltShp.Rows(dgMltShpEditCellRow).Cells(9).Value, " - ")(1) & "'")

                    'For i = 0 To dr.Length - 1
                    '    cboCell.Items.Add(dr(i).Item("vbi_vensna") & " - " & dr(i).Item("vbi_venno"))
                    'Next i
                    If dr.Length <> 0 Then
                        'For j As Integer = 0 To dr.Length - 1
                        '    cboCell.Items.Add(dr(j)("vci_address").ToString)
                        'Next
                        For j As Integer = 0 To dr.Length - 1
                            cboCell.Items.Add(dr(j)("vci_cntctp").ToString)
                        Next
                    End If



                Case "type"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("Inventory")
                    cboCell.Items.Add("Production")




                Case "DIS"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("")

                    Dim dr() As DataRow
                    dr = rs_SYDISPRM.Tables("RESULT").Select("ydp_type = 'D'")

                    For i = 0 To dr.Length - 1
                        cboCell.Items.Add(dr(i).Item("ydp_cde") & " - " & dr(i).Item("ydp_dsc"))
                    Next


                Case "PRE"
                    cboCell.Items.Clear()
                    cboCell.Items.Add("")

                    Dim dr() As DataRow
                    dr = rs_SYDISPRM.Tables("RESULT").Select("ydp_type = 'P'")

                    For i = 0 To dr.Length - 1
                        cboCell.Items.Add(dr(i).Item("ydp_cde") & " - " & dr(i).Item("ydp_dsc"))
                    Next



            End Select

            cboCell.DropDownWidth = 200
            cboCell.DisplayStyle = DataGridViewComboBoxDisplayStyle.ComboBox

            dgv.Rows(iRow).Cells(iCol) = cboCell
            dgv.Rows(iRow).Cells(iCol).ReadOnly = False
        Catch
            MsgBox("")
        End Try

    End Sub



    Private Sub dgMltShp_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMltShp.CellContentClick

    End Sub

    Private Sub dgMltShp_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMltShp.CellDoubleClick
        If mode = "ReadOnly" Then
            Exit Sub
        End If

        If dgMltShp.RowCount = 0 Then
            Exit Sub
        End If

        If e.ColumnIndex = -1 Or e.RowIndex = -1 Then
            Exit Sub
        End If

        If dgMltShp.RowCount > 0 Then


            If dgMltShp.CurrentCell.ColumnIndex = 0 Then
                Dim iCol As Integer = dgMltShp.CurrentCell.ColumnIndex
                Dim iRow As Integer = dgMltShp.CurrentCell.RowIndex
                Dim curvalue As String
                curvalue = dgMltShp.CurrentCell.Value
                If Trim(curvalue) = "" Then

                    dgMltShp.Item(0, iRow).Value = "Y"

                Else
                    dgMltShp.Item(0, iRow).Value = ""
                End If


                'If dgMltShp.Item(dgMShp_tds_creusr, iRow).Value <> "~*ADD*~" Then
                '    dgMltShp.Item(dgMShp_tds_creusr, iRow).Value = "~*UPD*~"
                recordstatus = True
                'End If

            End If
        End If

    End Sub

    Private Sub dgMltShp_CellEndEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgMltShp.CellEndEdit
        If IsDBNull(dgMltShp.Item(7, dgMltShp.CurrentCell.RowIndex).Value) = True Then
            dgMltShp.Item(7, dgMltShp.CurrentCell.RowIndex).Value = 0
        End If

        If IsDBNull(dgMltShp.Item(9, dgMltShp.CurrentCell.RowIndex).Value) = True Then
            dgMltShp.Item(9, dgMltShp.CurrentCell.RowIndex).Value = ""
        End If

        If dgMltShpEditCellCol = 9 Then

            dgMltShp.Rows(e.RowIndex).Cells(10).Value = ""
            dgMltShp.Rows(e.RowIndex).Cells(11).Value = ""
            dgMltShp.Rows(e.RowIndex).Cells(12).Value = ""
            dgMltShp.Rows(e.RowIndex).Cells(13).Value = ""
            dgMltShp.Rows(e.RowIndex).Cells(14).Value = ""
            dgMltShp.Rows(e.RowIndex).Cells(15).Value = ""
            '            cboHdrAdd_dtl.Items.Clear()
            '           cboHdrCtn_dtl.Items.Clear()

            If InStr(dgMltShp.Rows(e.RowIndex).Cells(9).Value, "-") = 0 Then
                Exit Sub
            End If

            Dim dr() As DataRow
            dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(dgMltShp.Rows(e.RowIndex).Cells(9).Value, " - ")(1) & "'")
            If dr.Length <> 0 Then
                'For j As Integer = 0 To dr.Length - 1
                '    cboHdrAdd_dtl.Items.Add(dr(j)("vci_address").ToString)
                'Next
                dgMltShp.Rows(e.RowIndex).Cells(10).Value = dr(0)("vci_address").ToString

                dgMltShp.Rows(e.RowIndex).Cells(11).Value = dr(0)("vci_stt").ToString
                dgMltShp.Rows(e.RowIndex).Cells(12).Value = dr(0)("vci_cty").ToString
                dgMltShp.Rows(e.RowIndex).Cells(13).Value = dr(0)("vci_zip").ToString
                dgMltShp.Rows(e.RowIndex).Cells(14).Value = dr(0)("vci_cntphn").ToString

                'For j As Integer = 0 To dr.Length - 1
                '    cboHdrCtn_dtl.Items.Add(dr(j)("vci_cntctp").ToString)
                'Next
                dgMltShp.Rows(e.RowIndex).Cells(15).Value = dr(0)("vci_cntctp").ToString
            End If



        End If


        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgMltShp.CurrentCell.ColumnIndex

                Case 9
                    'dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value = Split(dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value, " - ")(0)
                    dgMltShp.Item(9, dgMltShp.CurrentCell.RowIndex) = txtCell

                Case 5

                    ' dgMltShp.Item(6, dgMltShp.CurrentCell.RowIndex).Value = dgMltShp.Item(5, dgMltShp.CurrentCell.RowIndex).Value

            End Select
        Catch
        End Try



        If dgMltShp.Item(17, e.RowIndex).Value <> "~*ADD*~" Then
            dgMltShp.Item(17, e.RowIndex).Value = "~*UPD*~"

        End If


        recordstatus = True
    End Sub



    Private Sub dgMltShp_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgMltShp.CellValidating
        Dim row As DataGridViewRow = dgMltShp.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then
            Select Case e.ColumnIndex




                Case 5 'Date

                    If strNewVal = "" Then
                        Exit Sub
                    End If


                    If strNewVal.Length <> 10 Or IsDate(strNewVal) = False Then


                        MsgBox("Please Input valid Date format [MM/dd/yyyy]")
                        e.Cancel = True
                        Exit Sub


                    Else




                        If Convert.ToDateTime(Now.Date) > Convert.ToDateTime(strNewVal) Then
                            MsgBox("Ship Date cannot earlier than System Date")
                            e.Cancel = True
                            Exit Sub
                        End If


                        If Convert.ToDateTime(txtIssDate.Text) > Convert.ToDateTime(strNewVal) Then
                            MsgBox("Ship Date cannot earlier than PO Issue Date")
                            e.Cancel = True
                            Exit Sub
                        End If




                        If e.ColumnIndex = 5 Then


                            'If IsDate(dgMltShp.Item(6, e.RowIndex).Value) = True Then

                            '    If Convert.ToDateTime(strNewVal) > Convert.ToDateTime(dgMltShp.Item(6, e.RowIndex).Value) Then
                            '        MsgBox("Ship Start Date must be earlier than Ship End Date!")
                            '        e.Cancel = True
                            '        Exit Sub
                            '    End If

                            'End If

                        ElseIf e.ColumnIndex = 6 Then


                            'If IsDate(dgMltShp.Item(5, e.RowIndex).Value) = True Then

                            '    If Convert.ToDateTime(strNewVal) < Convert.ToDateTime(dgMltShp.Item(5, e.RowIndex).Value) Then
                            '        MsgBox("Ship End Date must be later than Ship Str Date!")
                            '        e.Cancel = True
                            '        Exit Sub
                            '    End If

                            'End If

                        End If



                    End If




                Case 7


                    If strNewVal = "" Then

                        Exit Sub
                    End If




                    If Not IsNumeric(strNewVal) Then
                        MsgBox("Invalid Quantity!")
                        e.Cancel = True
                        Exit Sub
                    End If


                    If strNewVal.Contains(".") = True Then
                        MsgBox("Invalid Quantity!")
                        e.Cancel = True
                        Exit Sub
                    End If


                    If Convert.ToInt32(strNewVal) < 0 Then
                        MsgBox("Quantity cannot be Negative.")
                        e.Cancel = True
                        Exit Sub
                    End If


                    'Dim dtlqty As Integer = txtPrjQty.Text
                    'Dim currentqty As Integer = dgMShp.Item(dgMShp_tds_shpqty, dgMShp.CurrentCell.RowIndex).Value
                    'Dim sumqty As Integer = 0
                    'Dim newqty As Integer = strNewVal
                    'Dim i As Integer

                    'For i = 0 To dgMShp.Rows.Count - 1
                    '    sumqty = sumqty + dgMShp.Item(dgMShp_tds_shpqty, i).Value

                    'Next

                    'If (sumqty + newqty - currentqty) > dtlqty Then
                    '    MsgBox("Multiple Ship QTY must not over than Projected QTY!")
                    '    e.Cancel = True
                    'End If





            End Select
        End If
    End Sub

    Private Sub dgMltShp_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles dgMltShp.DataError
        Try
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub dgMltShp_EditingControlShowing(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgMltShp.EditingControlShowing

        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgMltShp.CurrentCell.ColumnIndex
            Case 5
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    AddHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress2
                    'AddHandler txtbox.TextChanged, AddressOf txt_dgSummary_TextChanged
                End If
            Case 9
                If TypeOf (e.Control) Is DataGridViewComboBoxEditingControl Then
                    Dim cboBox As ComboBox = CType(e.Control, ComboBox)
                    If Not cboBox Is Nothing Then
                        'RemoveHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                        'AddHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                    End If
                End If
                '            Case Else
            Case 16
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress2
                End If
        End Select


    End Sub

    Private Sub dgMltShp_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgMltShp.GotFocus
        Got_Focus_Grid = "MS"
    End Sub

    Private Sub cmdCanOrd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCanOrd.Click

        Select Case MsgBox("Are you sure to Cancel?", MsgBoxStyle.YesNoCancel)
            Case MsgBoxResult.Yes
            Case MsgBoxResult.No
                Exit Sub
        End Select


        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
            MsgBox("Order already approved , action fail.")
            Exit Sub
        End If

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_status") = "APV" Then
                MsgBox("Seq : " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") & " already approved , action fail.")
                Exit Sub
            End If

            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty") > 0 Then

                Dim dr() As DataRow
                dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm") & "'")

                If dr.Length = 0 Then

                ElseIf dr.Length <> 0 Then

                    Dim sumqty As Integer = 0

                    For x As Integer = 0 To dr.Length - 1
                        sumqty = sumqty + dr(x)("pih_avlqty")
                    Next

                    Dim pastqty As Integer
                    Dim pastrow() As DataRow

                    pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm") & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq"))
                    If pastrow.Length <> 0 Then
                        pastqty = pastrow(0)("pih_avlqty")
                    Else
                        pastqty = 0
                    End If

                    Dim currentqty As Integer = pastqty 'Convert.ToInt32(txtStkqty.Text)
                    '  Dim wasageqty As Integer = txtPkgWast.Text
                    ' Dim ordqty As Integer = txtPkgOrdQty.Text


                    If (sumqty - pastqty) < 0 Then

                        MsgBox("Seq : " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") & " Stock Qty already assigned to other Order , action fail.")
                        Exit Sub

                    End If

                End If
            End If

        Next


        gspStr = "sp_select_PKORDHDR_cancel '" & cbococde.Text & "','" & txtReqno.Text & "','" & gsUsrID & "'"

        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading cmdCanOrd_Click sp_select_PKORDHDR_cancel :" & rtnStr)
            Exit Sub
        End If

        MsgBox("Record Saved")
        recordstatus = False
        mmdClear_Click(sender, e)





    End Sub



    Private Sub dgGoodRec_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgGoodRec.CellDoubleClick
        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") <> "APV" Then
            Exit Sub
        End If


        If dgGoodRec.RowCount = 0 Then
            Exit Sub
        End If

        If e.ColumnIndex = -1 Or e.RowIndex = -1 Then
            Exit Sub
        End If

        If dgGoodRec.RowCount > 0 Then


            If dgGoodRec.CurrentCell.ColumnIndex = 0 Then
                Dim iCol As Integer = dgGoodRec.CurrentCell.ColumnIndex
                Dim iRow As Integer = dgGoodRec.CurrentCell.RowIndex
                Dim curvalue As String
                curvalue = dgGoodRec.CurrentCell.Value
                If Trim(curvalue) = "" Then

                    dgGoodRec.Item(0, iRow).Value = "Y"

                Else
                    dgGoodRec.Item(0, iRow).Value = ""
                End If


                'If dgMltShp.Item(dgMShp_tds_creusr, iRow).Value <> "~*ADD*~" Then
                '    dgMltShp.Item(dgMShp_tds_creusr, iRow).Value = "~*UPD*~"
                recordstatus = True
                'End If
            ElseIf dgGoodRec.CurrentCell.ColumnIndex = 6 Then

                'Dim iCol As Integer = dgGoodRec.CurrentCell.ColumnIndex
                'Dim iRow As Integer = dgGoodRec.CurrentCell.RowIndex
                'Dim curvalue As String
                'curvalue = dgGoodRec.CurrentCell.Value
                'If Trim(curvalue) = "Production" Then

                '    dgGoodRec.Item(6, iRow).Value = "Inventory"

                'Else
                '    dgGoodRec.Item(6, iRow).Value = "Production"
                'End If


                'If dgGoodRec.Item(13, iRow).Value <> "~*ADD*~" Then
                '    dgGoodRec.Item(13, iRow).Value = "~*UPD*~"
                'End If
                'recordstatus = True

            End If
        End If
    End Sub




    Private Sub txtBonQty_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtBonQty.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8 Or Asc(e.KeyChar) = 45 Or Asc(e.KeyChar) = 13) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If

        recordstatus = True
        flag_panpack_keypress = True
        SetAsUpdate(txtSeq.Text)
    End Sub
    Private Sub txtBonQty_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtBonQty.KeyDown
        If e.KeyValue = Keys.Delete Then

            recordstatus = True
            flag_panpack_keypress = True
            SetAsUpdate(txtSeq.Text)
        End If
    End Sub
    Private Sub txtBonQty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtBonQty.TextChanged
        If flag_panpack_keypress = True Then
            flag_panpack_keypress = False

            If txtBonQty.Text <> txtPkgWast.Text Then
                txtBonQty.ForeColor = Color.Red
            Else
                txtBonQty.ForeColor = Color.Black
            End If



            calTotalOrdQty()
            calTotalAMT()



        End If
    End Sub

    Private Sub txtDtlShpStr_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDtlShpStr.KeyPress
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtDtlShpStr_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtDtlShpStr.KeyUp
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub



    Private Sub txtDtlShpEnd_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDtlShpEnd.KeyPress
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtDtlShpEnd_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtDtlShpEnd.KeyUp
        recordstatus = True
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub cboDtlFty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboDtlFty.GotFocus
        'flag_cboDtlFty_GotFocus = True
    End Sub

    Private Sub cboDtlFty_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboDtlFty.KeyDown
        flag_cboDtlFty_GotFocus = True
    End Sub

    Private Sub cboDtlFty_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboDtlFty.KeyPress
        flag_cboDtlFty_GotFocus = True
    End Sub

    Private Sub cboDtlFty_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboDtlFty.KeyUp
        flag_cboDtlFty_GotFocus = True
        auto_search_combo(cboDtlFty, e.KeyCode)
    End Sub

    Private Sub cboDtlFty_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboDtlFty.LostFocus
        '  MouseClickCbo = False
    End Sub



    Private Sub cboDtlFty_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboDtlFty.SelectedIndexChanged



        If flag_cboDtlFty_GotFocus = True Then
            flag_cboDtlFty_GotFocus = False


            cboHdrAdd_dtl.Text = ""
            txtHdrSta_dtl.Text = ""
            txtHdrCty_dtl.Text = ""
            txtHdrzip_dtl.Text = ""
            txtHdrTel_dtl.Text = ""
            cboHdrCtn_dtl.Text = ""
            cboHdrAdd_dtl.Items.Clear()
            cboHdrCtn_dtl.Items.Clear()

            Dim dr() As DataRow
            If InStr(cboDtlFty.Text.Trim, "-") = 0 Then
                Exit Sub
            End If

            dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(cboDtlFty.Text.Trim, " - ")(1) & "'")
            If dr.Length <> 0 Then
                For j As Integer = 0 To dr.Length - 1
                    cboHdrAdd_dtl.Items.Add(dr(j)("vci_address").ToString)
                Next
                cboHdrAdd_dtl.Text = dr(0)("vci_address").ToString

                txtHdrSta_dtl.Text = dr(0)("vci_stt").ToString
                txtHdrCty_dtl.Text = dr(0)("vci_cty").ToString
                txtHdrzip_dtl.Text = dr(0)("vci_zip").ToString
                txtHdrTel_dtl.Text = dr(0)("vci_cntphn").ToString

                For j As Integer = 0 To dr.Length - 1
                    cboHdrCtn_dtl.Items.Add(dr(j)("vci_cntctp").ToString)
                Next
                cboHdrCtn_dtl.Text = dr(0)("vci_cntctp").ToString
            End If



            SetAsUpdate(txtSeq.Text)
            recordstatus = True
            update_PKREQDTL()
        End If

        cboDtlFty.Focus()

        '   cboHdrAdd_dtl.Focus()


    End Sub

    Private Sub cboDtlFty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboDtlFty.Validated
        '        flag_cboDtlFty_GotFocus = True

        If Trim(cboDtlFty.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboDtlFty, cboDtlFty.Text) = False Then
            MsgBox("Data Invalid")
            cboDtlFty.Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub cboHdrFty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrFty.GotFocus
        MouseClickCbo = True
    End Sub

    Private Sub cboHdrFty_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboHdrFty.KeyDown
        MouseClickCbo = True
    End Sub

    Private Sub cboHdrFty_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboHdrFty.KeyPress
        MouseClickCbo = True
    End Sub

    Private Sub cboHdrFty_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboHdrFty.KeyUp
        MouseClickCbo = True
        auto_search_combo(cboHdrFty, e.KeyCode)
    End Sub

    Private Sub cboHdrFty_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrFty.LostFocus
        MouseClickCbo = False
    End Sub



    Private Sub cboHdrFty_MouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles cboHdrFty.MouseClick
        MouseClickCbo = True
    End Sub




    Private Sub cboHdrFty_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrFty.SelectedIndexChanged


        If MouseClickCbo = True Then
            MouseClickCbo = False



            cboHdrAdd_fty.Text = ""
            txtHdrSta_fty.Text = ""
            txtHdrCty_fty.Text = ""
            txtHdrzip_fty.Text = ""
            txtHdrTel_fty.Text = ""
            cboHdrCtn_fty.Text = ""
            cboHdrAdd_fty.Items.Clear()
            cboHdrCtn_fty.Items.Clear()

            Dim dr() As DataRow
            If InStr(cboHdrFty.Text.Trim, "-") <= 0 Then
                If cboHdrFty.Text.Trim = "" Then
                    recordstatus = True
                    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
                End If

                Exit Sub
            End If
            dr = rs_VNBASINF_02.Tables("RESULT").Select("vbi_venno = '" & Split(cboHdrFty.Text.Trim, " - ")(1) & "'")
            If dr.Length <> 0 Then
                For j As Integer = 0 To dr.Length - 1
                    cboHdrAdd_fty.Items.Add(dr(j)("vci_address").ToString)
                Next
                cboHdrAdd_fty.Text = dr(0)("vci_address").ToString

                txtHdrSta_fty.Text = dr(0)("vci_stt").ToString
                txtHdrCty_fty.Text = dr(0)("vci_cty").ToString
                txtHdrzip_fty.Text = dr(0)("vci_zip").ToString
                txtHdrTel_fty.Text = dr(0)("vci_cntphn").ToString

                For j As Integer = 0 To dr.Length - 1
                    cboHdrCtn_fty.Items.Add(dr(j)("vci_cntctp").ToString)
                Next
                cboHdrCtn_fty.Text = dr(0)("vci_cntctp").ToString
            End If




            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If

        '   cboHdrAdd_fty.Focus()


    End Sub

    Private Sub cboHdrFty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrFty.Validated
        If Trim(cboHdrFty.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboHdrFty, cboHdrFty.Text) = False Then
            MsgBox("Data Invalid")
            cboHdrFty.Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub txtHdrShpStr_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrShpStr.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtHdrShpStr_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHdrShpStr.KeyUp
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub



    Private Sub txtHdrShpEnd_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrShpEnd.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtHdrShpEnd_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHdrShpEnd.KeyUp
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub



    Private Sub txtBonQty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBonQty.Validated

        If rdoOut.Checked = True Then
            If txtStkqty.Text <> 0 Then

                Dim ordqty As Integer = txtPkgOrdQty.Text
                Dim stkqty As Integer = txtStkqty.Text
                Dim bonqty As Integer = txtBonQty.Text


                Dim tmp_skqty As Integer = stkqty * -1

                If tmp_skqty > ordqty + bonqty Then
                    txtStkqty.Text = (ordqty + bonqty) * -1
                End If
                calTotalOrdQty()
                calTotalAMT()
            End If
        End If
        update_PKREQDTL()


        Dim ttlpri As Decimal

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA") <> 0 Then
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA"), 2)
            Else
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty"), 2)
            End If

        Next

        txtHdrTtlAmt.Text = ttlpri

        Dim HdrTtlam As Decimal
        Dim HdrDCAMT As Decimal

        HdrTtlam = txtHdrTtlAmt.Text
        If txtHdrDC.Text = "" Then
            HdrDCAMT = 0
        Else
            HdrDCAMT = txtHdrDC.Text
        End If

        txtHdrTA_F.Text = HdrTtlam + HdrDCAMT


        Dim hdrTA_F As Decimal
        hdrTA_F = txtHdrTA_F.Text

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)


                If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)

                If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        Dim total_Dis As Decimal = 0
        Dim total_Pre As Decimal = 0

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
            End If
        Next


        txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre



        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

    End Sub

    Private Sub txtBonQty_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtBonQty.Validating
        If txtBonQty.Text = "" Or txtBonQty.Text = "-" Then
            Exit Sub
        End If




        If IsNumeric(txtBonQty.Text) = False Then

            MsgBox("Please input valid integer")
            txtBonQty.Focus()
            e.Cancel = True
        End If
    End Sub

    Private Sub txtHdrShpStr_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrShpStr.TextChanged
        'txtHdrShpEnd.Text = txtHdrShpStr.Text
    End Sub

    Private Sub txtDtlShpStr_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDtlShpStr.TextChanged
        'txtDtlShpEnd.Text = txtDtlShpStr.Text
    End Sub

    Private Sub txtHdrShpStr_MaskInputRejected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MaskInputRejectedEventArgs) Handles txtHdrShpStr.MaskInputRejected

    End Sub

    Private Sub txtHdrShpStr_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtHdrShpStr.Validating
        If (IsDate(txtHdrShpStr.Text) = True And txtHdrShpStr.Text.Length = 10) Or txtHdrShpStr.Text = "  /  /" Then

            If Not txtHdrShpStr.Text = "  /  /" Then
                If Convert.ToDateTime(Now.Date) > Convert.ToDateTime(txtHdrShpStr.Text) Then
                    MsgBox("Ship Date cannot earlier than System Date")
                    BaseTabControl1.SelectedIndex = 0
                    txtHdrShpStr.Focus()
                    e.Cancel = True
                    Exit Sub
                End If


                If Convert.ToDateTime(txtIssDate.Text) > Convert.ToDateTime(txtHdrShpStr.Text) Then
                    MsgBox("Ship Date cannot earlier than PO Issue Date")
                    BaseTabControl1.SelectedIndex = 0
                    txtHdrShpStr.Focus()
                    e.Cancel = True
                    Exit Sub
                End If

            End If









            'If Not txtHdrShpStr.Text = "  /  /" Then
            '    If IsDate(txtHdrShpEnd.Text) = True And txtHdrShpEnd.Text.Length = 10 Then
            '        If Convert.ToDateTime(txtHdrShpEnd.Text) < Convert.ToDateTime(txtHdrShpStr.Text) Then
            '            MsgBox("Ship Start Date must be earlier than Ship End Date!")
            '            BaseTabControl1.SelectedIndex = 0
            '            txtHdrShpStr.Focus()
            '            Exit Sub
            '        End If
            '    End If
            'End If


        Else
            MsgBox("Please Input valid Date format [MM/dd/yyyy]!")
            BaseTabControl1.SelectedIndex = 0
            txtHdrShpStr.Focus()
            e.Cancel = True
            Exit Sub
        End If
    End Sub

    Private Sub txtHdrShpEnd_Validating(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtHdrShpEnd.Validating
        'If (IsDate(txtHdrShpEnd.Text) = True And txtHdrShpEnd.Text.Length = 10) Or txtHdrShpEnd.Text = "  /  /" Then

        '    If Not txtHdrShpEnd.Text = "  /  /" Then
        '        If Convert.ToDateTime(Now.Date) > Convert.ToDateTime(txtHdrShpEnd.Text) Then
        '            MsgBox("Ship Date cannot earlier than System Date")
        '            BaseTabControl1.SelectedIndex = 0
        '            txtHdrShpEnd.Focus()
        '            Exit Sub
        '        End If

        '    End If


        '    If Not txtHdrShpEnd.Text = "  /  /" Then
        '        If IsDate(txtHdrShpStr.Text) = True And txtHdrShpStr.Text.Length = 10 Then
        '            If Convert.ToDateTime(txtHdrShpEnd.Text) < Convert.ToDateTime(txtHdrShpStr.Text) Then
        '                MsgBox("Ship End Date must be later than Ship Str Date!")
        '                BaseTabControl1.SelectedIndex = 0
        '                txtHdrShpEnd.Focus()
        '                Exit Sub
        '            End If
        '        End If
        '    End If


        'Else
        '    MsgBox("Please Input valid Date format [MM/dd/yyyy]!")
        '    BaseTabControl1.SelectedIndex = 0
        '    txtHdrShpEnd.Focus()
        'End If
    End Sub




    Private Sub txtDtlShpStr_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtDtlShpStr.Validating
        If (IsDate(txtDtlShpStr.Text) = True And txtDtlShpStr.Text.Length = 10) Or txtDtlShpStr.Text = "  /  /" Then

            If Not txtDtlShpStr.Text = "  /  /" Then
                If Convert.ToDateTime(Now.Date) > Convert.ToDateTime(txtDtlShpStr.Text) Then
                    MsgBox("Ship Date cannot earlier than System Date")
                    BaseTabControl1.SelectedIndex = 1
                    txtDtlShpStr.Focus()
                    Exit Sub
                End If

                If Convert.ToDateTime(txtIssDate.Text) > Convert.ToDateTime(txtDtlShpStr.Text) Then
                    MsgBox("Ship Date cannot earlier than PO Issue Date")
                    BaseTabControl1.SelectedIndex = 1
                    txtDtlShpStr.Focus()
                    Exit Sub
                End If


            End If


            'If Not txtDtlShpStr.Text = "  /  /" Then
            '    If IsDate(txtDtlShpEnd.Text) = True And txtDtlShpEnd.Text.Length = 10 Then
            '        If Convert.ToDateTime(txtDtlShpEnd.Text) < Convert.ToDateTime(txtDtlShpStr.Text) Then
            '            MsgBox("Ship Start Date must be earlier than Ship End Date!")
            '            BaseTabControl1.SelectedIndex = 1
            '            txtDtlShpStr.Focus()
            '            Exit Sub
            '        End If
            '    End If
            'End If


        Else
            MsgBox("Please Input valid Date format [MM/dd/yyyy]!")
            BaseTabControl1.SelectedIndex = 1
            txtDtlShpStr.Focus()
        End If
    End Sub

    Private Sub txtDtlShpEnd_Validating(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtDtlShpEnd.Validating
        'If (IsDate(txtDtlShpEnd.Text) = True And txtDtlShpEnd.Text.Length = 10) Or txtDtlShpEnd.Text = "  /  /" Then

        '    If Not txtDtlShpEnd.Text = "  /  /" Then
        '        If Convert.ToDateTime(Now.Date) > Convert.ToDateTime(txtDtlShpEnd.Text) Then
        '            MsgBox("Ship Date cannot earlier than System Date")
        '            BaseTabControl1.SelectedIndex = 1
        '            txtDtlShpEnd.Focus()
        '            Exit Sub
        '        End If

        '    End If


        '    If Not txtDtlShpEnd.Text = "  /  /" Then
        '        If IsDate(txtDtlShpStr.Text) = True And txtDtlShpStr.Text.Length = 10 Then
        '            If Convert.ToDateTime(txtDtlShpEnd.Text) < Convert.ToDateTime(txtDtlShpStr.Text) Then
        '                MsgBox("Ship End Date must be later than Ship Str Date!")
        '                BaseTabControl1.SelectedIndex = 1
        '                txtDtlShpEnd.Focus()
        '                Exit Sub
        '            End If
        '        End If
        '    End If


        'Else
        '    MsgBox("Please Input valid Date format [MM/dd/yyyy]!")
        '    BaseTabControl1.SelectedIndex = 1
        '    txtDtlShpEnd.Focus()
        'End If
    End Sub





    Private Sub txtDtlShpStr_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDtlShpStr.Validated
        update_PKREQDTL()
    End Sub



    Private Sub txtDtlShpEnd_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDtlShpEnd.Validated
        update_PKREQDTL()
    End Sub

    Private Sub txtConRemark_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtConRemark.Validated
        update_PKREQDTL()
    End Sub



    Private Sub txtHdrShpStr_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrShpStr.Validated

        'If txtHdrShpStr.Text = "  /  /" Then
        '    Exit Sub
        'End If
        'For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
        '    If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_shpstr") = "1900-01-01" Then
        '        rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_shpstr") = txtHdrShpStr.Text
        '        rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_creusr") = "~*UPD*~"
        '    End If

        'Next
    End Sub



    Private Sub cmdShowReqdtl_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdShowReqdtl.Click


        display_dgReqdtl(txtSeq.Text)
        PelReqdtl.BringToFront()
        PelReqdtl.Visible = True
        PelReqdtl.Top = 280
        PelReqdtl.Left = 496
        PelReqdtl.Width = 434
        PelReqdtl.Height = 218
    End Sub

    Private Sub cmdCloseRequest_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCloseRequest.Click
        PelReqdtl.Visible = False
    End Sub



    Private Sub display_dgReqdtl(ByVal seq As Integer)
        If rs_Pkreqdtl.Tables.Count = 0 Then
            Exit Sub
        End If

        If rs_Pkreqdtl.Tables("RESULT").Rows.Count > 0 Then
            Dim sFilter As String
            sFilter = "prd_ordseq = " & seq
            rs_Pkreqdtl.Tables("RESULT").DefaultView.RowFilter = sFilter
            'dgMShp.DataSource = rs_TODTLSHP.Tables("RESULT").DefaultView
        End If



        dgRequest.DataSource = rs_Pkreqdtl.Tables("RESULT").DefaultView

        dgRequest.RowHeadersWidth = 18
        dgRequest.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgRequest.ColumnHeadersHeight = 18
        dgRequest.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgRequest.AllowUserToResizeColumns = True
        dgRequest.AllowUserToResizeRows = False
        dgRequest.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_Pkreqdtl.Tables("RESULT").Columns.Count - 1
            rs_Pkreqdtl.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgRequest.Columns.Count - 1

            Select Case i



                Case 0
                    dgRequest.Columns(i).HeaderText = "Request No"
                    dgRequest.Columns(i).Width = 100
                    dgRequest.Columns(i).Visible = True
                    dgRequest.Columns(i).ReadOnly = True
                Case 1

                    dgRequest.Columns(i).HeaderText = "Request Seq"
                    dgRequest.Columns(i).Width = 100
                    dgRequest.Columns(i).Visible = True
                    dgRequest.Columns(i).ReadOnly = True
                Case 2

                    dgRequest.Columns(i).Visible = False
                Case 3
                    dgRequest.Columns(i).Visible = False



                Case Else
                    dgRequest.Columns(i).Visible = False
            End Select



        Next

    End Sub

    Private Sub txtHdrAdd_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrAdd.KeyPress
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub

    Private Sub txtHdrAdd_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHdrAdd.KeyUp
        recordstatus = True
        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
    End Sub


    Private Sub txtHdrAdd_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrAdd.TextChanged

    End Sub

    Private Sub cmdAttach_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdAttach.Click
        Dim frmAttach As New frmAttchUpload
        frmAttach.setModule("PKG")
        frmAttach.setDoc(cbococde.Text, Trim(txtReqno.Text))
        frmAttach.ShowDialog()
        frmAttach = Nothing


    End Sub

    Private Sub cmdInvDetail_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdInvDetail.Click

        display_dgInvDtl(txtPkgItem.Text)
        PelInvDtl.BringToFront()
        PelInvDtl.Visible = True
        PelInvDtl.Top = 37
        PelInvDtl.Left = 215
        PelInvDtl.Width = 434
        PelInvDtl.Height = 218
    End Sub

    Private Sub cmdCloseInvDtl_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdCloseInvDtl.Click
        PelInvDtl.Visible = False
    End Sub


    Private Sub display_dgInvDtl(ByVal ItemName As String)
        If rs_PKINVHDR.Tables.Count = 0 Then
            Exit Sub
        End If

        If rs_PKINVHDR.Tables("RESULT").Rows.Count > 0 Then
            Dim sFilter As String
            sFilter = "pih_pkgitm = '" & ItemName & "'"
            rs_PKINVHDR.Tables("RESULT").DefaultView.RowFilter = sFilter

            'dgMShp.DataSource = rs_TODTLSHP.Tables("RESULT").DefaultView
        End If



        dgInvDtl.DataSource = rs_PKINVHDR.Tables("RESULT").DefaultView

        dgInvDtl.RowHeadersWidth = 18
        dgInvDtl.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgInvDtl.ColumnHeadersHeight = 18
        dgInvDtl.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgInvDtl.AllowUserToResizeColumns = True
        dgInvDtl.AllowUserToResizeRows = False
        dgInvDtl.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_PKINVHDR.Tables("RESULT").Columns.Count - 1
            rs_PKINVHDR.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgInvDtl.Columns.Count - 1

            Select Case i



                Case 0
                    dgInvDtl.Columns(i).HeaderText = "Order No"
                    dgInvDtl.Columns(i).Width = 80
                    dgInvDtl.Columns(i).Visible = True
                    dgInvDtl.Columns(i).ReadOnly = True

                Case 1

                    dgInvDtl.Columns(i).HeaderText = "Seq"
                    dgInvDtl.Columns(i).Width = 50
                    dgInvDtl.Columns(i).Visible = True
                    dgInvDtl.Columns(i).ReadOnly = True
                Case 2
                    dgInvDtl.Columns(i).HeaderText = "Stock Qty"
                    dgInvDtl.Columns(i).Width = 70
                    dgInvDtl.Columns(i).Visible = True
                    dgInvDtl.Columns(i).ReadOnly = True

                Case 3
                    dgInvDtl.Columns(i).HeaderText = "Packaging Item"
                    dgInvDtl.Columns(i).Width = 100
                    dgInvDtl.Columns(i).Visible = True
                    dgInvDtl.Columns(i).ReadOnly = True

                Case Else
                    dgInvDtl.Columns(i).Visible = False
            End Select






        Next

    End Sub

    Private Sub cboHdrAdd_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrAdd.GotFocus
        MouseClickCbo = True
    End Sub

    Private Sub cboHdrAdd_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboHdrAdd.KeyUp
        auto_search_combo(cboHdrAdd, e.KeyCode)
    End Sub

    Private Sub cboHdrAdd_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrAdd.LostFocus
        MouseClickCbo = False
    End Sub



    Private Sub cboHdrAdd_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrAdd.SelectedIndexChanged

        If MouseClickCbo = True Then
            MouseClickCbo = False


            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If
    End Sub

    Private Sub cboHdrAdd_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrAdd.Validated
        If Trim(cboHdrAdd.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboHdrAdd, cboHdrAdd.Text) = False Then
            MsgBox("Data Invalid")
            cboHdrAdd.Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub dgGoodRec_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgGoodRec.CellContentClick

    End Sub

    Private Sub TabPage2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TabPage2.Click

    End Sub

    Private Sub cboHdrCtn_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn.GotFocus
        MouseClickCbo = True
    End Sub

    Private Sub cboHdrCtn_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboHdrCtn.KeyUp
        auto_search_combo(cboHdrCtn, e.KeyCode)
    End Sub

    Private Sub cboHdrCtn_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn.LostFocus
        MouseClickCbo = False
    End Sub

    Private Sub cboHdrCtn_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrCtn.SelectedIndexChanged
        If MouseClickCbo = True Then
            MouseClickCbo = False


            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"





        End If


        Dim dr_tel() As DataRow

        dr_tel = rs_VNCTNPER.Tables("RESULT").Select("vci_cntctp = '" & cboHdrCtn.Text & "'")

        If dr_tel.Length <> 0 Then
            txtHdrTel.Text = dr_tel(0)("vci_cntphn")
        Else
            txtHdrTel.Text = ""
        End If



    End Sub

    Private Sub cboHdrCtn_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn.Validated
        If Trim(cboHdrCtn.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboHdrCtn, cboHdrCtn.Text) = False Then
            MsgBox("Data Invalid")
            cboHdrCtn.Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub rdoOut_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdoOut.CheckedChanged

    End Sub

    Private Sub txtHdrDC_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtHdrDC.KeyDown
        If e.KeyValue = Keys.Delete Then
            recordstatus = True
            flag_panpack_keypress = True
        End If
    End Sub

    Private Sub txtHdrDC_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrDC.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8 Or Asc(e.KeyChar) = 45 Or Asc(e.KeyChar) = 13 Or Asc(e.KeyChar) = 46) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If

        If txtHdrDC.Text.Contains(".") = True Then
            If Asc(e.KeyChar) = 46 Then
                e.KeyChar = Chr(0)
                MsgBox("Please input integer value.")
            End If
        End If


        recordstatus = True
        flag_panpack_keypress = True

    End Sub

    Private Sub txtHdrDC_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrDC.TextChanged
        If flag_panpack_keypress = True Then
            flag_panpack_keypress = False

            If txtHdrDC.Text = "" Then
                txtHdrDC.Text = 0
            End If

            If IsNumeric(txtHdrDC.Text) = False Then
                Exit Sub
            End If


            Dim Hdrttlamt As Decimal = txtHdrTtlAmt.Text
            Dim Dcamt As Decimal

            If txtHdrDC.Text = "" Then
                Dcamt = 0
            Else
                Dcamt = txtHdrDC.Text
            End If

            txtHdrTA_F.Text = round(Hdrttlamt + Dcamt, 2)

            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

            Dim hdrTA_F As Decimal
            hdrTA_F = txtHdrTA_F.Text

            '----Re asign Dis and Pre Amount
            For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                    round(rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)

                    If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
                        rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
                        rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                        rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                    End If
                End If
            Next

            For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                    rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                    round(rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)


                    If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
                        rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
                        rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                        rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                    End If

                End If
            Next

            Dim total_Dis As Decimal = 0
            Dim total_Pre As Decimal = 0

            For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                    total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                End If
            Next

            For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                    total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                End If
            Next


            txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre

        End If
    End Sub

    Private Sub txtHdrDC_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrDC.Validated
        If txtHdrDC.Text = "" Then
            txtHdrDC.Text = 0
        End If
    End Sub

    Private Sub txtHdrDC_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtHdrDC.Validating

        If txtHdrDC.Text = "" Then
            txtHdrDC.Text = 0
        End If


        If IsNumeric(txtHdrDC.Text) = False Then

            MsgBox("Please input valid integer")
            txtHdrDC.Focus()
            e.Cancel = True
        End If




        If txtHdrDC.Text.Contains("..") Then
            MsgBox("Please input valid integer")

            txtHdrDC.Focus()
            e.Cancel = True
            Exit Sub
        End If


    End Sub

    Private Sub cbococde_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbococde.SelectedIndexChanged
        gsCompany = Trim(cbococde.Text)
        Update_gs_Value(gsCompany)
    End Sub

    Private Sub dgDis_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgDis.CellClick
        If mode = "ReadOnly" Then
            Exit Sub
        End If '

        If dgDis.RowCount = 0 Then
            Exit Sub
        End If

        If e.RowIndex = -1 Or e.ColumnIndex = -1 Then
            Exit Sub
        End If

        If dgDis.RowCount > 0 Then
            If dgDis.CurrentCell.ColumnIndex = 5 Then

                recordstatus = True

                If dgDis.Item(e.ColumnIndex, e.RowIndex).Value.ToString <> "" And Not dgDis.Item(e.ColumnIndex, e.RowIndex).Value.ToString.Contains(" - ") Then
                    dgDis.Item(e.ColumnIndex, e.RowIndex).Value = _
                    dgDis.Item(5, e.RowIndex).Value + " - " + dgDis.Item(6, e.RowIndex).Value
                End If

                comboBoxCell(dgDis, "DIS")

            ElseIf dgDis.CurrentCell.ColumnIndex = 0 Then

                recordstatus = True

                If dgDis.Item("DEL", e.RowIndex).Value.ToString = "" Then
                    If dgDis.Item("pdp_creusr", e.RowIndex).Value.ToString <> "~*ADD*~" Then
                        dgDis.Item("pdp_creusr", e.RowIndex).Value = "~*DEL*~"
                        dgDis.Item("DEL", e.RowIndex).Value = "Y"
                    ElseIf dgDis.Item("pdp_creusr", e.RowIndex).Value.ToString = "~*ADD*~" Then
                        dgDis.Item("pdp_creusr", e.RowIndex).Value = "~*NEW*~"
                        dgDis.Item("DEL", e.RowIndex).Value = "Y"
                    End If
                Else
                    If dgDis.Item("pdp_creusr", e.RowIndex).Value.ToString = "~*NEW*~" Then
                        dgDis.Item("pdp_creusr", e.RowIndex).Value = "~*ADD*~"
                        dgDis.Item("DEL", e.RowIndex).Value = ""
                    Else
                        dgDis.Item("pdp_creusr", e.RowIndex).Value = "~*UPD*~"
                        dgDis.Item("DEL", e.RowIndex).Value = ""
                    End If
                End If

                Dim hdrTA_F As Decimal
                hdrTA_F = txtHdrTA_F.Text
                Dim total_Dis As Decimal = 0
                Dim total_Pre As Decimal = 0

                For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                    End If
                Next

                For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                    End If
                Next


                txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

            ElseIf dgDis.CurrentCell.ColumnIndex = 7 Then

                recordstatus = True

                If dgDis.Item("pdp_pctamt", e.RowIndex).Value.ToString = "Percentage" Then
                    dgDis.Item("pdp_pctamt", e.RowIndex).Value = "Amount"
                    dgDis.Item("pdp_pct", e.RowIndex).Value = 0
                    dgDis.Item("pdp_amt", e.RowIndex).Value = 0
                    dgDis.Refresh()
                Else
                    dgDis.Item("pdp_pctamt", e.RowIndex).Value = "Percentage"
                    dgDis.Item("pdp_pct", e.RowIndex).Value = 0
                    dgDis.Item("pdp_amt", e.RowIndex).Value = 0
                    dgDis.Refresh()
                End If


                rs_PKDISPRM_D.Tables("RESULT").AcceptChanges()

                Dim hdrTA_F As Decimal
                hdrTA_F = txtHdrTA_F.Text
                Dim total_Dis As Decimal = 0
                Dim total_Pre As Decimal = 0

                For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                    End If
                Next

                For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                    End If
                Next


                txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"




            End If

        End If







    End Sub

    Private Sub dgDis_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgDis.CellContentClick

    End Sub

    Private Sub dgDis_CellEndEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgDis.CellEndEdit
        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgDis.CurrentCell.ColumnIndex

                Case 5
                    'dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value = Split(dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value, " - ")(0)
                    dgDis.Item(5, dgDis.CurrentCell.RowIndex) = txtCell

                    Dim ori_value = dgDis.Item(5, dgDis.CurrentCell.RowIndex).Value

                    'If ori_value.ToString = "" Then
                    '    dgDis.Item(6, dgDis.CurrentCell.RowIndex).Value = ""
                    'Else
                    '    dgDis.Item(5, dgDis.CurrentCell.RowIndex).Value = _
                    '                     Split(ori_value, " - ")(0)

                    '    dgDis.Item(6, dgDis.CurrentCell.RowIndex).Value = _
                    '   Split(ori_value, " - ")(1)

                    'End If


                Case 8

                    Dim value As Decimal
                    Dim ttotal As Decimal

                    ttotal = txtHdrTA_F.Text

                    value = dgDis.Item(8, dgDis.CurrentCell.RowIndex).Value

                    dgDis.Item(9, dgDis.CurrentCell.RowIndex).Value = round(ttotal * value / 100, 2)

                    dgDis.Refresh()
                    rs_PKDISPRM_D.Tables("RESULT").AcceptChanges()

                    Dim hdrTA_F As Decimal
                    hdrTA_F = txtHdrTA_F.Text

                    Dim total_Dis As Decimal = 0
                    Dim total_Pre As Decimal = 0

                    For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                        End If
                    Next

                    For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                        End If
                    Next


                    txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

                Case 9

                    dgDis.Refresh()
                    rs_PKDISPRM_D.Tables("RESULT").AcceptChanges()


                    Dim hdrTA_F As Decimal
                    hdrTA_F = txtHdrTA_F.Text

                    Dim total_Dis As Decimal = 0
                    Dim total_Pre As Decimal = 0

                    For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                        End If
                    Next

                    For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                        End If
                    Next


                    txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"



            End Select
        Catch
        End Try



        If dgDis.Item(10, e.RowIndex).Value <> "~*ADD*~" And _
        dgDis.Item(10, e.RowIndex).Value <> "~*NEW*~" And _
        dgDis.Item(10, e.RowIndex).Value <> "~*DEL*~" Then
            dgDis.Item(10, e.RowIndex).Value = "~*UPD*~"

        End If


        recordstatus = True
    End Sub

    Private Sub dgDis_CellEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgDis.CellEnter
        If mode = "ReadOnly" Then
            Exit Sub
        End If


        If e.ColumnIndex = 8 Or e.ColumnIndex = 9 Then
            If dgDis.Rows(e.RowIndex).Cells(7).Value = "Percentage" Then
                If dgDis.Columns(8).ReadOnly <> False And dgDis.Columns(9).ReadOnly <> True Then
                    dgDis.Columns(8).ReadOnly = False
                    dgDis.Columns(9).ReadOnly = True
                End If
            Else
                If dgDis.Columns(8).ReadOnly <> True Then
                    dgDis.Columns(8).ReadOnly = True
                    dgDis.Columns(9).ReadOnly = False
                End If
            End If
        End If

    End Sub

    Private Sub dgDis_CellValidated(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgDis.CellValidated
        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgDis.CurrentCell.ColumnIndex

                Case 5

                    dgDis.Item(5, dgDis.CurrentCell.RowIndex) = txtCell

                    Dim ori_value = dgDis.Item(5, dgDis.CurrentCell.RowIndex).Value

                    If ori_value.ToString = "" Then
                        dgDis.Item(6, dgDis.CurrentCell.RowIndex).Value = ""
                    Else
                        dgDis.Item(5, dgDis.CurrentCell.RowIndex).Value = _
                                         Split(ori_value, " - ")(0)

                        dgDis.Item(6, dgDis.CurrentCell.RowIndex).Value = _
                       Split(ori_value, " - ")(1)

                    End If






            End Select
        Catch
        End Try
    End Sub

    Private Sub dgDis_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles dgDis.CellValidating
        Dim row As DataGridViewRow = dgDis.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then
            Select Case e.ColumnIndex

                Case 8
                    If Not IsNumeric(strNewVal) Then
                        MsgBox("Please input integer value!")
                        e.Cancel = True
                        Exit Sub
                    End If

                Case 9

                    If Not IsNumeric(strNewVal) Then
                        MsgBox("Please input integer value!")
                        e.Cancel = True
                        Exit Sub
                    End If




            End Select
        End If
    End Sub

    Private Sub dgDis_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles dgDis.DataError

    End Sub

    Private Sub dgDis_EditingControlShowing(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgDis.EditingControlShowing
        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgDis.CurrentCell.ColumnIndex

            Case 5
                If TypeOf (e.Control) Is DataGridViewComboBoxEditingControl Then
                    Dim cboBox As ComboBox = CType(e.Control, ComboBox)
                    If Not cboBox Is Nothing Then
                        'RemoveHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                        'AddHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                    End If
                End If
            Case Else
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress2
                End If
        End Select



    End Sub

    Private Sub dgDis_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgDis.GotFocus
        Got_Focus_Grid = "DIS"
    End Sub

    Private Sub dgPre_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgPre.CellClick
        If mode = "ReadOnly" Then
            Exit Sub
        End If '

        If dgPre.RowCount = 0 Then
            Exit Sub
        End If

        If e.RowIndex = -1 Or e.ColumnIndex = -1 Then
            Exit Sub
        End If

        If dgPre.RowCount > 0 Then
            If dgPre.CurrentCell.ColumnIndex = 5 Then

                recordstatus = True

                If dgPre.Item(e.ColumnIndex, e.RowIndex).Value.ToString <> "" And Not dgPre.Item(e.ColumnIndex, e.RowIndex).Value.ToString.Contains(" - ") Then
                    dgPre.Item(e.ColumnIndex, e.RowIndex).Value = _
                    dgPre.Item(5, e.RowIndex).Value + " - " + dgPre.Item(6, e.RowIndex).Value
                End If

                comboBoxCell(dgPre, "PRE")

            ElseIf dgPre.CurrentCell.ColumnIndex = 0 Then

                recordstatus = True

                If dgPre.Item("DEL", e.RowIndex).Value.ToString = "" Then
                    If dgPre.Item("pdp_creusr", e.RowIndex).Value.ToString <> "~*ADD*~" Then
                        dgPre.Item("pdp_creusr", e.RowIndex).Value = "~*DEL*~"
                        dgPre.Item("DEL", e.RowIndex).Value = "Y"
                    ElseIf dgPre.Item("pdp_creusr", e.RowIndex).Value.ToString = "~*ADD*~" Then
                        dgPre.Item("pdp_creusr", e.RowIndex).Value = "~*NEW*~"
                        dgPre.Item("DEL", e.RowIndex).Value = "Y"
                    End If
                Else
                    If dgPre.Item("pdp_creusr", e.RowIndex).Value.ToString = "~*NEW*~" Then
                        dgPre.Item("pdp_creusr", e.RowIndex).Value = "~*ADD*~"
                        dgPre.Item("DEL", e.RowIndex).Value = ""
                    Else
                        dgPre.Item("pdp_creusr", e.RowIndex).Value = "~*UPD*~"
                        dgPre.Item("DEL", e.RowIndex).Value = ""
                    End If
                End If

                Dim hdrTA_F As Decimal
                hdrTA_F = txtHdrTA_F.Text
                Dim total_Dis As Decimal = 0
                Dim total_Pre As Decimal = 0

                For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                    End If
                Next

                For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                    End If
                Next


                txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"


            ElseIf dgPre.CurrentCell.ColumnIndex = 7 Then

                recordstatus = True

                If dgPre.Item("pdp_pctamt", e.RowIndex).Value.ToString = "Percentage" Then
                    dgPre.Item("pdp_pctamt", e.RowIndex).Value = "Amount"
                    dgPre.Item("pdp_pct", e.RowIndex).Value = 0
                    dgPre.Item("pdp_amt", e.RowIndex).Value = 0
                    dgPre.Refresh()
                Else
                    dgPre.Item("pdp_pctamt", e.RowIndex).Value = "Percentage"
                    dgPre.Item("pdp_pct", e.RowIndex).Value = 0
                    dgPre.Item("pdp_amt", e.RowIndex).Value = 0
                    dgPre.Refresh()
                End If


                rs_PKDISPRM_P.Tables("RESULT").AcceptChanges()

                Dim hdrTA_F As Decimal
                hdrTA_F = txtHdrTA_F.Text
                Dim total_Dis As Decimal = 0
                Dim total_Pre As Decimal = 0

                For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                    End If
                Next

                For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                    If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                        total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                    End If
                Next


                txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
            End If

        End If

    End Sub

    Private Sub dgPre_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgPre.CellContentClick

    End Sub

    Private Sub dgPre_CellEndEdit(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgPre.CellEndEdit
        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgPre.CurrentCell.ColumnIndex

                Case 5
                    'dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value = Split(dgTODtl.Item(dgTODtl_tod_dsgven, dgTODtl.CurrentCell.RowIndex).Value, " - ")(0)
                    dgPre.Item(5, dgPre.CurrentCell.RowIndex) = txtCell

                    Dim ori_value = dgPre.Item(5, dgPre.CurrentCell.RowIndex).Value

                    'If ori_value.ToString = "" Then
                    '    dgPre.Item(6, dgPre.CurrentCell.RowIndex).Value = ""
                    'Else
                    '    dgPre.Item(5, dgPre.CurrentCell.RowIndex).Value = _
                    '                     Split(ori_value, " - ")(0)

                    '    dgPre.Item(6, dgPre.CurrentCell.RowIndex).Value = _
                    '   Split(ori_value, " - ")(1)

                    'End If


                Case 8

                    Dim value As Decimal
                    Dim ttotal As Decimal

                    ttotal = txtHdrTA_F.Text

                    value = dgPre.Item(8, dgPre.CurrentCell.RowIndex).Value

                    dgPre.Item(9, dgPre.CurrentCell.RowIndex).Value = round(ttotal * value / 100, 2)

                    dgPre.Refresh()
                    rs_PKDISPRM_P.Tables("RESULT").AcceptChanges()

                    Dim hdrTA_F As Decimal
                    hdrTA_F = txtHdrTA_F.Text

                    Dim total_Dis As Decimal = 0
                    Dim total_Pre As Decimal = 0

                    For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                        End If
                    Next

                    For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                        End If
                    Next


                    txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"


                Case 9


                    dgPre.Refresh()
                    rs_PKDISPRM_P.Tables("RESULT").AcceptChanges()

                    Dim hdrTA_F As Decimal
                    hdrTA_F = txtHdrTA_F.Text

                    Dim total_Dis As Decimal = 0
                    Dim total_Pre As Decimal = 0

                    For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
                        End If
                    Next

                    For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
                        If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                            total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
                        End If
                    Next


                    txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre
                    rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"


            End Select
        Catch
        End Try



        If dgPre.Item(10, e.RowIndex).Value <> "~*ADD*~" And _
        dgPre.Item(10, e.RowIndex).Value <> "~*NEW*~" And _
        dgPre.Item(10, e.RowIndex).Value <> "~*DEL*~" Then
            dgPre.Item(10, e.RowIndex).Value = "~*UPD*~"

        End If


        recordstatus = True
    End Sub

    Private Sub dgPre_CellEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgPre.CellEnter

        If mode = "ReadOnly" Then
            Exit Sub
        End If


        If e.ColumnIndex = 8 Or e.ColumnIndex = 9 Then
            If dgPre.Rows(e.RowIndex).Cells(7).Value = "Percentage" Then
                If dgPre.Columns(8).ReadOnly <> False And dgPre.Columns(9).ReadOnly <> True Then
                    dgPre.Columns(8).ReadOnly = False
                    dgPre.Columns(9).ReadOnly = True
                End If
            Else
                If dgPre.Columns(8).ReadOnly <> True Then
                    dgPre.Columns(8).ReadOnly = True
                    dgPre.Columns(9).ReadOnly = False
                End If
            End If
        End If



    End Sub

    Private Sub dgPre_CellValidated(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgPre.CellValidated
        Try
            Dim txtCell As New DataGridViewTextBoxCell
            Select Case dgPre.CurrentCell.ColumnIndex

                Case 5

                    dgPre.Item(5, dgPre.CurrentCell.RowIndex) = txtCell

                    Dim ori_value = dgPre.Item(5, dgPre.CurrentCell.RowIndex).Value

                    If ori_value.ToString = "" Then
                        dgPre.Item(6, dgPre.CurrentCell.RowIndex).Value = ""
                    Else
                        dgPre.Item(5, dgPre.CurrentCell.RowIndex).Value = _
                                         Split(ori_value, " - ")(0)

                        dgPre.Item(6, dgPre.CurrentCell.RowIndex).Value = _
                       Split(ori_value, " - ")(1)

                    End If






            End Select
        Catch
        End Try
    End Sub

    Private Sub dgPre_DataError(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewDataErrorEventArgs) Handles dgPre.DataError

    End Sub

    Private Sub dgPre_EditingControlShowing(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles dgPre.EditingControlShowing
        If sender.Focused = False Then
            Exit Sub
        End If

        Select Case dgPre.CurrentCell.ColumnIndex

            Case 5
                If TypeOf (e.Control) Is DataGridViewComboBoxEditingControl Then
                    Dim cboBox As ComboBox = CType(e.Control, ComboBox)
                    If Not cboBox Is Nothing Then
                        'RemoveHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                        'AddHandler cboBox.SelectedIndexChanged, AddressOf cbopckunt_dgPacking_SelectedIndexChanged
                    End If
                End If
            Case Else
                Dim txtbox As TextBox = CType(e.Control, TextBox)
                If Not (txtbox Is Nothing) Then
                    RemoveHandler txtbox.KeyPress, AddressOf txt_datagridDates_KeyPress2
                End If
        End Select

    End Sub

    Private Sub dgPre_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgPre.GotFocus
        Got_Focus_Grid = "PRE"
    End Sub

    Private Sub display_dgDis()
        If rs_PKDISPRM_D.Tables.Count = 0 Then
            Exit Sub
        End If




        dgDis.DataSource = rs_PKDISPRM_D.Tables("RESULT").DefaultView

        dgDis.RowHeadersWidth = 18
        dgDis.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgDis.ColumnHeadersHeight = 18
        dgDis.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgDis.AllowUserToResizeColumns = True
        dgDis.AllowUserToResizeRows = False
        dgDis.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_PKDISPRM_D.Tables("RESULT").Columns.Count - 1
            rs_PKDISPRM_D.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgDis.Columns.Count - 1

            Select Case i


                Case 0
                    dgDis.Columns(i).HeaderText = "Del"
                    dgDis.Columns(i).Width = 40
                    dgDis.Columns(i).ReadOnly = True
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 5
                    dgDis.Columns(i).HeaderText = "Code"
                    dgDis.Columns(i).Width = 80
                    dgDis.Columns(i).ReadOnly = True
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 6
                    dgDis.Columns(i).HeaderText = "Description"
                    dgDis.Columns(i).Width = 220
                    'rs_SCDISPRM_D.Tables("RESULT").Columns(6).ReadOnly = False
                    If mode <> "ReadOnly" Then
                        dgDis.Columns(i).ReadOnly = False
                    End If
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 7
                    dgDis.Columns(i).HeaderText = "Percentage/Amount"
                    dgDis.Columns(i).Width = 120
                    dgDis.Columns(i).ReadOnly = True
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 8
                    dgDis.Columns(i).HeaderText = "%"
                    dgDis.Columns(i).Width = 60
                    'dgDis.Columns(i).ReadOnly = False

                    If mode <> "ReadOnly" Then
                        dgDis.Columns(i).ReadOnly = False
                    End If

                    dgDis.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 9
                    dgDis.Columns(i).HeaderText = "Amount"
                    dgDis.Columns(i).Width = 90
                    ' dgDis.Columns(i).ReadOnly = False
                    If mode <> "ReadOnly" Then
                        dgDis.Columns(i).ReadOnly = False
                    End If
                    dgDis.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    dgDis.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case Else
                    dgDis.Columns(i).Visible = False

            End Select



        Next

    End Sub


    Private Sub display_dgPre()
        If rs_PKDISPRM_P.Tables.Count = 0 Then
            Exit Sub
        End If



        dgPre.DataSource = rs_PKDISPRM_P.Tables("RESULT").DefaultView

        dgPre.RowHeadersWidth = 18
        dgPre.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing
        dgPre.ColumnHeadersHeight = 18
        dgPre.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgPre.AllowUserToResizeColumns = True
        dgPre.AllowUserToResizeRows = False
        dgPre.RowTemplate.Height = 18

        Dim i As Integer

        For i = 0 To rs_PKDISPRM_P.Tables("RESULT").Columns.Count - 1
            rs_PKDISPRM_P.Tables("RESULT").Columns(i).ReadOnly = False
        Next


        For i = 0 To dgPre.Columns.Count - 1

            Select Case i


                Case 0
                    dgPre.Columns(i).HeaderText = "Del"
                    dgPre.Columns(i).Width = 40
                    dgPre.Columns(i).ReadOnly = True
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 5
                    dgPre.Columns(i).HeaderText = "Code"
                    dgPre.Columns(i).Width = 80
                    dgPre.Columns(i).ReadOnly = True
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 6
                    dgPre.Columns(i).HeaderText = "Description"
                    dgPre.Columns(i).Width = 220
                    'rs_SCDISPRM_D.Tables("RESULT").Columns(6).ReadOnly = False
                    If mode <> "ReadOnly" Then
                        dgPre.Columns(i).ReadOnly = False
                    End If
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 7
                    dgPre.Columns(i).HeaderText = "Percentage/Amount"
                    dgPre.Columns(i).Width = 120
                    dgPre.Columns(i).ReadOnly = True
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 8
                    dgPre.Columns(i).HeaderText = "%"
                    dgPre.Columns(i).Width = 60
                    'dgPRE.Columns(i).ReadOnly = False

                    If mode <> "ReadOnly" Then
                        dgPre.Columns(i).ReadOnly = False
                    End If
                    dgPre.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case 9
                    dgPre.Columns(i).HeaderText = "Amount"
                    dgPre.Columns(i).Width = 90
                    ' dgPre.Columns(i).ReadOnly = False
                    If mode <> "ReadOnly" Then
                        dgPre.Columns(i).ReadOnly = False
                    End If
                    dgPre.Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight
                    dgPre.Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
                Case Else
                    dgPre.Columns(i).Visible = False

            End Select



        Next

    End Sub




    Private Function save_pkDIS() As Boolean


        If rs_PKDISPRM_D.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        Dim del As String
        Dim code As String
        Dim ordno As String
        Dim type As String
        Dim seq As Integer
        Dim cde As String
        Dim dsc As String
        Dim pctamt As String
        Dim pct As Decimal
        Dim amt As Decimal
        Dim creusr As String


        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1

            del = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL")
            code = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_cocde")
            ordno = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_ordno")
            type = "D"
            seq = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_seqno")
            cde = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_cde")
            dsc = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_dsc")
            pctamt = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pctamt")
            pct = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pct")
            amt = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
            creusr = rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr")


            If del = "Y" Then
                gspStr = "sp_physical_delete_PKDISPRM '" & code & "','" & ordno & "','" & type & "'," & seq

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_physical_delete_PKDISPRM(D) :" & rtnStr)
                    Return False
                    Exit Function
                End If


            ElseIf creusr = "~*ADD*~" Then
                'Insert Seq handel by SP
                gspStr = "sp_insert_PKDISPRM '" & code & "','" & ordno & "'," & type & "," & seq & ",'" & cde & "','" & _
                                                dsc & "'," & pctamt & ",'" & pct & "','" & amt & "','" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_insert_PKDISPRM(D) :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf creusr = "~*UPD*~" Then

                gspStr = "sp_update_PKDISPRM '" & code & "','" & ordno & "'," & type & "," & seq & ",'" & cde & "','" & _
                                                dsc & "'," & pctamt & ",'" & pct & "','" & amt & "','" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_update_PKDISPRM(D) :" & rtnStr)
                    Return False
                    Exit Function
                End If
            End If

        Next

        Return True


    End Function


    Private Function save_pkPRE() As Boolean


        If rs_PKDISPRM_P.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If

        Dim del As String
        Dim code As String
        Dim ordno As String
        Dim type As String
        Dim seq As Integer
        Dim cde As String
        Dim dsc As String
        Dim pctamt As String
        Dim pct As Decimal
        Dim amt As Decimal
        Dim creusr As String


        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1

            del = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL")
            code = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_cocde")
            ordno = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_ordno")
            type = "P"
            seq = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_seqno")
            cde = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_cde")
            dsc = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_dsc")
            pctamt = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pctamt")
            pct = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pct")
            amt = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt")
            creusr = rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr")


            If del = "Y" Then
                gspStr = "sp_physical_delete_PKDISPRM '" & code & "','" & ordno & "','" & type & "'," & seq

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_physical_delete_PKDISPRM(P) :" & rtnStr)
                    Return False
                    Exit Function
                End If


            ElseIf creusr = "~*ADD*~" Then
                'Insert Seq handel by SP
                gspStr = "sp_insert_PKDISPRM '" & code & "','" & ordno & "'," & type & "," & seq & ",'" & cde & "','" & _
                                                dsc & "'," & pctamt & ",'" & pct & "','" & amt & "','" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_insert_PKDISPRM(P) :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf creusr = "~*UPD*~" Then

                gspStr = "sp_update_PKDISPRM '" & code & "','" & ordno & "'," & type & "," & seq & ",'" & cde & "','" & _
                                                dsc & "'," & pctamt & ",'" & pct & "','" & amt & "','" & gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkDIS sp_update_PKDISPRM(P) :" & rtnStr)
                    Return False
                    Exit Function
                End If
            End If

        Next

        Return True


    End Function

    Private Function save_pkREPORD() As Boolean

        If rs_PKREPORD.Tables("RESULT").Rows.Count = 0 Then
            Return True
            Exit Function
        End If


        Dim code As String
        Dim ordno As String
        Dim repord As String
        Dim creusr As String


        For i As Integer = 0 To rs_PKREPORD.Tables("RESULT").Rows.Count - 1


            code = rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_cocde")
            ordno = rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_ordno")
            repord = rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_repord")
            creusr = rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr")


            If creusr = "DEL" Then
                gspStr = "sp_physical_delete_PKREPORD '" & code & "','" & ordno & "','" & repord & "'"

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkREPORD sp_physical_delete_PKREPORD :" & rtnStr)
                    Return False
                    Exit Function
                End If


            ElseIf creusr = "ADD" Then

                gspStr = "sp_insert_PKREPORD '" & code & "','" & ordno & "','" & repord & "','" & _
                                               gsUsrID & "'"



                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading save_pkREPORD sp_insert_PKREPORD :" & rtnStr)
                    Return False
                    Exit Function
                End If

            ElseIf creusr = "UPD" Then


            End If

        Next

        Return True

    End Function



    Private Sub txtMOA_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtMOA.KeyDown
        If e.KeyValue = Keys.Delete Then
            recordstatus = True
            flag_panpack_keypress = True
            SetAsUpdate(txtSeq.Text)
        End If
    End Sub

    Private Sub txtMOA_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtMOA.KeyPress

        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8 Or Asc(e.KeyChar) = 46 Or Asc(e.KeyChar) = 13) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If

        If txtMOA.Text.Contains(".") = True Then
            If Asc(e.KeyChar) = 46 Then
                e.KeyChar = Chr(0)
                MsgBox("Please input integer value.")
            End If
        End If


        recordstatus = True
        flag_panpack_keypress = True
        SetAsUpdate(txtSeq.Text)

    End Sub





    Private Sub txtMOA_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtMOA.TextChanged

    End Sub

    Private Sub txtMOA_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtMOA.Validated
        If txtMOA.Text = "" Then
            txtMOA.Text = 0
        End If



        update_PKREQDTL()


        Dim ttlpri As Decimal

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA") <> 0 Then
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_MOA"), 2)
            Else
                ttlpri = ttlpri + round(rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_ttlamtqty"), 2)
            End If

        Next

        txtHdrTtlAmt.Text = ttlpri

        Dim HdrTtlam As Decimal
        Dim HdrDCAMT As Decimal

        HdrTtlam = txtHdrTtlAmt.Text
        If txtHdrDC.Text = "" Then
            HdrDCAMT = 0
        Else
            HdrDCAMT = txtHdrDC.Text
        End If

        txtHdrTA_F.Text = HdrTtlam + HdrDCAMT


        Dim hdrTA_F As Decimal
        hdrTA_F = txtHdrTA_F.Text

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)


                If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pctamt").ToString = "Percentage" Then
                rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") = _
                round(rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_pct") * hdrTA_F / 100, 2)

                If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*ADD*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*DEL*~" And _
              rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") <> "~*NEW*~" Then
                    rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_creusr") = "~*UPD*~"
                End If


            End If
        Next

        Dim total_Dis As Decimal = 0
        Dim total_Pre As Decimal = 0

        For i As Integer = 0 To rs_PKDISPRM_D.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Dis = total_Dis + rs_PKDISPRM_D.Tables("RESULT").Rows(i).Item("pdp_amt")
            End If
        Next

        For i As Integer = 0 To rs_PKDISPRM_P.Tables("RESULT").Rows.Count - 1
            If rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("DEL") <> "Y" Then
                total_Pre = total_Pre + rs_PKDISPRM_P.Tables("RESULT").Rows(i).Item("pdp_amt") 'Just Finish
            End If
        Next


        txtHdrTA.Text = hdrTA_F - total_Dis + total_Pre



        rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"

    End Sub

    Private Sub txtMOA_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtMOA.Validating
        If txtMOA.Text = "" Then
            Exit Sub
        End If

        If IsNumeric(txtMOA.Text) = False Then

            MsgBox("Please input valid integer")
            txtMOA.Focus()
            e.Cancel = True
        End If
    End Sub

    Private Sub cboTtlUm_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboTtlUm.GotFocus
        MouseClickCbo = True
    End Sub

    Private Sub cboTtlUm_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboTtlUm.KeyUp
        auto_search_combo(cboTtlUm, e.KeyCode)
    End Sub

    Private Sub cboTtlUm_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboTtlUm.LostFocus
        MouseClickCbo = False
    End Sub

    Private Sub cboTtlUm_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboTtlUm.SelectedIndexChanged

        If MouseClickCbo = True Then
            MouseClickCbo = False


            SetAsUpdate(txtSeq.Text)
            recordstatus = True
            update_PKREQDTL()
        End If '

        cboOrdUm.Text = cboTtlUm.Text
        cboWastUm.Text = cboTtlUm.Text
        cboStkUm.Text = cboTtlUm.Text

    End Sub

    Private Sub cboTtlUm_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboTtlUm.Validated


        If checkValidCombo(cboTtlUm, cboTtlUm.Text) = False Then
            MsgBox("Data Invalid")
            cboTtlUm.Text = "PC"
            Exit Sub
        End If
    End Sub

    Private Sub cmdRePrint_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRePrint.Click
        Update_Reporder_ListBox()
        PanelRepord.BringToFront()
        PanelRepord.Visible = True

    End Sub

    Private Sub cmdRepordAdd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRepordAdd.Click
        Dim UserInput As String
        UserInput = InputBox("Please Input Packaging Order No.", "Packaging Re-print Order Input Box").Trim.ToUpper

        If UserInput.ToString <> "" Then
            If lstRepord.Items.Contains(UserInput.ToString) = True Then
                MsgBox("Acation Cancel , Input Duplicate Packaging Re-print Order No.")
                Exit Sub
            ElseIf UserInput.ToString.Trim = txtReqno.Text.Trim Then
                MsgBox("Acation Cancel , Re-print Order No cannot be itself.")
                Exit Sub
            Else

                gspStr = "sp_select_PKORDHDR_Check_Reprint '" & UserInput.ToString & "'"

                rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading sp_select_PKORDHDR_Check_Reprint :" & rtnStr)
                    Exit Sub
                Else
                    If rs.Tables("RESULT").Rows.Count <> 0 Then
                        If rs.Tables("RESULT").Rows(0).Item("poh_cocde").ToString <> cbococde.Text.ToString Then
                            MsgBox("Acation Cancel , Please input same comapny code Order No.")
                            Exit Sub
                        End If
                    Else
                        MsgBox("Acaction Cancel , Order No not Found")
                        Exit Sub
                    End If
                End If


                lstRepord.Items.Add(UserInput.ToString)
                Dim foundRows() As Data.DataRow
                foundRows = rs_PKREPORD.Tables("RESULT").Select("pro_repord = '" & UserInput.ToString & "'")

                If foundRows.Length <> 0 Then
                    'Update del to new
                    For i As Integer = 0 To rs_PKREPORD.Tables("RESULT").Rows.Count - 1
                        If rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_repord").ToString = UserInput.ToString Then
                            If rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr").ToString = "NEW" Then
                                rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") = "ADD"
                            ElseIf rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr").ToString = "DEL" Then
                                rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") = "UPD"
                            End If
                        End If
                    Next
                Else
                    'New record

                    Dim rowcount_dtl As Integer
                    rowcount_dtl = rs_PKREPORD.Tables("RESULT").Rows.Count
                    rs_PKREPORD.Tables("RESULT").Rows.Add()
                    rs_PKREPORD.Tables("RESULT").Rows(rowcount_dtl).Item("pro_cocde") = cbococde.Text
                    rs_PKREPORD.Tables("RESULT").Rows(rowcount_dtl).Item("pro_ordno") = txtReqno.Text
                    rs_PKREPORD.Tables("RESULT").Rows(rowcount_dtl).Item("pro_repord") = UserInput.ToString
                    rs_PKREPORD.Tables("RESULT").Rows(rowcount_dtl).Item("pro_creusr") = "ADD"


                End If

            End If
        End If

        If lstRepord.Items.Count <> 0 Then
            txtReprtFlag.Text = "Y"
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        Else
            txtReprtFlag.Text = "N"
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If

    End Sub

    Private Sub cmdRepordDel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRepordDel.Click
        Dim selectedItem As String
        selectedItem = lstRepord.SelectedItem

        If selectedItem Is Nothing Then
            Exit Sub
        End If

        If selectedItem.ToString <> "" Then
            lstRepord.Items.Remove(selectedItem)

            'Update flag to del 
            For i As Integer = 0 To rs_PKREPORD.Tables("RESULT").Rows.Count - 1
                If rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_repord").ToString = selectedItem.ToString Then
                    If rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") <> "ADD" And _
                    rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") <> "NEW" Then
                        rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") = "DEL"
                    ElseIf rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") = "ADD" Then
                        rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") = "NEW"
                    End If
                End If
            Next

        End If

        If lstRepord.Items.Count <> 0 Then
            txtReprtFlag.Text = "Y"
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        Else
            txtReprtFlag.Text = "N"
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If


    End Sub

    Private Sub Update_Reporder_ListBox()
        lstRepord.Items.Clear()

        For i As Integer = 0 To rs_PKREPORD.Tables("RESULT").Rows.Count - 1
            If rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") <> "DEL" And _
                rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_creusr") <> "NEW" Then
                lstRepord.Items.Add(rs_PKREPORD.Tables("RESULT").Rows(i).Item("pro_repord"))
            End If
        Next

    End Sub

    Private Sub cmdRepordClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRepordClose.Click
        Update_Reporder_ListBox()
        PanelRepord.Visible = False
    End Sub

    Private Sub cboHdrVen_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrVen.SelectedIndexChanged

    End Sub

    Private Sub dgMltShp_LostFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgMltShp.LostFocus

    End Sub

    Private Sub dgMltShp_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles dgMltShp.Validating

    End Sub

    Private Sub cboHdrAdd_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrAdd_fty.GotFocus
        cboHdrAdd_fty_GotFocus_flag = True
    End Sub

    Private Sub cboHdrAdd_fty_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrAdd_fty.SelectedIndexChanged
        If cboHdrAdd_fty_GotFocus_flag = True Then
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
            cboHdrAdd_fty_GotFocus_flag = False
        End If
    End Sub

    Private Sub txtHdrSta_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrSta_fty.GotFocus
        txtHdrSta_fty_GotFocus_flag = True

    End Sub

    Private Sub txtHdrSta_fty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrSta_fty.TextChanged
        If txtHdrSta_fty_GotFocus_flag = True Then '
            txtHdrSta_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If

    End Sub

    Private Sub txtHdrCty_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrCty_fty.GotFocus
        txtHdrCty_fty_GotFocus_flag = True

    End Sub

    Private Sub txtHdrCty_fty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrCty_fty.TextChanged
        If txtHdrCty_fty_GotFocus_flag = True Then
            txtHdrCty_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If
    End Sub

    Private Sub txtHdrzip_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrzip_fty.GotFocus
        txtHdrzip_fty_GotFocus_flag = True

    End Sub

    Private Sub txtHdrzip_fty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrzip_fty.TextChanged
        If txtHdrzip_fty_GotFocus_flag = True Then
            txtHdrzip_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If
    End Sub

    Private Sub cboHdrCtn_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn_fty.GotFocus
        cboHdrCtn_fty_GotFocus_flag = True

    End Sub

    Private Sub cboHdrCtn_fty_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrCtn_fty.SelectedIndexChanged

        If cboHdrCtn_fty_GotFocus_flag = True Then
            cboHdrCtn_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If
    End Sub

    Private Sub txtHdrTel_fty_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtHdrTel_fty.GotFocus
        txtHdrTel_fty_GotFocus_flag = True

    End Sub

    Private Sub txtHdrTel_fty_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrTel_fty.TextChanged
        If txtHdrTel_fty_GotFocus_flag = True Then
            txtHdrTel_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If

    End Sub

    Private Sub cboHdrAdd_dtl_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboHdrAdd_dtl.KeyPress
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub cboHdrAdd_dtl_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles cboHdrAdd_dtl.MouseDown
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub cboHdrAdd_dtl_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrAdd_dtl.SelectedIndexChanged
         
    End Sub

    Private Sub txtHdrSta_dtl_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrSta_dtl.KeyPress
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtHdrSta_dtl_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrSta_dtl.TextChanged
         
    End Sub

    Private Sub txtHdrCty_dtl_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrCty_dtl.TextChanged
         
    End Sub

    Private Sub txtHdrzip_dtl_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrzip_dtl.KeyPress
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtHdrzip_dtl_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrzip_dtl.TextChanged
    End Sub

    Private Sub cboHdrCtn_dtl_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboHdrCtn_dtl.KeyPress
        SetAsUpdate(txtSeq.Text)
    End Sub

   

    Private Sub cboHdrCtn_dtl_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles cboHdrCtn_dtl.MouseDown
        SetAsUpdate(txtSeq.Text)
    End Sub
     

    Private Sub cboHdrCtn_dtl_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboHdrCtn_dtl.SelectedIndexChanged
         
    End Sub

    Private Sub txtHdrTel_dtl_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtHdrTel_dtl.KeyPress
        SetAsUpdate(txtSeq.Text)
    End Sub

    Private Sub txtHdrTel_dtl_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrTel_dtl.TextChanged
         
    End Sub

    Private Sub txtHdrSta_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtHdrSta.TextChanged

    End Sub

    Private Sub txtPrtDsc_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPrtDsc.TextChanged

    End Sub

    Private Sub cboHdrCtn_fty_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn_fty.TextChanged

        If cboHdrCtn_fty_GotFocus_flag = True Then
            cboHdrCtn_fty_GotFocus_flag = False
            recordstatus = True
            rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_creusr") = "~*UPD*~"
        End If
    End Sub

    Private Sub cboHdrCtn_fty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn_fty.Validated
        If Trim(cboHdrCtn_fty.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboHdrCtn_fty, cboHdrCtn_fty.Text) = False Then
            MsgBox("Data Invalid")
            cboHdrCtn_fty.Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub cboHdrCtn_dtl_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboHdrCtn_dtl.Validated
        If Trim(cboHdrCtn_dtl.Text) = "" Then
            Exit Sub
        End If

        If checkValidCombo(cboHdrCtn_dtl, cboHdrCtn_dtl.Text) = False Then
            MsgBox("Data Invalid")
            cboHdrCtn_dtl.Text = ""
            Exit Sub
        End If

    End Sub


#Region "Movable Panel"

    Dim ProgramPosition, CursorPoint As Point
    Dim movePanel As String
    Dim panelMoveTimer As Timer
    Private Sub RenewPanel(ByVal panel As Panel)
        ProgramPosition = panel.Location
        CursorPoint = Cursor.Position
    End Sub

    Private Sub SetPanelPosition(ByVal panel As Panel)
        Dim X As Integer = 0
        Dim Y As Integer = 0


        Dim Xlimit As Integer
        Dim Ylimit As Integer
        If Me.FormBorderStyle = FormBorderStyle.FixedDialog Then

            Xlimit = Me.Width - panel.Width - SystemInformation.HorizontalResizeBorderThickness
            Ylimit = Me.Height - panel.Height - SystemInformation.VerticalResizeBorderThickness - SystemInformation.MenuHeight - SystemInformation.VerticalFocusThickness * 3
        Else
            Xlimit = Me.Width - panel.Width - SystemInformation.HorizontalResizeBorderThickness * 2
            Ylimit = Me.Height - panel.Height - SystemInformation.VerticalResizeBorderThickness * 2 - SystemInformation.MenuHeight - SystemInformation.VerticalFocusThickness * 3

        End If

        If (ProgramPosition - CursorPoint + Cursor.Position).X > 0 And (ProgramPosition - CursorPoint + Cursor.Position).X < Xlimit Then
            X = (ProgramPosition - CursorPoint + Cursor.Position).X
        ElseIf (ProgramPosition - CursorPoint + Cursor.Position).X <= 0 Then
            X = 0
        Else
            X = Xlimit
        End If

        If (ProgramPosition - CursorPoint + Cursor.Position).Y > 0 And (ProgramPosition - CursorPoint + Cursor.Position).Y < Ylimit Then
            Y = (ProgramPosition - CursorPoint + Cursor.Position).Y
        ElseIf (ProgramPosition - CursorPoint + Cursor.Position).Y <= 0 Then
            Y = 0
        Else
            Y = Ylimit
        End If

        panel.Location = New Point(X, Y)
    End Sub

    Private Sub panelMoveTimer_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim X As Integer = 0
        Dim Y As Integer = 0
        Select Case movePanel
            Case PanelRepord.Name
                SetPanelPosition(PanelRepord)
            Case PelReqdtl.Name
                SetPanelPosition(PelReqdtl)
            Case PelInvDtl.Name
                SetPanelPosition(PelInvDtl)
        End Select


    End Sub

    Private Sub PanelRepord_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PanelRepord.MouseDown, Label144.MouseDown
        movePanel = PanelRepord.Name
        panelMoveTimer.Enabled = True
        panelMoveTimer.Start()
        RenewPanel(PanelRepord)
    End Sub

    Private Sub PanelRepord_MouseUp(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PanelRepord.MouseUp, Label144.MouseUp
        panelMoveTimer.Stop()
        RenewPanel(PanelRepord)
        movePanel = ""
    End Sub

    Private Sub PelReqdtl_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PelReqdtl.MouseDown
        movePanel = PelReqdtl.Name
        panelMoveTimer.Enabled = True
        panelMoveTimer.Start()
        RenewPanel(PelReqdtl)
    End Sub

    Private Sub PelReqdtl_MouseUp(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PelReqdtl.MouseUp
        panelMoveTimer.Stop()
        RenewPanel(PelReqdtl)
        movePanel = ""
    End Sub

    Private Sub PelInvDtl_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PelInvDtl.MouseDown
        movePanel = PelInvDtl.Name
        panelMoveTimer.Enabled = True
        panelMoveTimer.Start()
        RenewPanel(PelInvDtl)
    End Sub

    Private Sub PelInvDtl_MouseUp(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles PelInvDtl.MouseUp
        panelMoveTimer.Stop()
        RenewPanel(PelInvDtl)
        movePanel = ""
    End Sub


#End Region



    Private Sub mmdRel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdRel.Click
        FrmPGM00008 = New PGM00008
        FrmPGM00008.txtFrom.Text = txtReqno.Text
        FrmPGM00008.txtTo.Text = txtReqno.Text
        FrmPGM00008.company = cbococde.Text
        FrmPGM00008.cboCoCde.Enabled = False

        FrmPGM00008.txtFrom.Enabled = False
        FrmPGM00008.txtTo.Enabled = False
        FrmPGM00008.optRel.Enabled = False
        FrmPGM00008.optUnr.Enabled = False

        If cboStatus.Text.Split(" -")(0) = "REL" Then
            FrmPGM00008.optUnr.Checked = True
        Else
            FrmPGM00008.optRel.Checked = True
        End If


        FrmPGM00008.ShowDialog()
    End Sub

    Private Sub mmdCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdCancel.Click
        Select Case MsgBox("Are you sure to Cancel?", MsgBoxStyle.YesNoCancel)
            Case MsgBoxResult.Yes
            Case MsgBoxResult.No
                Exit Sub
        End Select


        If rs_PKORDHDR.Tables("RESULT").Rows(0).Item("poh_status") = "APV" Then
            MsgBox("Order already approved , action fail.")
            Exit Sub
        End If

        For i As Integer = 0 To rs_PKORDDTL.Tables("RESULT").Rows.Count - 1
            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_status") = "APV" Then
                MsgBox("Seq : " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") & " already approved , action fail.")
                Exit Sub
            End If

            If rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_stkqty") > 0 Then

                Dim dr() As DataRow
                dr = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm") & "'")

                If dr.Length = 0 Then

                ElseIf dr.Length <> 0 Then

                    Dim sumqty As Integer = 0

                    For x As Integer = 0 To dr.Length - 1
                        sumqty = sumqty + dr(x)("pih_avlqty")
                    Next

                    Dim pastqty As Integer
                    Dim pastrow() As DataRow

                    pastrow = rs_PKINVHDR.Tables("RESULT").Select("pih_pkgitm ='" & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_pkgitm") & "' and pid_ordno = '" & txtReqno.Text & "' and pid_ordseq = " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq"))
                    If pastrow.Length <> 0 Then
                        pastqty = pastrow(0)("pih_avlqty")
                    Else
                        pastqty = 0
                    End If

                    Dim currentqty As Integer = pastqty 'Convert.ToInt32(txtStkqty.Text)
                    '  Dim wasageqty As Integer = txtPkgWast.Text
                    ' Dim ordqty As Integer = txtPkgOrdQty.Text


                    If (sumqty - pastqty) < 0 Then

                        MsgBox("Seq : " & rs_PKORDDTL.Tables("RESULT").Rows(i).Item("pod_seq") & " Stock Qty already assigned to other Order , action fail.")
                        Exit Sub

                    End If

                End If
            End If

        Next


        gspStr = "sp_select_PKORDHDR_cancel '" & cbococde.Text & "','" & txtReqno.Text & "','" & gsUsrID & "'"

        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading cmdCanOrd_Click sp_select_PKORDHDR_cancel :" & rtnStr)
            Exit Sub
        End If

        MsgBox("Record Saved")
        recordstatus = False
        mmdClear_Click(sender, e)
    End Sub

    'Private Sub mmdCloseOrd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    '    Select Case MsgBox("Do you want to Close Order?", MsgBoxStyle.YesNoCancel)
    '        Case MsgBoxResult.Yes

    '            gspStr = "sp_update_PGM00004_CLOSE '" & cbococde.Text & "','" & txtReqno.Text & "','" & "CLO" & "','" & gsUsrID & " '"
    '            rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)

    '            If rtnLong <> RC_SUCCESS Then
    '                MsgBox("Error on loading cmdCloseOrd_Click sp_update_PGM00004_CLOSE :" & rtnStr)
    '                Exit Sub
    '            End If

    '            MsgBox("Record Saved")
    '            recordstatus = False
    '            mmdClear_Click(sender, e)
    '        Case MsgBoxResult.No
    '            Exit Sub
    '    End Select

    'End Sub

    Private Sub cmdUnRelease_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdUnRelease.Click

    End Sub

    Private Sub mmdPrint_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdPrint.Click
        FrmPGM00007 = New PGM00007

        FrmPGM00007.cboCoCde.Enabled = False
        FrmPGM00007.company = cbococde.Text
        FrmPGM00007.txt_S_PKGNo.Text = txtReqno.Text
        FrmPGM00007.txt_S_PKGNo.Enabled = False
        FrmPGM00007.cmd_S_PKGNo.Enabled = False
        FrmPGM00007.ShowDialog()
    End Sub

    Private Sub mmdRel_EnabledChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdRel.EnabledChanged, mmdCancel.EnabledChanged
        mmdFunction.Enabled = mmdFunction_Right
        If mmdRel.Enabled = False And mmdCancel.Enabled = False Then
            mmdFunction.Enabled = False
        End If
    End Sub

   
End Class



