Imports System.Data.SqlClient

Public Class Gerencia

    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"

    Public Shared Property listaFuncionarios As New List(Of Funcionarios)



    Private Sub Artistas_DB_Load(sender As Object, e As EventArgs) Handles MyBase.Load
            CMD = New SqlCommand
            CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
            CMD.Connection = CN
            'por referencia
            CMD.CommandText = "
            Select Nome, NIF, Num_Funcionario, Data_Nascimento, Endereco
            From (ArtGallery.Funcionario JOIN ArtGallery.Pessoa ON ArtGallery.Funcionario.NIF_Funcionario = ArtGallery.Pessoa.NIF)"

            Dim RDR As SqlDataReader
            CN.Open()
            RDR = CMD.ExecuteReader()


        While RDR.Read
            Dim Funcionario As New Funcionarios

            Funcionario.nif = RDR.Item("NIF")
            Funcionario.numfunc = RDR.Item("Num_Funcionario")
            Funcionario.Name = RDR.Item("Nome")
            Funcionario.dataNasci = RDR.Item("Data_Nascimento")
            Funcionario.address = RDR.Item("Endereco")


            listaFuncionarios.Add(Funcionario)
            ListBox1.Items.Add(Funcionario)

        End While

            RDR.Close()
            CN.Close()


        End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim back = New Form1
        back.Show()
        Me.Hide()
    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click

    End Sub

    Private Sub Add_Click(sender As Object, e As EventArgs) Handles Add.Click

        Dim addfunc = New AddFunc
        addfunc.Show()
        Me.Hide()

    End Sub

    Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
        Dim index = ListBox1.SelectedIndex
        Dim P = listaFuncionarios(index)


    End Sub
End Class