Public Class MPO00001

    Inherits System.Windows.Forms.Form

    Dim rs_MPOXLSHDR As New DataSet
    Dim rs_MPOXLSDTL As New DataSet

    'Dim rs_MPOXLSHDR_Blk As New DataSet
    Dim rs_MPOXLSDTL_Blk As New DataSet
    Dim colVen As Integer
    Dim colPONo As Integer
    Dim colVenNo As Integer
    '*** Folder 1
    Dim colShipDate_dtl As Integer
    Dim colPONO_dtl As Integer




#Region " Windows Form Designer generated code"
    Friend WithEvents SSTab1 As ERPSystem.BaseTabControl
    Friend WithEvents tpMPO00001_1 As System.Windows.Forms.TabPage
    Friend WithEvents tpMPO00001_2 As System.Windows.Forms.TabPage
    Friend WithEvents cmdSearch As System.Windows.Forms.Button
    Friend WithEvents cmdspecial As System.Windows.Forms.Button
    Friend WithEvents cmdbrowlist As System.Windows.Forms.Button
    Friend WithEvents GroupBox5 As System.Windows.Forms.GroupBox
    Friend WithEvents optCtrSiz3 As System.Windows.Forms.RadioButton
    Friend WithEvents optCtrSiz2 As System.Windows.Forms.RadioButton
    Friend WithEvents optCtrSiz1 As System.Windows.Forms.RadioButton
    Friend WithEvents optCtrSiz0 As System.Windows.Forms.RadioButton
    Friend WithEvents optCtrSiz4 As System.Windows.Forms.RadioButton
    Friend WithEvents cboPckRmk As System.Windows.Forms.ComboBox
    Friend WithEvents Label30 As System.Windows.Forms.Label
    Friend WithEvents txtColDsc As System.Windows.Forms.TextBox
    Friend WithEvents Label29 As System.Windows.Forms.Label
    Friend WithEvents Label27 As System.Windows.Forms.Label
    Friend WithEvents txtCustUM As System.Windows.Forms.TextBox
    Friend WithEvents optSearch1 As System.Windows.Forms.RadioButton
    Friend WithEvents optSearch0 As System.Windows.Forms.RadioButton
    Friend WithEvents Label37 As System.Windows.Forms.Label
    Friend WithEvents txtInrCtn As System.Windows.Forms.TextBox
    Friend WithEvents Label38 As System.Windows.Forms.Label
    Friend WithEvents txtUntCde As System.Windows.Forms.TextBox
    Friend WithEvents Label40 As System.Windows.Forms.Label
    Friend WithEvents txtVol As System.Windows.Forms.TextBox
    Friend WithEvents Label39 As System.Windows.Forms.Label
    Friend WithEvents txtMtrCtn As System.Windows.Forms.TextBox
    Friend WithEvents Label41 As System.Windows.Forms.Label
    Friend WithEvents Label42 As System.Windows.Forms.Label
    Friend WithEvents Label44 As System.Windows.Forms.Label
    Friend WithEvents Label43 As System.Windows.Forms.Label
    Friend WithEvents Label45 As System.Windows.Forms.Label
    Friend WithEvents txtTtlVolD As System.Windows.Forms.TextBox
    Friend WithEvents Label46 As System.Windows.Forms.Label
    Friend WithEvents txtActVol As System.Windows.Forms.TextBox
    Friend WithEvents txtMtrhcm As System.Windows.Forms.TextBox
    Friend WithEvents txtMtrwcm As System.Windows.Forms.TextBox
    Friend WithEvents txtMtrdcm As System.Windows.Forms.TextBox
    Friend WithEvents Label47 As System.Windows.Forms.Label
    Friend WithEvents Label48 As System.Windows.Forms.Label
    Friend WithEvents txtTtlNetD As System.Windows.Forms.TextBox
    Friend WithEvents txtNetWgt As System.Windows.Forms.TextBox
    Friend WithEvents Label49 As System.Windows.Forms.Label
    Friend WithEvents Label50 As System.Windows.Forms.Label
    Friend WithEvents txtTtlGrsD As System.Windows.Forms.TextBox
    Friend WithEvents txtGrsWgt As System.Windows.Forms.TextBox
    Friend WithEvents Label52 As System.Windows.Forms.Label
    Friend WithEvents txtCmpRmk As System.Windows.Forms.TextBox
    Friend WithEvents Label56 As System.Windows.Forms.Label
    Friend WithEvents cboPCPrc As System.Windows.Forms.ComboBox
    Friend WithEvents txtCusVen As System.Windows.Forms.TextBox
    Friend WithEvents txtVenNo As System.Windows.Forms.TextBox
    Friend WithEvents txtPurOrd As System.Windows.Forms.TextBox
    Friend WithEvents txtColCde As System.Windows.Forms.TextBox
    Friend WithEvents txtOrdSeq As System.Windows.Forms.TextBox
    Friend WithEvents txtItmTyp As System.Windows.Forms.TextBox
    Friend WithEvents txtPrcTrm As System.Windows.Forms.TextBox
    Friend WithEvents txtOrgQty As System.Windows.Forms.TextBox
    Friend WithEvents txtOutQty As System.Windows.Forms.TextBox
    Friend WithEvents txtPayTrm As System.Windows.Forms.TextBox
    Friend WithEvents Label88 As System.Windows.Forms.Label
    Friend WithEvents StatusBar As System.Windows.Forms.StatusBar
    Friend WithEvents StatusBarPanel1 As System.Windows.Forms.StatusBarPanel
    Friend WithEvents StatusBarPanel2 As System.Windows.Forms.StatusBarPanel
    Friend WithEvents cboCus2No_dtl As System.Windows.Forms.ComboBox
    Friend WithEvents txtmodvol As System.Windows.Forms.TextBox
    Friend WithEvents TextBox11 As System.Windows.Forms.TextBox
    Friend WithEvents ComboBox6 As System.Windows.Forms.ComboBox
    Friend WithEvents RichTextBox3 As System.Windows.Forms.RichTextBox
    Friend WithEvents GroupBox3 As System.Windows.Forms.GroupBox
    Friend WithEvents grdMPOHdr As System.Windows.Forms.DataGridView
    Friend WithEvents grdMPODtl As System.Windows.Forms.DataGridView
    Friend WithEvents frmApproveReject As System.Windows.Forms.GroupBox
    Friend WithEvents chkDelete As System.Windows.Forms.CheckBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtPOFm As System.Windows.Forms.TextBox
    Friend WithEvents txtUplDatTo As System.Windows.Forms.TextBox
    Friend WithEvents lblIssDat As System.Windows.Forms.Label
    Friend WithEvents txtUplDatFm As System.Windows.Forms.TextBox
    Friend WithEvents lblRvsDat As System.Windows.Forms.Label
    Friend WithEvents txtPOTo As System.Windows.Forms.TextBox
    Friend WithEvents chkNew As System.Windows.Forms.CheckBox
    Friend WithEvents chkGen As System.Windows.Forms.CheckBox

    Public rs_POM00010_AppList As New DataSet

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents cmdDelete As System.Windows.Forms.Button
    Friend WithEvents cmdSave As System.Windows.Forms.Button
    Friend WithEvents cmdAdd As System.Windows.Forms.Button
    Friend WithEvents cmdLast As System.Windows.Forms.Button
    Friend WithEvents cmdPrv As System.Windows.Forms.Button
    Friend WithEvents cmdNext As System.Windows.Forms.Button
    Friend WithEvents cmdFind As System.Windows.Forms.Button
    Friend WithEvents cmdCopy As System.Windows.Forms.Button
    Friend WithEvents cmdClear As System.Windows.Forms.Button
    Friend WithEvents cmdExit As System.Windows.Forms.Button
    Friend WithEvents cmdDelRow As System.Windows.Forms.Button
    Friend WithEvents cmdFirst As System.Windows.Forms.Button
    Friend WithEvents cmdInsRow As System.Windows.Forms.Button
    Friend WithEvents CmdLookup As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.cmdDelete = New System.Windows.Forms.Button
        Me.cmdSave = New System.Windows.Forms.Button
        Me.cmdAdd = New System.Windows.Forms.Button
        Me.cmdLast = New System.Windows.Forms.Button
        Me.cmdPrv = New System.Windows.Forms.Button
        Me.cmdNext = New System.Windows.Forms.Button
        Me.cmdFind = New System.Windows.Forms.Button
        Me.cmdCopy = New System.Windows.Forms.Button
        Me.cmdClear = New System.Windows.Forms.Button
        Me.cmdExit = New System.Windows.Forms.Button
        Me.cmdDelRow = New System.Windows.Forms.Button
        Me.cmdFirst = New System.Windows.Forms.Button
        Me.cmdInsRow = New System.Windows.Forms.Button
        Me.CmdLookup = New System.Windows.Forms.Button
        Me.cmdSearch = New System.Windows.Forms.Button
        Me.cmdspecial = New System.Windows.Forms.Button
        Me.cmdbrowlist = New System.Windows.Forms.Button
        Me.StatusBar = New System.Windows.Forms.StatusBar
        Me.StatusBarPanel1 = New System.Windows.Forms.StatusBarPanel
        Me.StatusBarPanel2 = New System.Windows.Forms.StatusBarPanel
        Me.TextBox11 = New System.Windows.Forms.TextBox
        Me.ComboBox6 = New System.Windows.Forms.ComboBox
        Me.RichTextBox3 = New System.Windows.Forms.RichTextBox
        Me.frmApproveReject = New System.Windows.Forms.GroupBox
        Me.chkGen = New System.Windows.Forms.CheckBox
        Me.chkDelete = New System.Windows.Forms.CheckBox
        Me.chkNew = New System.Windows.Forms.CheckBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtPOFm = New System.Windows.Forms.TextBox
        Me.txtUplDatTo = New System.Windows.Forms.TextBox
        Me.lblIssDat = New System.Windows.Forms.Label
        Me.txtUplDatFm = New System.Windows.Forms.TextBox
        Me.lblRvsDat = New System.Windows.Forms.Label
        Me.txtPOTo = New System.Windows.Forms.TextBox
        Me.SSTab1 = New ERPSystem.BaseTabControl
        Me.tpMPO00001_1 = New System.Windows.Forms.TabPage
        Me.grdMPOHdr = New System.Windows.Forms.DataGridView
        Me.tpMPO00001_2 = New System.Windows.Forms.TabPage
        Me.GroupBox3 = New System.Windows.Forms.GroupBox
        Me.grdMPODtl = New System.Windows.Forms.DataGridView
        Me.txtmodvol = New System.Windows.Forms.TextBox
        Me.txtCusVen = New System.Windows.Forms.TextBox
        Me.txtVenNo = New System.Windows.Forms.TextBox
        Me.cboPCPrc = New System.Windows.Forms.ComboBox
        Me.optSearch1 = New System.Windows.Forms.RadioButton
        Me.optSearch0 = New System.Windows.Forms.RadioButton
        Me.Label30 = New System.Windows.Forms.Label
        Me.txtPurOrd = New System.Windows.Forms.TextBox
        Me.txtVol = New System.Windows.Forms.TextBox
        Me.txtColCde = New System.Windows.Forms.TextBox
        Me.Label39 = New System.Windows.Forms.Label
        Me.txtMtrCtn = New System.Windows.Forms.TextBox
        Me.Label40 = New System.Windows.Forms.Label
        Me.Label56 = New System.Windows.Forms.Label
        Me.GroupBox5 = New System.Windows.Forms.GroupBox
        Me.txtCmpRmk = New System.Windows.Forms.TextBox
        Me.cboCus2No_dtl = New System.Windows.Forms.ComboBox
        Me.Label52 = New System.Windows.Forms.Label
        Me.txtTtlNetD = New System.Windows.Forms.TextBox
        Me.Label88 = New System.Windows.Forms.Label
        Me.txtNetWgt = New System.Windows.Forms.TextBox
        Me.Label49 = New System.Windows.Forms.Label
        Me.Label50 = New System.Windows.Forms.Label
        Me.txtTtlGrsD = New System.Windows.Forms.TextBox
        Me.txtGrsWgt = New System.Windows.Forms.TextBox
        Me.txtItmTyp = New System.Windows.Forms.TextBox
        Me.Label48 = New System.Windows.Forms.Label
        Me.Label47 = New System.Windows.Forms.Label
        Me.Label45 = New System.Windows.Forms.Label
        Me.txtTtlVolD = New System.Windows.Forms.TextBox
        Me.txtOrdSeq = New System.Windows.Forms.TextBox
        Me.Label46 = New System.Windows.Forms.Label
        Me.txtActVol = New System.Windows.Forms.TextBox
        Me.txtMtrhcm = New System.Windows.Forms.TextBox
        Me.txtMtrwcm = New System.Windows.Forms.TextBox
        Me.txtMtrdcm = New System.Windows.Forms.TextBox
        Me.Label44 = New System.Windows.Forms.Label
        Me.txtOrgQty = New System.Windows.Forms.TextBox
        Me.Label43 = New System.Windows.Forms.Label
        Me.Label42 = New System.Windows.Forms.Label
        Me.Label41 = New System.Windows.Forms.Label
        Me.Label37 = New System.Windows.Forms.Label
        Me.txtInrCtn = New System.Windows.Forms.TextBox
        Me.Label38 = New System.Windows.Forms.Label
        Me.txtUntCde = New System.Windows.Forms.TextBox
        Me.cboPckRmk = New System.Windows.Forms.ComboBox
        Me.txtColDsc = New System.Windows.Forms.TextBox
        Me.txtOutQty = New System.Windows.Forms.TextBox
        Me.Label29 = New System.Windows.Forms.Label
        Me.txtPrcTrm = New System.Windows.Forms.TextBox
        Me.txtPayTrm = New System.Windows.Forms.TextBox
        Me.optCtrSiz3 = New System.Windows.Forms.RadioButton
        Me.optCtrSiz4 = New System.Windows.Forms.RadioButton
        Me.optCtrSiz0 = New System.Windows.Forms.RadioButton
        Me.optCtrSiz1 = New System.Windows.Forms.RadioButton
        Me.optCtrSiz2 = New System.Windows.Forms.RadioButton
        Me.txtCustUM = New System.Windows.Forms.TextBox
        Me.Label27 = New System.Windows.Forms.Label
        CType(Me.StatusBarPanel1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.StatusBarPanel2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmApproveReject.SuspendLayout()
        Me.SSTab1.SuspendLayout()
        Me.tpMPO00001_1.SuspendLayout()
        CType(Me.grdMPOHdr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.tpMPO00001_2.SuspendLayout()
        Me.GroupBox3.SuspendLayout()
        CType(Me.grdMPODtl, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox5.SuspendLayout()
        Me.SuspendLayout()
        '
        'cmdDelete
        '
        Me.cmdDelete.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdDelete.Location = New System.Drawing.Point(106, 0)
        Me.cmdDelete.Name = "cmdDelete"
        Me.cmdDelete.Size = New System.Drawing.Size(54, 34)
        Me.cmdDelete.TabIndex = 2
        Me.cmdDelete.TabStop = False
        Me.cmdDelete.Text = "&Delete"
        '
        'cmdSave
        '
        Me.cmdSave.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdSave.Location = New System.Drawing.Point(53, 0)
        Me.cmdSave.Name = "cmdSave"
        Me.cmdSave.Size = New System.Drawing.Size(54, 34)
        Me.cmdSave.TabIndex = 1
        Me.cmdSave.TabStop = False
        Me.cmdSave.Text = "&Save"
        '
        'cmdAdd
        '
        Me.cmdAdd.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdAdd.Location = New System.Drawing.Point(0, 0)
        Me.cmdAdd.Name = "cmdAdd"
        Me.cmdAdd.Size = New System.Drawing.Size(54, 34)
        Me.cmdAdd.TabIndex = 0
        Me.cmdAdd.TabStop = False
        Me.cmdAdd.Text = "&Add"
        '
        'cmdLast
        '
        Me.cmdLast.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdLast.Location = New System.Drawing.Point(794, 0)
        Me.cmdLast.Name = "cmdLast"
        Me.cmdLast.Size = New System.Drawing.Size(38, 34)
        Me.cmdLast.TabIndex = 13
        Me.cmdLast.TabStop = False
        Me.cmdLast.Text = ">>|"
        '
        'cmdPrv
        '
        Me.cmdPrv.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdPrv.Location = New System.Drawing.Point(720, 0)
        Me.cmdPrv.Name = "cmdPrv"
        Me.cmdPrv.Size = New System.Drawing.Size(38, 34)
        Me.cmdPrv.TabIndex = 11
        Me.cmdPrv.TabStop = False
        Me.cmdPrv.Text = "<"
        '
        'cmdNext
        '
        Me.cmdNext.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdNext.Location = New System.Drawing.Point(757, 0)
        Me.cmdNext.Name = "cmdNext"
        Me.cmdNext.Size = New System.Drawing.Size(38, 34)
        Me.cmdNext.TabIndex = 12
        Me.cmdNext.TabStop = False
        Me.cmdNext.Text = ">"
        '
        'cmdFind
        '
        Me.cmdFind.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdFind.Location = New System.Drawing.Point(206, 0)
        Me.cmdFind.Name = "cmdFind"
        Me.cmdFind.Size = New System.Drawing.Size(54, 34)
        Me.cmdFind.TabIndex = 4
        Me.cmdFind.TabStop = False
        Me.cmdFind.Text = "&Find"
        '
        'cmdCopy
        '
        Me.cmdCopy.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdCopy.Location = New System.Drawing.Point(159, 0)
        Me.cmdCopy.Name = "cmdCopy"
        Me.cmdCopy.Size = New System.Drawing.Size(48, 34)
        Me.cmdCopy.TabIndex = 3
        Me.cmdCopy.TabStop = False
        Me.cmdCopy.Text = "&Copy"
        '
        'cmdClear
        '
        Me.cmdClear.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdClear.Location = New System.Drawing.Point(259, 0)
        Me.cmdClear.Name = "cmdClear"
        Me.cmdClear.Size = New System.Drawing.Size(53, 34)
        Me.cmdClear.TabIndex = 5
        Me.cmdClear.TabStop = False
        Me.cmdClear.Text = "Cl&ear"
        '
        'cmdExit
        '
        Me.cmdExit.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdExit.Location = New System.Drawing.Point(838, 0)
        Me.cmdExit.Name = "cmdExit"
        Me.cmdExit.Size = New System.Drawing.Size(54, 34)
        Me.cmdExit.TabIndex = 14
        Me.cmdExit.TabStop = False
        Me.cmdExit.Text = "E&xit"
        '
        'cmdDelRow
        '
        Me.cmdDelRow.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdDelRow.Location = New System.Drawing.Point(615, 0)
        Me.cmdDelRow.Name = "cmdDelRow"
        Me.cmdDelRow.Size = New System.Drawing.Size(53, 34)
        Me.cmdDelRow.TabIndex = 9
        Me.cmdDelRow.TabStop = False
        Me.cmdDelRow.Text = "Del Ro&w"
        '
        'cmdFirst
        '
        Me.cmdFirst.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdFirst.Location = New System.Drawing.Point(683, 0)
        Me.cmdFirst.Name = "cmdFirst"
        Me.cmdFirst.Size = New System.Drawing.Size(38, 34)
        Me.cmdFirst.TabIndex = 10
        Me.cmdFirst.TabStop = False
        Me.cmdFirst.Text = "|<<"
        '
        'cmdInsRow
        '
        Me.cmdInsRow.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdInsRow.Location = New System.Drawing.Point(562, 0)
        Me.cmdInsRow.Name = "cmdInsRow"
        Me.cmdInsRow.Size = New System.Drawing.Size(54, 34)
        Me.cmdInsRow.TabIndex = 7
        Me.cmdInsRow.TabStop = False
        Me.cmdInsRow.Text = "I&ns Row"
        '
        'CmdLookup
        '
        Me.CmdLookup.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.CmdLookup.Location = New System.Drawing.Point(446, 0)
        Me.CmdLookup.Name = "CmdLookup"
        Me.CmdLookup.Size = New System.Drawing.Size(54, 34)
        Me.CmdLookup.TabIndex = 8
        Me.CmdLookup.TabStop = False
        Me.CmdLookup.Text = "Look &up"
        Me.CmdLookup.UseVisualStyleBackColor = True
        '
        'cmdSearch
        '
        Me.cmdSearch.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdSearch.Location = New System.Drawing.Point(323, 0)
        Me.cmdSearch.Name = "cmdSearch"
        Me.cmdSearch.Size = New System.Drawing.Size(61, 34)
        Me.cmdSearch.TabIndex = 6
        Me.cmdSearch.TabStop = False
        Me.cmdSearch.Text = "Searc&h"
        '
        'cmdspecial
        '
        Me.cmdspecial.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdspecial.Location = New System.Drawing.Point(383, 0)
        Me.cmdspecial.Name = "cmdspecial"
        Me.cmdspecial.Size = New System.Drawing.Size(64, 34)
        Me.cmdspecial.TabIndex = 49
        Me.cmdspecial.TabStop = False
        Me.cmdspecial.Text = "S&pecial Search"
        '
        'cmdbrowlist
        '
        Me.cmdbrowlist.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmdbrowlist.Location = New System.Drawing.Point(499, 0)
        Me.cmdbrowlist.Name = "cmdbrowlist"
        Me.cmdbrowlist.Size = New System.Drawing.Size(52, 34)
        Me.cmdbrowlist.TabIndex = 50
        Me.cmdbrowlist.TabStop = False
        Me.cmdbrowlist.Text = "&Browse List"
        Me.cmdbrowlist.UseVisualStyleBackColor = True
        '
        'StatusBar
        '
        Me.StatusBar.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.StatusBar.Location = New System.Drawing.Point(0, 510)
        Me.StatusBar.Name = "StatusBar"
        Me.StatusBar.Panels.AddRange(New System.Windows.Forms.StatusBarPanel() {Me.StatusBarPanel1, Me.StatusBarPanel2})
        Me.StatusBar.ShowPanels = True
        Me.StatusBar.Size = New System.Drawing.Size(892, 26)
        Me.StatusBar.TabIndex = 276
        '
        'StatusBarPanel1
        '
        Me.StatusBarPanel1.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.StatusBarPanel1.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring
        Me.StatusBarPanel1.Name = "StatusBarPanel1"
        Me.StatusBarPanel1.Width = 437
        '
        'StatusBarPanel2
        '
        Me.StatusBarPanel2.Alignment = System.Windows.Forms.HorizontalAlignment.Right
        Me.StatusBarPanel2.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring
        Me.StatusBarPanel2.Name = "StatusBarPanel2"
        Me.StatusBarPanel2.Width = 437
        '
        'TextBox11
        '
        Me.TextBox11.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.TextBox11.Location = New System.Drawing.Point(112, 40)
        Me.TextBox11.MaxLength = 20
        Me.TextBox11.Name = "TextBox11"
        Me.TextBox11.Size = New System.Drawing.Size(105, 20)
        Me.TextBox11.TabIndex = 281
        '
        'ComboBox6
        '
        Me.ComboBox6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.ComboBox6.FormattingEnabled = True
        Me.ComboBox6.Location = New System.Drawing.Point(112, 15)
        Me.ComboBox6.Name = "ComboBox6"
        Me.ComboBox6.Size = New System.Drawing.Size(683, 21)
        Me.ComboBox6.TabIndex = 271
        '
        'RichTextBox3
        '
        Me.RichTextBox3.Location = New System.Drawing.Point(112, 64)
        Me.RichTextBox3.Name = "RichTextBox3"
        Me.RichTextBox3.Size = New System.Drawing.Size(683, 58)
        Me.RichTextBox3.TabIndex = 17
        Me.RichTextBox3.Text = ""
        '
        'frmApproveReject
        '
        Me.frmApproveReject.Controls.Add(Me.chkGen)
        Me.frmApproveReject.Controls.Add(Me.chkDelete)
        Me.frmApproveReject.Controls.Add(Me.chkNew)
        Me.frmApproveReject.ForeColor = System.Drawing.Color.Black
        Me.frmApproveReject.Location = New System.Drawing.Point(486, 39)
        Me.frmApproveReject.Name = "frmApproveReject"
        Me.frmApproveReject.Size = New System.Drawing.Size(287, 48)
        Me.frmApproveReject.TabIndex = 371
        Me.frmApproveReject.TabStop = False
        Me.frmApproveReject.Text = "Status"
        '
        'chkGen
        '
        Me.chkGen.AutoSize = True
        Me.chkGen.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.chkGen.Location = New System.Drawing.Point(169, 20)
        Me.chkGen.Name = "chkGen"
        Me.chkGen.Size = New System.Drawing.Size(92, 17)
        Me.chkGen.TabIndex = 544
        Me.chkGen.Text = "Generate only"
        Me.chkGen.UseVisualStyleBackColor = True
        '
        'chkDelete
        '
        Me.chkDelete.AutoSize = True
        Me.chkDelete.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.chkDelete.Location = New System.Drawing.Point(89, 20)
        Me.chkDelete.Name = "chkDelete"
        Me.chkDelete.Size = New System.Drawing.Size(79, 17)
        Me.chkDelete.TabIndex = 542
        Me.chkDelete.Text = "Delete only"
        Me.chkDelete.UseVisualStyleBackColor = True
        '
        'chkNew
        '
        Me.chkNew.AutoSize = True
        Me.chkNew.Checked = True
        Me.chkNew.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkNew.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.chkNew.Location = New System.Drawing.Point(6, 20)
        Me.chkNew.Name = "chkNew"
        Me.chkNew.Size = New System.Drawing.Size(70, 17)
        Me.chkNew.TabIndex = 543
        Me.chkNew.Text = "New only"
        Me.chkNew.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.Label1.Location = New System.Drawing.Point(87, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(33, 13)
        Me.Label1.TabIndex = 383
        Me.Label1.Text = "From:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.Label4.Location = New System.Drawing.Point(262, 40)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(23, 13)
        Me.Label4.TabIndex = 384
        Me.Label4.Text = "To:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.Label2.Location = New System.Drawing.Point(11, 65)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(67, 13)
        Me.Label2.TabIndex = 381
        Me.Label2.Text = "Upload Date"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.Label3.Location = New System.Drawing.Point(12, 40)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(59, 13)
        Me.Label3.TabIndex = 382
        Me.Label3.Text = "ZS PO No."
        '
        'txtPOFm
        '
        Me.txtPOFm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtPOFm.Location = New System.Drawing.Point(133, 40)
        Me.txtPOFm.MaxLength = 10
        Me.txtPOFm.Name = "txtPOFm"
        Me.txtPOFm.Size = New System.Drawing.Size(114, 20)
        Me.txtPOFm.TabIndex = 0
        '
        'txtUplDatTo
        '
        Me.txtUplDatTo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtUplDatTo.Location = New System.Drawing.Point(291, 65)
        Me.txtUplDatTo.MaxLength = 10
        Me.txtUplDatTo.Name = "txtUplDatTo"
        Me.txtUplDatTo.Size = New System.Drawing.Size(114, 20)
        Me.txtUplDatTo.TabIndex = 3
        '
        'lblIssDat
        '
        Me.lblIssDat.AutoSize = True
        Me.lblIssDat.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.lblIssDat.Location = New System.Drawing.Point(87, 65)
        Me.lblIssDat.Name = "lblIssDat"
        Me.lblIssDat.Size = New System.Drawing.Size(33, 13)
        Me.lblIssDat.TabIndex = 378
        Me.lblIssDat.Text = "From:"
        '
        'txtUplDatFm
        '
        Me.txtUplDatFm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtUplDatFm.Location = New System.Drawing.Point(133, 65)
        Me.txtUplDatFm.MaxLength = 10
        Me.txtUplDatFm.Name = "txtUplDatFm"
        Me.txtUplDatFm.Size = New System.Drawing.Size(114, 20)
        Me.txtUplDatFm.TabIndex = 2
        '
        'lblRvsDat
        '
        Me.lblRvsDat.AutoSize = True
        Me.lblRvsDat.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.lblRvsDat.Location = New System.Drawing.Point(262, 65)
        Me.lblRvsDat.Name = "lblRvsDat"
        Me.lblRvsDat.Size = New System.Drawing.Size(23, 13)
        Me.lblRvsDat.TabIndex = 379
        Me.lblRvsDat.Text = "To:"
        '
        'txtPOTo
        '
        Me.txtPOTo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtPOTo.Location = New System.Drawing.Point(291, 40)
        Me.txtPOTo.MaxLength = 10
        Me.txtPOTo.Name = "txtPOTo"
        Me.txtPOTo.Size = New System.Drawing.Size(114, 20)
        Me.txtPOTo.TabIndex = 1
        '
        'SSTab1
        '
        Me.SSTab1.Controls.Add(Me.tpMPO00001_1)
        Me.SSTab1.Controls.Add(Me.tpMPO00001_2)
        Me.SSTab1.DrawMode = System.Windows.Forms.TabDrawMode.OwnerDrawFixed
        Me.SSTab1.Location = New System.Drawing.Point(0, 92)
        Me.SSTab1.Name = "SSTab1"
        Me.SSTab1.SelectedIndex = 0
        Me.SSTab1.Size = New System.Drawing.Size(993, 415)
        Me.SSTab1.TabIndex = 44
        '
        'tpMPO00001_1
        '
        Me.tpMPO00001_1.Controls.Add(Me.grdMPOHdr)
        Me.tpMPO00001_1.Location = New System.Drawing.Point(4, 24)
        Me.tpMPO00001_1.Name = "tpMPO00001_1"
        Me.tpMPO00001_1.Padding = New System.Windows.Forms.Padding(3)
        Me.tpMPO00001_1.Size = New System.Drawing.Size(985, 387)
        Me.tpMPO00001_1.TabIndex = 0
        Me.tpMPO00001_1.Text = "(1) Header"
        Me.tpMPO00001_1.UseVisualStyleBackColor = True
        '
        'grdMPOHdr
        '
        Me.grdMPOHdr.AllowUserToAddRows = False
        Me.grdMPOHdr.AllowUserToDeleteRows = False
        Me.grdMPOHdr.ColumnHeadersHeight = 20
        Me.grdMPOHdr.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.grdMPOHdr.Location = New System.Drawing.Point(6, 6)
        Me.grdMPOHdr.Name = "grdMPOHdr"
        Me.grdMPOHdr.RowHeadersWidth = 20
        Me.grdMPOHdr.RowTemplate.DefaultCellStyle.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.grdMPOHdr.RowTemplate.Height = 16
        Me.grdMPOHdr.Size = New System.Drawing.Size(866, 376)
        Me.grdMPOHdr.TabIndex = 368
        '
        'tpMPO00001_2
        '
        Me.tpMPO00001_2.Controls.Add(Me.GroupBox3)
        Me.tpMPO00001_2.Controls.Add(Me.txtmodvol)
        Me.tpMPO00001_2.Controls.Add(Me.txtCusVen)
        Me.tpMPO00001_2.Controls.Add(Me.txtVenNo)
        Me.tpMPO00001_2.Controls.Add(Me.cboPCPrc)
        Me.tpMPO00001_2.Controls.Add(Me.optSearch1)
        Me.tpMPO00001_2.Controls.Add(Me.optSearch0)
        Me.tpMPO00001_2.Controls.Add(Me.Label30)
        Me.tpMPO00001_2.Controls.Add(Me.txtPurOrd)
        Me.tpMPO00001_2.Controls.Add(Me.txtVol)
        Me.tpMPO00001_2.Controls.Add(Me.txtColCde)
        Me.tpMPO00001_2.Controls.Add(Me.Label39)
        Me.tpMPO00001_2.Controls.Add(Me.txtMtrCtn)
        Me.tpMPO00001_2.Controls.Add(Me.Label40)
        Me.tpMPO00001_2.Controls.Add(Me.Label56)
        Me.tpMPO00001_2.Controls.Add(Me.GroupBox5)
        Me.tpMPO00001_2.Controls.Add(Me.optCtrSiz3)
        Me.tpMPO00001_2.Controls.Add(Me.optCtrSiz4)
        Me.tpMPO00001_2.Controls.Add(Me.optCtrSiz0)
        Me.tpMPO00001_2.Controls.Add(Me.optCtrSiz1)
        Me.tpMPO00001_2.Controls.Add(Me.optCtrSiz2)
        Me.tpMPO00001_2.Controls.Add(Me.txtCustUM)
        Me.tpMPO00001_2.Controls.Add(Me.Label27)
        Me.tpMPO00001_2.Location = New System.Drawing.Point(4, 22)
        Me.tpMPO00001_2.Name = "tpMPO00001_2"
        Me.tpMPO00001_2.Padding = New System.Windows.Forms.Padding(3)
        Me.tpMPO00001_2.Size = New System.Drawing.Size(985, 389)
        Me.tpMPO00001_2.TabIndex = 1
        Me.tpMPO00001_2.Text = "(2) Details"
        Me.tpMPO00001_2.UseVisualStyleBackColor = True
        '
        'GroupBox3
        '
        Me.GroupBox3.Controls.Add(Me.grdMPODtl)
        Me.GroupBox3.Location = New System.Drawing.Point(8, -4)
        Me.GroupBox3.Name = "GroupBox3"
        Me.GroupBox3.Size = New System.Drawing.Size(871, 391)
        Me.GroupBox3.TabIndex = 363
        Me.GroupBox3.TabStop = False
        '
        'grdMPODtl
        '
        Me.grdMPODtl.AllowUserToAddRows = False
        Me.grdMPODtl.AllowUserToDeleteRows = False
        Me.grdMPODtl.ColumnHeadersHeight = 20
        Me.grdMPODtl.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.grdMPODtl.Location = New System.Drawing.Point(7, 13)
        Me.grdMPODtl.Name = "grdMPODtl"
        Me.grdMPODtl.RowHeadersWidth = 20
        Me.grdMPODtl.RowTemplate.DefaultCellStyle.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.grdMPODtl.RowTemplate.Height = 16
        Me.grdMPODtl.Size = New System.Drawing.Size(854, 376)
        Me.grdMPODtl.TabIndex = 369
        '
        'txtmodvol
        '
        Me.txtmodvol.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtmodvol.Location = New System.Drawing.Point(143, 620)
        Me.txtmodvol.MaxLength = 10
        Me.txtmodvol.Name = "txtmodvol"
        Me.txtmodvol.Size = New System.Drawing.Size(61, 20)
        Me.txtmodvol.TabIndex = 362
        Me.txtmodvol.Visible = False
        '
        'txtCusVen
        '
        Me.txtCusVen.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtCusVen.Location = New System.Drawing.Point(473, 613)
        Me.txtCusVen.MaxLength = 10
        Me.txtCusVen.Name = "txtCusVen"
        Me.txtCusVen.Size = New System.Drawing.Size(34, 20)
        Me.txtCusVen.TabIndex = 350
        Me.txtCusVen.Visible = False
        '
        'txtVenNo
        '
        Me.txtVenNo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtVenNo.Location = New System.Drawing.Point(439, 613)
        Me.txtVenNo.MaxLength = 10
        Me.txtVenNo.Name = "txtVenNo"
        Me.txtVenNo.Size = New System.Drawing.Size(34, 20)
        Me.txtVenNo.TabIndex = 349
        Me.txtVenNo.Visible = False
        '
        'cboPCPrc
        '
        Me.cboPCPrc.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cboPCPrc.FormattingEnabled = True
        Me.cboPCPrc.Location = New System.Drawing.Point(638, 609)
        Me.cboPCPrc.Name = "cboPCPrc"
        Me.cboPCPrc.Size = New System.Drawing.Size(75, 21)
        Me.cboPCPrc.TabIndex = 348
        Me.cboPCPrc.Visible = False
        '
        'optSearch1
        '
        Me.optSearch1.AutoSize = True
        Me.optSearch1.Location = New System.Drawing.Point(832, 669)
        Me.optSearch1.Name = "optSearch1"
        Me.optSearch1.Size = New System.Drawing.Size(51, 19)
        Me.optSearch1.TabIndex = 328
        Me.optSearch1.Text = "S/C #"
        Me.optSearch1.UseVisualStyleBackColor = True
        Me.optSearch1.Visible = False
        '
        'optSearch0
        '
        Me.optSearch0.AutoSize = True
        Me.optSearch0.Location = New System.Drawing.Point(694, 671)
        Me.optSearch0.Name = "optSearch0"
        Me.optSearch0.Size = New System.Drawing.Size(63, 19)
        Me.optSearch0.TabIndex = 327
        Me.optSearch0.Text = "Job No."
        Me.optSearch0.UseVisualStyleBackColor = True
        Me.optSearch0.Visible = False
        '
        'Label30
        '
        Me.Label30.AutoSize = True
        Me.Label30.Location = New System.Drawing.Point(588, 672)
        Me.Label30.Name = "Label30"
        Me.Label30.Size = New System.Drawing.Size(57, 15)
        Me.Label30.TabIndex = 326
        Me.Label30.Text = "Search by:"
        Me.Label30.Visible = False
        '
        'txtPurOrd
        '
        Me.txtPurOrd.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtPurOrd.Location = New System.Drawing.Point(374, 613)
        Me.txtPurOrd.MaxLength = 10
        Me.txtPurOrd.Name = "txtPurOrd"
        Me.txtPurOrd.Size = New System.Drawing.Size(26, 20)
        Me.txtPurOrd.TabIndex = 347
        Me.txtPurOrd.Visible = False
        '
        'txtVol
        '
        Me.txtVol.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtVol.Location = New System.Drawing.Point(64, 623)
        Me.txtVol.MaxLength = 10
        Me.txtVol.Name = "txtVol"
        Me.txtVol.Size = New System.Drawing.Size(61, 20)
        Me.txtVol.TabIndex = 316
        Me.txtVol.Visible = False
        '
        'txtColCde
        '
        Me.txtColCde.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtColCde.Location = New System.Drawing.Point(336, 613)
        Me.txtColCde.MaxLength = 10
        Me.txtColCde.Name = "txtColCde"
        Me.txtColCde.Size = New System.Drawing.Size(41, 20)
        Me.txtColCde.TabIndex = 346
        Me.txtColCde.Visible = False
        '
        'Label39
        '
        Me.Label39.AutoSize = True
        Me.Label39.Location = New System.Drawing.Point(16, 601)
        Me.Label39.Name = "Label39"
        Me.Label39.Size = New System.Drawing.Size(42, 15)
        Me.Label39.TabIndex = 315
        Me.Label39.Text = "Master"
        Me.Label39.Visible = False
        '
        'txtMtrCtn
        '
        Me.txtMtrCtn.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtMtrCtn.Location = New System.Drawing.Point(64, 601)
        Me.txtMtrCtn.MaxLength = 10
        Me.txtMtrCtn.Name = "txtMtrCtn"
        Me.txtMtrCtn.Size = New System.Drawing.Size(61, 20)
        Me.txtMtrCtn.TabIndex = 314
        Me.txtMtrCtn.Visible = False
        '
        'Label40
        '
        Me.Label40.AutoSize = True
        Me.Label40.Location = New System.Drawing.Point(18, 622)
        Me.Label40.Name = "Label40"
        Me.Label40.Size = New System.Drawing.Size(35, 15)
        Me.Label40.TabIndex = 317
        Me.Label40.Text = "CBM"
        Me.Label40.Visible = False
        '
        'Label56
        '
        Me.Label56.AutoSize = True
        Me.Label56.Location = New System.Drawing.Point(531, 615)
        Me.Label56.Name = "Label56"
        Me.Label56.Size = New System.Drawing.Size(80, 15)
        Me.Label56.TabIndex = 339
        Me.Label56.Text = "Unit Price / PC"
        Me.Label56.Visible = False
        '
        'GroupBox5
        '
        Me.GroupBox5.Controls.Add(Me.txtCmpRmk)
        Me.GroupBox5.Controls.Add(Me.cboCus2No_dtl)
        Me.GroupBox5.Controls.Add(Me.Label52)
        Me.GroupBox5.Controls.Add(Me.txtTtlNetD)
        Me.GroupBox5.Controls.Add(Me.Label88)
        Me.GroupBox5.Controls.Add(Me.txtNetWgt)
        Me.GroupBox5.Controls.Add(Me.Label49)
        Me.GroupBox5.Controls.Add(Me.Label50)
        Me.GroupBox5.Controls.Add(Me.txtTtlGrsD)
        Me.GroupBox5.Controls.Add(Me.txtGrsWgt)
        Me.GroupBox5.Controls.Add(Me.txtItmTyp)
        Me.GroupBox5.Controls.Add(Me.Label48)
        Me.GroupBox5.Controls.Add(Me.Label47)
        Me.GroupBox5.Controls.Add(Me.Label45)
        Me.GroupBox5.Controls.Add(Me.txtTtlVolD)
        Me.GroupBox5.Controls.Add(Me.txtOrdSeq)
        Me.GroupBox5.Controls.Add(Me.Label46)
        Me.GroupBox5.Controls.Add(Me.txtActVol)
        Me.GroupBox5.Controls.Add(Me.txtMtrhcm)
        Me.GroupBox5.Controls.Add(Me.txtMtrwcm)
        Me.GroupBox5.Controls.Add(Me.txtMtrdcm)
        Me.GroupBox5.Controls.Add(Me.Label44)
        Me.GroupBox5.Controls.Add(Me.txtOrgQty)
        Me.GroupBox5.Controls.Add(Me.Label43)
        Me.GroupBox5.Controls.Add(Me.Label42)
        Me.GroupBox5.Controls.Add(Me.Label41)
        Me.GroupBox5.Controls.Add(Me.Label37)
        Me.GroupBox5.Controls.Add(Me.txtInrCtn)
        Me.GroupBox5.Controls.Add(Me.Label38)
        Me.GroupBox5.Controls.Add(Me.txtUntCde)
        Me.GroupBox5.Controls.Add(Me.cboPckRmk)
        Me.GroupBox5.Controls.Add(Me.txtColDsc)
        Me.GroupBox5.Controls.Add(Me.txtOutQty)
        Me.GroupBox5.Controls.Add(Me.Label29)
        Me.GroupBox5.Controls.Add(Me.txtPrcTrm)
        Me.GroupBox5.Controls.Add(Me.txtPayTrm)
        Me.GroupBox5.Location = New System.Drawing.Point(125, 604)
        Me.GroupBox5.Name = "GroupBox5"
        Me.GroupBox5.Size = New System.Drawing.Size(435, 151)
        Me.GroupBox5.TabIndex = 294
        Me.GroupBox5.TabStop = False
        Me.GroupBox5.Visible = False
        '
        'txtCmpRmk
        '
        Me.txtCmpRmk.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtCmpRmk.Location = New System.Drawing.Point(298, 135)
        Me.txtCmpRmk.MaxLength = 10
        Me.txtCmpRmk.Name = "txtCmpRmk"
        Me.txtCmpRmk.Size = New System.Drawing.Size(71, 20)
        Me.txtCmpRmk.TabIndex = 340
        '
        'cboCus2No_dtl
        '
        Me.cboCus2No_dtl.FormattingEnabled = True
        Me.cboCus2No_dtl.Location = New System.Drawing.Point(130, -6)
        Me.cboCus2No_dtl.Name = "cboCus2No_dtl"
        Me.cboCus2No_dtl.Size = New System.Drawing.Size(23, 23)
        Me.cboCus2No_dtl.TabIndex = 359
        Me.cboCus2No_dtl.Visible = False
        '
        'Label52
        '
        Me.Label52.AutoSize = True
        Me.Label52.Location = New System.Drawing.Point(202, 135)
        Me.Label52.Name = "Label52"
        Me.Label52.Size = New System.Drawing.Size(72, 15)
        Me.Label52.TabIndex = 338
        Me.Label52.Text = "W.M. Comp."
        '
        'txtTtlNetD
        '
        Me.txtTtlNetD.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtTtlNetD.Location = New System.Drawing.Point(298, 111)
        Me.txtTtlNetD.MaxLength = 10
        Me.txtTtlNetD.Name = "txtTtlNetD"
        Me.txtTtlNetD.Size = New System.Drawing.Size(71, 20)
        Me.txtTtlNetD.TabIndex = 336
        '
        'Label88
        '
        Me.Label88.AutoSize = True
        Me.Label88.Location = New System.Drawing.Point(103, 2)
        Me.Label88.Name = "Label88"
        Me.Label88.Size = New System.Drawing.Size(47, 15)
        Me.Label88.TabIndex = 351
        Me.Label88.Text = "Consol#"
        Me.Label88.Visible = False
        '
        'txtNetWgt
        '
        Me.txtNetWgt.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtNetWgt.Location = New System.Drawing.Point(123, 111)
        Me.txtNetWgt.MaxLength = 10
        Me.txtNetWgt.Name = "txtNetWgt"
        Me.txtNetWgt.Size = New System.Drawing.Size(71, 20)
        Me.txtNetWgt.TabIndex = 335
        '
        'Label49
        '
        Me.Label49.AutoSize = True
        Me.Label49.Location = New System.Drawing.Point(202, 111)
        Me.Label49.Name = "Label49"
        Me.Label49.Size = New System.Drawing.Size(78, 15)
        Me.Label49.TabIndex = 334
        Me.Label49.Text = "TTL NW (Kg)"
        '
        'Label50
        '
        Me.Label50.AutoSize = True
        Me.Label50.BackColor = System.Drawing.Color.Transparent
        Me.Label50.ForeColor = System.Drawing.Color.Green
        Me.Label50.Location = New System.Drawing.Point(6, 111)
        Me.Label50.Name = "Label50"
        Me.Label50.Size = New System.Drawing.Size(100, 15)
        Me.Label50.TabIndex = 333
        Me.Label50.Text = "Net Wgt/Ctn : (Kg)"
        '
        'txtTtlGrsD
        '
        Me.txtTtlGrsD.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtTtlGrsD.Location = New System.Drawing.Point(298, 87)
        Me.txtTtlGrsD.MaxLength = 10
        Me.txtTtlGrsD.Name = "txtTtlGrsD"
        Me.txtTtlGrsD.Size = New System.Drawing.Size(71, 20)
        Me.txtTtlGrsD.TabIndex = 332
        '
        'txtGrsWgt
        '
        Me.txtGrsWgt.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtGrsWgt.Location = New System.Drawing.Point(123, 87)
        Me.txtGrsWgt.MaxLength = 10
        Me.txtGrsWgt.Name = "txtGrsWgt"
        Me.txtGrsWgt.Size = New System.Drawing.Size(71, 20)
        Me.txtGrsWgt.TabIndex = 331
        '
        'txtItmTyp
        '
        Me.txtItmTyp.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtItmTyp.Location = New System.Drawing.Point(95, -5)
        Me.txtItmTyp.MaxLength = 10
        Me.txtItmTyp.Name = "txtItmTyp"
        Me.txtItmTyp.Size = New System.Drawing.Size(29, 20)
        Me.txtItmTyp.TabIndex = 343
        Me.txtItmTyp.Visible = False
        '
        'Label48
        '
        Me.Label48.AutoSize = True
        Me.Label48.Location = New System.Drawing.Point(202, 87)
        Me.Label48.Name = "Label48"
        Me.Label48.Size = New System.Drawing.Size(78, 15)
        Me.Label48.TabIndex = 330
        Me.Label48.Text = "TTL GW (Kg)"
        '
        'Label47
        '
        Me.Label47.AutoSize = True
        Me.Label47.BackColor = System.Drawing.Color.Transparent
        Me.Label47.ForeColor = System.Drawing.Color.Green
        Me.Label47.Location = New System.Drawing.Point(6, 87)
        Me.Label47.Name = "Label47"
        Me.Label47.Size = New System.Drawing.Size(111, 15)
        Me.Label47.TabIndex = 329
        Me.Label47.Text = "Gross Wgt/Ctn : (Kg)"
        '
        'Label45
        '
        Me.Label45.AutoSize = True
        Me.Label45.Location = New System.Drawing.Point(202, 63)
        Me.Label45.Name = "Label45"
        Me.Label45.Size = New System.Drawing.Size(73, 15)
        Me.Label45.TabIndex = 328
        Me.Label45.Text = "TTL CBM    "
        '
        'txtTtlVolD
        '
        Me.txtTtlVolD.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtTtlVolD.Location = New System.Drawing.Point(298, 63)
        Me.txtTtlVolD.MaxLength = 10
        Me.txtTtlVolD.Name = "txtTtlVolD"
        Me.txtTtlVolD.Size = New System.Drawing.Size(71, 20)
        Me.txtTtlVolD.TabIndex = 327
        '
        'txtOrdSeq
        '
        Me.txtOrdSeq.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtOrdSeq.Location = New System.Drawing.Point(70, -5)
        Me.txtOrdSeq.MaxLength = 10
        Me.txtOrdSeq.Name = "txtOrdSeq"
        Me.txtOrdSeq.Size = New System.Drawing.Size(19, 20)
        Me.txtOrdSeq.TabIndex = 342
        Me.txtOrdSeq.Visible = False
        '
        'Label46
        '
        Me.Label46.AutoSize = True
        Me.Label46.Location = New System.Drawing.Point(6, 63)
        Me.Label46.Name = "Label46"
        Me.Label46.Size = New System.Drawing.Size(91, 15)
        Me.Label46.TabIndex = 326
        Me.Label46.Text = "Actual CBM/Ctn"
        '
        'txtActVol
        '
        Me.txtActVol.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtActVol.Location = New System.Drawing.Point(123, 63)
        Me.txtActVol.MaxLength = 10
        Me.txtActVol.Name = "txtActVol"
        Me.txtActVol.Size = New System.Drawing.Size(71, 20)
        Me.txtActVol.TabIndex = 325
        '
        'txtMtrhcm
        '
        Me.txtMtrhcm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtMtrhcm.Location = New System.Drawing.Point(332, 37)
        Me.txtMtrhcm.MaxLength = 10
        Me.txtMtrhcm.Name = "txtMtrhcm"
        Me.txtMtrhcm.Size = New System.Drawing.Size(61, 20)
        Me.txtMtrhcm.TabIndex = 324
        '
        'txtMtrwcm
        '
        Me.txtMtrwcm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtMtrwcm.Location = New System.Drawing.Point(218, 36)
        Me.txtMtrwcm.MaxLength = 10
        Me.txtMtrwcm.Name = "txtMtrwcm"
        Me.txtMtrwcm.Size = New System.Drawing.Size(61, 20)
        Me.txtMtrwcm.TabIndex = 323
        '
        'txtMtrdcm
        '
        Me.txtMtrdcm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtMtrdcm.Location = New System.Drawing.Point(123, 36)
        Me.txtMtrdcm.MaxLength = 10
        Me.txtMtrdcm.Name = "txtMtrdcm"
        Me.txtMtrdcm.Size = New System.Drawing.Size(61, 20)
        Me.txtMtrdcm.TabIndex = 322
        '
        'Label44
        '
        Me.Label44.AutoSize = True
        Me.Label44.BackColor = System.Drawing.Color.Transparent
        Me.Label44.ForeColor = System.Drawing.Color.Green
        Me.Label44.Location = New System.Drawing.Point(311, 41)
        Me.Label44.Name = "Label44"
        Me.Label44.Size = New System.Drawing.Size(16, 15)
        Me.Label44.TabIndex = 321
        Me.Label44.Text = "H"
        '
        'txtOrgQty
        '
        Me.txtOrgQty.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtOrgQty.Location = New System.Drawing.Point(65, -22)
        Me.txtOrgQty.MaxLength = 10
        Me.txtOrgQty.Name = "txtOrgQty"
        Me.txtOrgQty.Size = New System.Drawing.Size(10, 20)
        Me.txtOrgQty.TabIndex = 348
        Me.txtOrgQty.Visible = False
        '
        'Label43
        '
        Me.Label43.AutoSize = True
        Me.Label43.BackColor = System.Drawing.Color.Transparent
        Me.Label43.ForeColor = System.Drawing.Color.Green
        Me.Label43.Location = New System.Drawing.Point(194, 41)
        Me.Label43.Name = "Label43"
        Me.Label43.Size = New System.Drawing.Size(18, 15)
        Me.Label43.TabIndex = 320
        Me.Label43.Text = "W"
        '
        'Label42
        '
        Me.Label42.AutoSize = True
        Me.Label42.BackColor = System.Drawing.Color.Transparent
        Me.Label42.ForeColor = System.Drawing.Color.Green
        Me.Label42.Location = New System.Drawing.Point(103, 41)
        Me.Label42.Name = "Label42"
        Me.Label42.Size = New System.Drawing.Size(14, 15)
        Me.Label42.TabIndex = 319
        Me.Label42.Text = "L"
        '
        'Label41
        '
        Me.Label41.AutoSize = True
        Me.Label41.BackColor = System.Drawing.Color.Transparent
        Me.Label41.ForeColor = System.Drawing.Color.Green
        Me.Label41.Location = New System.Drawing.Point(6, 34)
        Me.Label41.Name = "Label41"
        Me.Label41.Size = New System.Drawing.Size(84, 15)
        Me.Label41.TabIndex = 318
        Me.Label41.Text = "Dimension (cm)"
        '
        'Label37
        '
        Me.Label37.AutoSize = True
        Me.Label37.Location = New System.Drawing.Point(85, 11)
        Me.Label37.Name = "Label37"
        Me.Label37.Size = New System.Drawing.Size(32, 15)
        Me.Label37.TabIndex = 313
        Me.Label37.Text = "Inner"
        '
        'txtInrCtn
        '
        Me.txtInrCtn.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtInrCtn.Location = New System.Drawing.Point(123, 11)
        Me.txtInrCtn.MaxLength = 10
        Me.txtInrCtn.Name = "txtInrCtn"
        Me.txtInrCtn.Size = New System.Drawing.Size(61, 20)
        Me.txtInrCtn.TabIndex = 312
        '
        'Label38
        '
        Me.Label38.AutoSize = True
        Me.Label38.Location = New System.Drawing.Point(6, 11)
        Me.Label38.Name = "Label38"
        Me.Label38.Size = New System.Drawing.Size(31, 15)
        Me.Label38.TabIndex = 311
        Me.Label38.Text = "U/M"
        '
        'txtUntCde
        '
        Me.txtUntCde.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtUntCde.Location = New System.Drawing.Point(43, 11)
        Me.txtUntCde.MaxLength = 10
        Me.txtUntCde.Name = "txtUntCde"
        Me.txtUntCde.Size = New System.Drawing.Size(36, 20)
        Me.txtUntCde.TabIndex = 310
        '
        'cboPckRmk
        '
        Me.cboPckRmk.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cboPckRmk.FormattingEnabled = True
        Me.cboPckRmk.Location = New System.Drawing.Point(-25, 0)
        Me.cboPckRmk.Name = "cboPckRmk"
        Me.cboPckRmk.Size = New System.Drawing.Size(268, 21)
        Me.cboPckRmk.TabIndex = 301
        Me.cboPckRmk.Visible = False
        '
        'txtColDsc
        '
        Me.txtColDsc.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtColDsc.Location = New System.Drawing.Point(-13, -22)
        Me.txtColDsc.MaxLength = 10
        Me.txtColDsc.Name = "txtColDsc"
        Me.txtColDsc.Size = New System.Drawing.Size(17, 20)
        Me.txtColDsc.TabIndex = 312
        Me.txtColDsc.Visible = False
        '
        'txtOutQty
        '
        Me.txtOutQty.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtOutQty.Location = New System.Drawing.Point(49, -22)
        Me.txtOutQty.MaxLength = 10
        Me.txtOutQty.Name = "txtOutQty"
        Me.txtOutQty.Size = New System.Drawing.Size(10, 20)
        Me.txtOutQty.TabIndex = 347
        Me.txtOutQty.Visible = False
        '
        'Label29
        '
        Me.Label29.AutoSize = True
        Me.Label29.Location = New System.Drawing.Point(-70, -20)
        Me.Label29.Name = "Label29"
        Me.Label29.Size = New System.Drawing.Size(51, 15)
        Me.Label29.TabIndex = 324
        Me.Label29.Text = "Col Desc"
        Me.Label29.Visible = False
        '
        'txtPrcTrm
        '
        Me.txtPrcTrm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtPrcTrm.Location = New System.Drawing.Point(15, -23)
        Me.txtPrcTrm.MaxLength = 10
        Me.txtPrcTrm.Name = "txtPrcTrm"
        Me.txtPrcTrm.Size = New System.Drawing.Size(10, 20)
        Me.txtPrcTrm.TabIndex = 345
        Me.txtPrcTrm.Visible = False
        '
        'txtPayTrm
        '
        Me.txtPayTrm.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtPayTrm.Location = New System.Drawing.Point(33, -22)
        Me.txtPayTrm.MaxLength = 10
        Me.txtPayTrm.Name = "txtPayTrm"
        Me.txtPayTrm.Size = New System.Drawing.Size(10, 20)
        Me.txtPayTrm.TabIndex = 346
        Me.txtPayTrm.Visible = False
        '
        'optCtrSiz3
        '
        Me.optCtrSiz3.AutoSize = True
        Me.optCtrSiz3.Location = New System.Drawing.Point(288, 674)
        Me.optCtrSiz3.Name = "optCtrSiz3"
        Me.optCtrSiz3.Size = New System.Drawing.Size(39, 19)
        Me.optCtrSiz3.TabIndex = 294
        Me.optCtrSiz3.Text = "45'"
        Me.optCtrSiz3.UseVisualStyleBackColor = True
        '
        'optCtrSiz4
        '
        Me.optCtrSiz4.AutoSize = True
        Me.optCtrSiz4.Checked = True
        Me.optCtrSiz4.Location = New System.Drawing.Point(92, 658)
        Me.optCtrSiz4.Name = "optCtrSiz4"
        Me.optCtrSiz4.Size = New System.Drawing.Size(46, 19)
        Me.optCtrSiz4.TabIndex = 289
        Me.optCtrSiz4.TabStop = True
        Me.optCtrSiz4.Text = "CFS"
        Me.optCtrSiz4.UseVisualStyleBackColor = True
        '
        'optCtrSiz0
        '
        Me.optCtrSiz0.AutoSize = True
        Me.optCtrSiz0.Location = New System.Drawing.Point(93, 674)
        Me.optCtrSiz0.Name = "optCtrSiz0"
        Me.optCtrSiz0.Size = New System.Drawing.Size(39, 19)
        Me.optCtrSiz0.TabIndex = 291
        Me.optCtrSiz0.Text = "20'"
        Me.optCtrSiz0.UseVisualStyleBackColor = True
        '
        'optCtrSiz1
        '
        Me.optCtrSiz1.AutoSize = True
        Me.optCtrSiz1.Location = New System.Drawing.Point(144, 674)
        Me.optCtrSiz1.Name = "optCtrSiz1"
        Me.optCtrSiz1.Size = New System.Drawing.Size(67, 19)
        Me.optCtrSiz1.TabIndex = 292
        Me.optCtrSiz1.Text = "40' (8.5')"
        Me.optCtrSiz1.UseVisualStyleBackColor = True
        '
        'optCtrSiz2
        '
        Me.optCtrSiz2.AutoSize = True
        Me.optCtrSiz2.Location = New System.Drawing.Point(217, 674)
        Me.optCtrSiz2.Name = "optCtrSiz2"
        Me.optCtrSiz2.Size = New System.Drawing.Size(65, 19)
        Me.optCtrSiz2.TabIndex = 293
        Me.optCtrSiz2.Text = "40'(HQ)"
        Me.optCtrSiz2.UseVisualStyleBackColor = True
        '
        'txtCustUM
        '
        Me.txtCustUM.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.txtCustUM.Location = New System.Drawing.Point(934, 530)
        Me.txtCustUM.MaxLength = 6
        Me.txtCustUM.Name = "txtCustUM"
        Me.txtCustUM.Size = New System.Drawing.Size(51, 20)
        Me.txtCustUM.TabIndex = 311
        Me.txtCustUM.Visible = False
        '
        'Label27
        '
        Me.Label27.AutoSize = True
        Me.Label27.Location = New System.Drawing.Point(880, 530)
        Me.Label27.Name = "Label27"
        Me.Label27.Size = New System.Drawing.Size(51, 15)
        Me.Label27.TabIndex = 323
        Me.Label27.Text = "Cust Um"
        Me.Label27.Visible = False
        '
        'MPO00001
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 14)
        Me.ClientSize = New System.Drawing.Size(892, 536)
        Me.Controls.Add(Me.frmApproveReject)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txtPOFm)
        Me.Controls.Add(Me.txtUplDatTo)
        Me.Controls.Add(Me.lblIssDat)
        Me.Controls.Add(Me.txtUplDatFm)
        Me.Controls.Add(Me.lblRvsDat)
        Me.Controls.Add(Me.txtPOTo)
        Me.Controls.Add(Me.StatusBar)
        Me.Controls.Add(Me.SSTab1)
        Me.Controls.Add(Me.cmdDelete)
        Me.Controls.Add(Me.cmdbrowlist)
        Me.Controls.Add(Me.cmdspecial)
        Me.Controls.Add(Me.cmdSave)
        Me.Controls.Add(Me.CmdLookup)
        Me.Controls.Add(Me.cmdAdd)
        Me.Controls.Add(Me.cmdFind)
        Me.Controls.Add(Me.cmdLast)
        Me.Controls.Add(Me.cmdPrv)
        Me.Controls.Add(Me.cmdCopy)
        Me.Controls.Add(Me.cmdNext)
        Me.Controls.Add(Me.cmdClear)
        Me.Controls.Add(Me.cmdExit)
        Me.Controls.Add(Me.cmdFirst)
        Me.Controls.Add(Me.cmdDelRow)
        Me.Controls.Add(Me.cmdInsRow)
        Me.Controls.Add(Me.cmdSearch)
        Me.Font = New System.Drawing.Font("Times New Roman", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "MPO00001"
        Me.Text = "MPO00001 - Manufacturing Purchase Order Search"
        CType(Me.StatusBarPanel1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.StatusBarPanel2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmApproveReject.ResumeLayout(False)
        Me.frmApproveReject.PerformLayout()
        Me.SSTab1.ResumeLayout(False)
        Me.tpMPO00001_1.ResumeLayout(False)
        CType(Me.grdMPOHdr, System.ComponentModel.ISupportInitialize).EndInit()
        Me.tpMPO00001_2.ResumeLayout(False)
        Me.tpMPO00001_2.PerformLayout()
        Me.GroupBox3.ResumeLayout(False)
        CType(Me.grdMPODtl, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox5.ResumeLayout(False)
        Me.GroupBox5.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
#End Region
    Private Sub chkDelete_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkDelete.Click
        If Me.chkDelete.Checked = True Then
            Me.chkNew.Checked = False
            Me.chkGen.Checked = False
        End If
    End Sub

    Private Sub chkGen_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkGen.Click
        If Me.chkGen.Checked = True Then
            Me.chkNew.Checked = False
            Me.chkDelete.Checked = False
        End If
    End Sub
    Private Sub chkNew_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkNew.Click
        If Me.chkNew.Checked = True Then
            Me.chkDelete.Checked = False
            Me.chkGen.Checked = False
        End If
    End Sub

    '*** Folder 2

    Private Sub cmdClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdClear.Click
        Call setStatus("Clear")

    End Sub


    Private Sub cmdFindClick()
        Dim strStatus As String

        '    If Trim(Me.txtFilNamFm.Text) = "" And Trim(Me.txtFilNamTo.Text) <> "" Then
        '       Me.txtFilNamFm.Text = Me.txtFilNamTo.Text
        '    ElseIf Trim(Me.txtFilNamFm.Text) <> "" And Trim(Me.txtFilNamTo.Text) = "" Then
        '        Me.txtFilNamTo.Text = Me.txtFilNamFm.Text
        '    ElseIf Trim(Me.txtFilNamFm.Text) > Trim(Me.txtFilNamTo.Text) Then
        '        MsgBox "File Name From > File Name To!"
        '        Me.txtFilNamFm.SetFocus
        '        Exit Sub
        '    End If

        If Trim(Me.txtPOFm.Text) = "" And Trim(Me.txtPOTo.Text) <> "" Then
            Me.txtPOFm.Text = Me.txtPOTo.Text
        ElseIf Trim(Me.txtPOFm.Text) <> "" And Trim(Me.txtPOTo.Text) = "" Then
            Me.txtPOTo.Text = Me.txtPOFm.Text
        ElseIf Trim(Me.txtPOFm.Text) > Trim(Me.txtPOTo.Text) Then
            MsgBox("PO No From > PO No To!")
            Me.txtPOFm.Focus()
            Exit Sub
        End If

        If Me.txtUplDatFm.Text <> "  /  /    " Then
            If IsDate(Me.txtUplDatFm.Text) = False Then
                MsgBox("Invalid Date Value!")
                Me.txtUplDatFm.Focus()
                Exit Sub
            End If
        End If

        If Me.txtUplDatTo.Text <> "  /  /    " Then
            If IsDate(Me.txtUplDatTo.Text) = False Then
                MsgBox("Invalid Date Value!")
                Me.txtUplDatTo.Focus()
                Exit Sub
            End If
        End If


        '    If Me.txtUplDatFm.Text = "  /  /    " And Me.txtUplDatTo.Text <> "  /  /    " Then
        '        Me.txtUplDatFm.Text = Me.txtUplDatTo.Text
        '    ElseIf Me.txtUplDatFm.Text <> "  /  /    " And Me.txtUplDatTo.Text = "  /  /    " Then
        '        Me.txtUplDatTo.Text = Me.txtUplDatFm.Text
        '    ElseIf Me.txtUplDatFm.Text > Me.txtUplDatTo.Text Then
        '        MsgBox "Upload Date From > Date To!"
        '        Me.txtUplDatFm.SetFocus
        '        Exit Sub
        '    End If

        'Lester Wu 2006-01-06

        If Me.txtUplDatFm.Text = "  /  /    " And Me.txtUplDatTo.Text <> "  /  /    " Then
            Me.txtUplDatFm.Text = Me.txtUplDatTo.Text
        ElseIf Me.txtUplDatFm.Text <> "  /  /    " And Me.txtUplDatTo.Text = "  /  /    " Then
            Me.txtUplDatTo.Text = Me.txtUplDatFm.Text
        End If

        If Me.txtUplDatFm.Text <> "  /  /    " And Me.txtUplDatTo.Text <> "  /  /    " Then
            If CDate(Me.txtUplDatFm.Text) > CDate(Me.txtUplDatTo.Text) Then
                MsgBox("Upload Date From > Date To!")
                Me.txtUplDatFm.Focus()
                Exit Sub
            End If
        End If

        Dim rs As New DataSet
        Dim S As String
        Dim i As Integer

        Dim dtFm As String
        Dim dtTo As String



        If Me.txtUplDatFm.Text = "  /  /    " Then
            dtFm = "01/01/1900"
        Else
            dtFm = Trim(Me.txtUplDatFm.Text)
        End If

        If Me.txtUplDatTo.Text = "  /  /    " Then
            dtTo = "01/01/1900"
        Else
            dtTo = Trim(Me.txtUplDatTo.Text)
        End If

        strStatus = ""
        If Me.chkNew.Checked = True Then strStatus = strStatus & "N"
        If Me.chkDelete.Checked = True Then strStatus = strStatus & "D"
        If Me.chkGen.Checked = True Then strStatus = strStatus & "G"

        'If Me.chkOld.checked = true Then strStatus = strStatus & "O"

        'If Me.chkReject.checked = true Then strStatus = strStatus & "E"


        '*** query Primary Customer
        '    S = "��MPOXLSHDR','S" & "','" & strStatus & "','" & _
        '        Trim(Me.txtPOFm.Text) & "','" & Trim(Me.txtPOTo.Text) & "','" & _
        '        Trim(Me.txtFilNamFm.Text) & "','" & Trim(Me.txtFilNamTo.Text) & "','" & _
        '        dtFm & "','" & dtTo & "'"
        '        "��MPOXLSDTL','S" & "','" & strStatus & "','" & _
        '        Trim(Me.txtPOFm.Text) & "','" & Trim(Me.txtPOTo.Text) & "','" & _
        '        Trim(Me.txtFilNamFm.Text) & "','" & Trim(Me.txtFilNamTo.Text) & "','" & _
        '        dtFm & "','" & dtTo

        Cursor = Cursors.WaitCursor

        gspStr = "sp_select_MPOXLSHDR '" & "','" & strStatus & "','" & _
            Trim(Me.txtPOFm.Text) & "','" & Trim(Me.txtPOTo.Text) & "','" & _
            dtFm & "','" & dtTo & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_MPOXLSHDR, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading txtShpNoKeyPress sp_select_MMPORDHDR :" & rtnStr)
            Exit Sub
        End If
        If rs_MPOXLSHDR.Tables("result").Rows.Count = 0 Then
            Cursor = Cursors.Default
            MsgBox("Record not found!")
            Exit Sub
        End If

        gspStr = "sp_select_MPOXLSDTL '" & "','" & strStatus & "','" & _
    Trim(Me.txtPOFm.Text) & "','" & Trim(Me.txtPOTo.Text) & "','" & _
    dtFm & "','" & dtTo & "'"
        rtnLong = execute_SQLStatement(gspStr, rs_MPOXLSDTL, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading txtShpNoKeyPress sp_select_MMPORDHDR :" & rtnStr)
            Exit Sub
        End If


        Cursor = Cursors.Default
        rs_MPOXLSDTL_Blk = rs_MPOXLSDTL.Copy

        Me.SSTab1.SelectedIndex = 0
        Call DisplayHeader()
        Call setStatus("Update")

    End Sub

    Private Sub MPO00001_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

    End Sub

    Private Sub MPO00001_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '                Call AccessRight(Me.Name) '*** For Access Right use, added by Tommy on 5 Oct 2001

        '#If useMTS Then
        '        Set objBSGate = CreateObject("ucpBS_Gate.clsBSGate", serverName)
        '#Else
        '        objBSGate = CreateObject("ucpBS_Gate.clsBSGate")
        '#End If

        Cursor = Cursors.WaitCursor
        '        gsConnStr = getConnectionString()
        Me.KeyPreview = True
        Call setStatus("Init")
        Call Formstartup(Me.Name)   'Set the form Sartup position
        Cursor = Cursors.Default



    End Sub

    Private Sub setStatus(ByVal Mode As String)
        'Private Sub setStatus(Mode As String, Optional rs As New DataSet)

        Select Case Mode
            Case "Init"
                cmdAdd.Enabled = False
                cmdSave.Enabled = False
                cmdDelete.Enabled = False
                cmdCopy.Enabled = False
                cmdFind.Enabled = True
                cmdClear.Enabled = False

                cmdSearch.Enabled = False
                cmdspecial.Enabled = False
                CmdLookup.Enabled = False
                cmdbrowlist.Enabled = False

                cmdInsRow.Enabled = False
                cmdDelRow.Enabled = False

                cmdFirst.Enabled = False
                cmdLast.Enabled = False
                cmdNext.Enabled = False
                cmdPrv.Enabled = False

                cmdExit.Enabled = True

                '        Me.txtFilNamFm.Enabled = True
                '        Me.txtFilNamTo.Enabled = True
                Me.txtPOFm.Enabled = True
                Me.txtPOTo.Enabled = True
                Me.txtUplDatFm.Enabled = True
                Me.txtUplDatTo.Enabled = True

                '        Me.txtFilNamFm.Text = ""
                '        Me.txtFilNamTo.Text = ""
                Me.txtPOFm.Text = ""
                Me.txtPOTo.Text = ""
                Me.txtUplDatFm.Text = Format(Now, "MM/dd/yyyy")
                Me.txtUplDatTo.Text = Format(Now, "MM/dd/yyyy")

                Me.chkNew.Enabled = True
                Me.chkDelete.Enabled = True
                Me.chkGen.Enabled = True
                'Me.chkOld.Enabled = True
                'Me.chkReject.Enabled = True

                Me.chkNew.Checked = True
                Me.chkDelete.Checked = False
                'Me.chkOld.checked = false
                'Me.chkReject.checked = false

                Me.SSTab1.Enabled = False

            Case "Update"

                Me.cmdFind.Enabled = False
                Me.cmdClear.Enabled = True

                '        Me.txtFilNamFm.Enabled = False
                '        Me.txtFilNamTo.Enabled = False
                Me.txtPOFm.Enabled = False
                Me.txtPOTo.Enabled = False
                Me.txtUplDatFm.Enabled = False
                Me.txtUplDatTo.Enabled = False

                Me.chkNew.Enabled = False
                Me.chkDelete.Enabled = False
                Me.chkGen.Enabled = False
                'Me.chkOld.Enabled = False
                'Me.chkReject.Enabled = False

                Me.SSTab1.Enabled = True

            Case "Clear"

                grdMPOHdr.DataSource = Nothing
                grdMPODtl.DataSource = Nothing

                rs_MPOXLSHDR = Nothing
                rs_MPOXLSDTL = Nothing

                cmdFind.Enabled = True
                cmdClear.Enabled = False

                '        Me.txtFilNamFm.Enabled = True
                '        Me.txtFilNamTo.Enabled = True
                Me.txtPOFm.Enabled = True
                Me.txtPOTo.Enabled = True
                Me.txtUplDatFm.Enabled = True
                Me.txtUplDatTo.Enabled = True

                '        Me.txtFilNamFm.Text = ""
                '        Me.txtFilNamTo.Text = ""
                Me.txtPOFm.Text = ""
                Me.txtPOTo.Text = ""
                'Me.txtUplDatFm.Text = Format(Now, "MM/dd/yyyy")
                'Me.txtUplDatTo.Text = Format(Now, "MM/dd/yyyy")

                Me.chkNew.Enabled = True
                Me.chkDelete.Enabled = True
                Me.chkGen.Enabled = True
                'Me.chkOld.Enabled = True
                'Me.chkReject.Enabled = True

                Me.chkNew.Checked = True
                Me.chkDelete.Checked = False
                'Me.chkOld.checked = false
                'Me.chkReject.checked = false

            Case "Exit"
                grdMPOHdr.DataSource = Nothing
                grdMPODtl.DataSource = Nothing

                rs_MPOXLSHDR = Nothing
                rs_MPOXLSDTL = Nothing

                Call setStatus("Clear")
        End Select
    End Sub

    Private Sub SetStatusBar(ByVal Mode As String)

        If Me.SSTab1.SelectedIndex = 0 Then
            If Not rs_MPOXLSHDR Is Nothing Then
                If Not rs_MPOXLSHDR.Tables("result") Is Nothing Then
                    If rs_MPOXLSHDR.Tables("result").Rows.Count > 0 Then
                        Me.StatusBar.Panels(1).Text = rs_MPOXLSHDR.Tables("result").Rows(0)("Mxh_UpdUsr") & "  " & Format(rs_MPOXLSHDR.Tables("result").Rows(0)("Mxh_CreDat"), "MM/dd/yyyy") & "  " & Format(rs_MPOXLSHDR.Tables("result").Rows(0)("Mxh_UpdDat"), "MM/dd/yyyy")
                    End If
                End If
            ElseIf Me.SSTab1.SelectedIndex = 1 Then
                If Not rs_MPOXLSDTL Is Nothing Then
                    If rs_MPOXLSDTL.Tables("result").DefaultView.Count > 0 Then
                        'tempzz
                        Me.StatusBar.Panels(1).Text = rs_MPOXLSDTL.Tables("result").DefaultView(0)("Mxd_UpdUsr") & "  " & Format(rs_MPOXLSDTL.Tables("result").DefaultView(0)("Mxd_CreDat"), "MM/dd/yyyy") & "  " & Format(rs_MPOXLSDTL.Tables("result").DefaultView(0)("Mxd_UpdDat"), "MM/dd/yyyy")
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub DisplayHeader()
        Dim intCol As Integer

        Me.grdMPOHdr.DataSource = Nothing
        Me.grdMPODtl.DataSource = Nothing

        If rs_MPOXLSHDR Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result") Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result").Rows.Count <= 0 Then Exit Sub

        rs_MPOXLSHDR.Tables("result").DefaultView.Sort = "Mxh_PONo,Mxh_VenNo,Mxh_ImpFty,Mxh_ShpPlc,Mxh_Curr,Mxh_CreDat"

        Me.grdMPOHdr.DataSource = rs_MPOXLSHDR.Tables("result")
        With Me.grdMPOHdr
            intCol = 0
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            colPONo = intCol
            .Columns(intCol).HeaderText = "PO # (ZS)"
            .Columns(intCol).Width = 100

            intCol = intCol + 1
            colVenNo = intCol
            .Columns(intCol).HeaderText = "Vendor #"
            .Columns(intCol).Width = 80

            intCol = intCol + 1
            colVen = intCol
            .Columns(intCol).HeaderText = "Vendor"
            .Columns(intCol).Width = 240

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Import Vendor"
            .Columns(intCol).Width = 120

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Ship To Dest."
            .Columns(intCol).Width = 120

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Currency"
            .Columns(intCol).Width = 80

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Remark"
            .Columns(intCol).Width = 300

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "MPO Flag (HK)"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "MPO # (HK)"
            .Columns(intCol).Width = 140

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Exception Msg"
            .Columns(intCol).Width = 300

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Update Flag (ZS)"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "PO Date"
            .Columns(intCol).Width = 100

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "PO User"
            .Columns(intCol).Width = 100

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Confirm User"
            .Columns(intCol).Width = 100

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Confirm Date"
            .Columns(intCol).Width = 100

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Contact Person"
            .Columns(intCol).Width = 120

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "File Name"
            .Columns(intCol).Width = 200

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "seq #"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

        End With
        Call SetStatusBar("Update")
    End Sub

    Private Sub DisplayDetail()

        Dim intCol As Integer

        If rs_MPOXLSHDR Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result") Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result").Rows.Count <= 0 Then Exit Sub

        If rs_MPOXLSDTL.Tables("result") Is Nothing Then
            'temp
            Me.grdMPODtl.DataSource = rs_MPOXLSDTL_Blk.Tables("result")
        Else
            rs_MPOXLSDTL.Tables("result").DefaultView.RowFilter = "Mxd_PONo = '" & rs_MPOXLSHDR.Tables("result").Rows(0)("Mxh_PONo") & "'"
            If rs_MPOXLSDTL.Tables("result").DefaultView.Count <= 0 Then
                Me.grdMPODtl.DataSource = rs_MPOXLSDTL_Blk.Tables("result")
            Else
                Me.grdMPODtl.DataSource = rs_MPOXLSDTL.Tables("result").DefaultView
            End If
        End If

        With Me.grdMPODtl

            intCol = 0
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            colPONO_dtl = intCol
            .Columns(intCol).HeaderText = "PO # (ZS)"
            .Columns(intCol).Width = 1200 / 13

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Seq (ZS)"
            .Columns(intCol).Width = 800 / 13

            '         intCol = intCol + 1
            '        .Columns(intCol).HeaderText = "Ship Date"
            '        .Columns(intCol).width = 1200 / 13

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Item No"
            .Columns(intCol).Width = 1200 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Item Name"
            .Columns(intCol).Width = 2000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Item Description"
            .Columns(intCol).Width = 3000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Color"
            .Columns(intCol).Width = 1000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "UM"
            .Columns(intCol).Width = 800 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Qty"
            .Columns(intCol).Width = 800 / 13


            intCol = intCol + 1
            .Columns(intCol).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight

            .Columns(intCol).HeaderText = "Unit Price"
            .Columns(intCol).Width = 1000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Packing Method"
            .Columns(intCol).Width = 1500 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Department"
            .Columns(intCol).Width = 1200 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Request #"
            .Columns(intCol).Width = 1200 / 13

            intCol = intCol + 1
            colShipDate_dtl = intCol
            .Columns(intCol).HeaderText = "Ship Date"
            .Columns(intCol).Width = 1200 / 13

            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Production #"
            .Columns(intCol).Width = 1200 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Remark"
            .Columns(intCol).Width = 2000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Exception"
            .Columns(intCol).Width = 2000 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Update Flag (ZS)"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "MPO Flag (HK)"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "MPO # (HK)"
            .Columns(intCol).Width = 1600 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "File Name"
            .Columns(intCol).Width = 1800 / 13


            intCol = intCol + 1
            .Columns(intCol).HeaderText = "Record Seq"
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False


            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False

            intCol = intCol + 1
            .Columns(intCol).Width = 0
            .Columns(intCol).Visible = False



        End With

        Call SetStatusBar("Update")

    End Sub

    Private Sub grdMPODtl_HeadClick(ByVal ColIndex As Integer)

        If rs_MPOXLSDTL Is Nothing Then Exit Sub
        If rs_MPOXLSDTL.Tables("result") Is Nothing Then Exit Sub
        If rs_MPOXLSDTL.Tables("result").Rows.Count <= 0 Then Exit Sub
        If ColIndex = colPONO_dtl Then
            rs_MPOXLSDTL.Tables("result").DefaultView.Sort = "Mxd_PONo,Mxd_POSeq"
        ElseIf ColIndex = colShipDate_dtl Then
            rs_MPOXLSDTL.Tables("result").DefaultView.Sort = "Mxd_ShpDat,Mxd_ItmNo,Mxd_ItmNam,Mxd_ItmDsc"
        End If
    End Sub
    Private Sub grdMPODtl_CurrentCellChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdMPODtl.CurrentCellChanged
        Call SetStatusBar("Update")
    End Sub

    Private Sub grdMPODtl_RowColChange(ByVal LastRow As Object, ByVal LastCol As Integer)
    End Sub

    Private Sub grdMPOHdr_HeadClick(ByVal ColIndex As Integer)
        If rs_MPOXLSHDR Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result") Is Nothing Then Exit Sub
        If rs_MPOXLSHDR.Tables("result").Rows.Count <= 0 Then Exit Sub
        If ColIndex = colVenNo Then
            rs_MPOXLSHDR.Tables("result").DefaultView.Sort = "Mxh_VenNo,Mxh_ImpFty,Mxh_ShpPlc,Mxh_Curr,Mxh_PONo,Mxh_CreDat"
        ElseIf ColIndex = colPONo Then
            rs_MPOXLSHDR.Tables("result").DefaultView.Sort = "Mxh_PONo,Mxh_VenNo,Mxh_ImpFty,Mxh_ShpPlc,Mxh_Curr,Mxh_CreDat"
        ElseIf ColIndex = colVen Then
            rs_MPOXLSHDR.Tables("result").DefaultView.Sort = "Vbi_VenNam,Mxh_ImpFty,Mxh_ShpPlc,Mxh_Curr,Mxh_PONo,Mxh_CreDat"
        End If
    End Sub
    Private Sub grdMPOHdr_CurrentCellChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdMPOHdr.CurrentCellChanged
        Call SetStatusBar("Update")
    End Sub

    Private Sub grdMPOHdr_RowColChange(ByVal LastRow As Object, ByVal LastCol As Integer)
    End Sub


    Private Sub SSTab1_Click(ByVal PreviousTab As Integer)

        If SSTab1.SelectedIndex = 1 Then
            Call DisplayDetail()
        End If
    End Sub
    'Private Sub txtFilNamFm_GotFocus()
    '    Me.txtFilNamFm.selectionStart = 0
    '    Me.txtFilNamFm.SelectionLength = Len(Me.txtFilNamFm.Text)
    'End Sub


    'Private Sub txtFilNamFm_LostFocus()
    '    Me.txtFilNamTo.Text = Me.txtFilNamFm.Text
    'End Sub


    'Private Sub txtFilNamTo_GotFocus()
    '    Me.txtFilNamTo.selectionStart = 0
    '    Me.txtFilNamTo.SelectionLength = Len(Me.txtFilNamTo.Text)
    'End Sub

    Private Sub txtPOFm_GotFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOFm.GotFocus
        Me.txtPOFm.SelectionStart = 0
        Me.txtPOFm.SelectionLength = Len(Me.txtPOFm.Text)
    End Sub

    Private Sub txtPOFm_GotFocus()
    End Sub

    Private Sub txtPOFm_LostFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOFm.LostFocus
        Me.txtPOTo.Text = Me.txtPOFm.Text
    End Sub

    Private Sub txtPOTo_GotFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPOTo.GotFocus
        Me.txtPOTo.SelectionStart = 0
        Me.txtPOTo.SelectionLength = Len(Me.txtPOTo.Text)
    End Sub


    Private Sub txtUplDatFm_GotFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUplDatFm.GotFocus
        Me.txtUplDatFm.SelectionStart = 0
        Me.txtUplDatFm.SelectionLength = Me.txtUplDatFm.MaxLength

    End Sub
    Private Sub txtUplDatFm_LostFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUplDatFm.LostFocus
        If Me.txtUplDatFm.Text = "  /  /    " Then Exit Sub
        If IsDate(Me.txtUplDatFm.Text) = False Then
            MsgBox("Invalid Date Value!")
            Me.txtUplDatFm.Focus()
            Exit Sub
        End If

    End Sub
    Private Sub txtUplDatTo_GotFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUplDatTo.GotFocus
        Me.txtUplDatTo.SelectionStart = 0
        Me.txtUplDatTo.SelectionLength = Me.txtUplDatTo.MaxLength
    End Sub

    Private Sub txtUplDatTo_LostFocus1(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUplDatTo.LostFocus
        If Me.txtUplDatTo.Text = "  /  /    " Then Exit Sub
        If IsDate(Me.txtUplDatTo.Text) = False Then
            MsgBox("Invalid Date Value!")
            Me.txtUplDatTo.Focus()
            Exit Sub
        End If
    End Sub

    Private Sub cmdFind_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdFind.Click
        Call cmdFindClick()
    End Sub


    Private Sub chkDelete_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkDelete.CheckedChanged

    End Sub

    Private Sub chkGen_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkGen.CheckedChanged

    End Sub

    Private Sub chkNew_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkNew.CheckedChanged

    End Sub

    Private Sub cmdExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdExit.Click
        Me.Close()
    End Sub

    Private Sub grdMPOHdr_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdMPOHdr.CellContentClick

    End Sub

    Private Sub grdMPODtl_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdMPODtl.CellContentClick

    End Sub



    Private Sub txtPOFm_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOFm.TextChanged

    End Sub


    Private Sub txtPOTo_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPOTo.TextChanged

    End Sub



    Private Sub txtUplDatFm_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtUplDatFm.TextChanged

    End Sub


    Private Sub txtUplDatTo_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtUplDatTo.TextChanged

    End Sub

    Private Sub SSTab1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SSTab1.SelectedIndexChanged
        If SSTab1.SelectedIndex = 1 Then
            Call DisplayDetail()
        End If

    End Sub
End Class














































































