﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class IMXLS001
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(IMXLS001))
        Me.txtProcess = New System.Windows.Forms.TextBox
        Me.cmdOK = New System.Windows.Forms.Button
        Me.cmdRefresh = New System.Windows.Forms.Button
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.filSource = New System.Windows.Forms.ListBox
        Me.imgListFolders = New System.Windows.Forms.ImageList(Me.components)
        Me.Label2 = New System.Windows.Forms.Label
        Me.dirSource = New System.Windows.Forms.TreeView
        Me.drvSource = New System.Windows.Forms.ComboBox
        Me.SuspendLayout()
        '
        'txtProcess
        '
        Me.txtProcess.BackColor = System.Drawing.Color.White
        Me.txtProcess.Location = New System.Drawing.Point(13, 208)
        Me.txtProcess.Multiline = True
        Me.txtProcess.Name = "txtProcess"
        Me.txtProcess.ReadOnly = True
        Me.txtProcess.Size = New System.Drawing.Size(559, 119)
        Me.txtProcess.TabIndex = 27
        '
        'cmdOK
        '
        Me.cmdOK.Location = New System.Drawing.Point(497, 179)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.Size = New System.Drawing.Size(75, 23)
        Me.cmdOK.TabIndex = 26
        Me.cmdOK.Text = "&Process"
        Me.cmdOK.UseVisualStyleBackColor = True
        '
        'cmdRefresh
        '
        Me.cmdRefresh.Location = New System.Drawing.Point(416, 179)
        Me.cmdRefresh.Name = "cmdRefresh"
        Me.cmdRefresh.Size = New System.Drawing.Size(75, 23)
        Me.cmdRefresh.TabIndex = 25
        Me.cmdRefresh.Text = "&Refresh"
        Me.cmdRefresh.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.ForeColor = System.Drawing.Color.Red
        Me.Label3.Location = New System.Drawing.Point(10, 184)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(383, 13)
        Me.Label3.TabIndex = 24
        Me.Label3.Text = "Make sure to select the correct Excel File Folder before you PRESS PROCESS."
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(13, 10)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(76, 13)
        Me.Label1.TabIndex = 22
        Me.Label1.Text = "Source Folder "
        '
        'filSource
        '
        Me.filSource.FormattingEnabled = True
        Me.filSource.Location = New System.Drawing.Point(375, 26)
        Me.filSource.Name = "filSource"
        Me.filSource.Size = New System.Drawing.Size(197, 147)
        Me.filSource.TabIndex = 21
        '
        'imgListFolders
        '
        Me.imgListFolders.ImageStream = CType(resources.GetObject("imgListFolders.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.imgListFolders.TransparentColor = System.Drawing.Color.Transparent
        Me.imgListFolders.Images.SetKeyName(0, "closedfolder.png")
        Me.imgListFolders.Images.SetKeyName(1, "openfolder.png")
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(375, 10)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(85, 13)
        Me.Label2.TabIndex = 23
        Me.Label2.Text = "Excel File Listing"
        '
        'dirSource
        '
        Me.dirSource.ImageIndex = 0
        Me.dirSource.ImageList = Me.imgListFolders
        Me.dirSource.Location = New System.Drawing.Point(13, 53)
        Me.dirSource.Name = "dirSource"
        Me.dirSource.SelectedImageIndex = 1
        Me.dirSource.Size = New System.Drawing.Size(356, 120)
        Me.dirSource.TabIndex = 20
        '
        'drvSource
        '
        Me.drvSource.FormattingEnabled = True
        Me.drvSource.Location = New System.Drawing.Point(13, 26)
        Me.drvSource.Name = "drvSource"
        Me.drvSource.Size = New System.Drawing.Size(356, 21)
        Me.drvSource.TabIndex = 19
        '
        'IMXLS001
        '
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit
        Me.ClientSize = New System.Drawing.Size(582, 337)
        Me.Controls.Add(Me.txtProcess)
        Me.Controls.Add(Me.cmdOK)
        Me.Controls.Add(Me.cmdRefresh)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.filSource)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.dirSource)
        Me.Controls.Add(Me.drvSource)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "IMXLS001"
        Me.Text = "IMXLS001 - Item Excel File Upload (Internal & Joint Venture Item)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtProcess As System.Windows.Forms.TextBox
    Friend WithEvents cmdOK As System.Windows.Forms.Button
    Friend WithEvents cmdRefresh As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents filSource As System.Windows.Forms.ListBox
    Friend WithEvents imgListFolders As System.Windows.Forms.ImageList
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents dirSource As System.Windows.Forms.TreeView
    Friend WithEvents drvSource As System.Windows.Forms.ComboBox
End Class
