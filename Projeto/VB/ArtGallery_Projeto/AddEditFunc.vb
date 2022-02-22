Imports System.Data.SqlClient


Public Class AddEditFunc

    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"
    Dim currentArtist As Integer
    Dim adding As Boolean


    Private Sub AddEditFunc_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        Dim func As New Funcionarios

        CN = New SqlConnection("data Source = " + dbServer + " ;" +
                               "initial Catalog = " + dbName + ";" +
                               "uid = " + username + ";" +
                               "password = " + userPass)
        CN.Open()

    End Sub

    Private Sub bttnAdd_Click(sender As Object, e As EventArgs) Handles bttnAdd.Click

        Dim CMD As New SqlCommand
        CMD.Connection = CN
        CMD.CommandText = "[InsertUpdateFunc]"
        CMD.CommandType = CommandType.StoredProcedure

        CMD.Parameters.Add(New SqlParameter("@Nome", TextBox1.Text))
        CMD.Parameters.Add(New SqlParameter("@NIF", TextBox2.Text))
        CMD.Parameters.Add(New SqlParameter("@NumFunc", TextBox3.Text))
        CMD.Parameters.Add(New SqlParameter("@Endereco", TextBox4.Text))
        CMD.Parameters.Add(New SqlParameter("@Data_Nascimento", TextBox5.Text))

        CN.Open()
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            Throw New Exception("Failed to add employee. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)

        Finally
            MessageBox.Show("Funcionário adicionado!")
            CN.Close()
        End Try
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Gerencia_back = New Gerencia
        Gerencia_back.Show()
        Me.Hide()
    End Sub
End Class