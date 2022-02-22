Imports System.Data.SqlClient
Public Class AddFunc
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim NIF As String = TextBox1.Text
        Dim Nome As String = TextBox2.Text
        Dim Endereco As String = TextBox3.Text
        Dim dataNasc As String = TextBox4.Text
        Dim pass As String = TextBox5.Text

        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)

        If ComboBox1.SelectedIndex = 0 Then
            Dim CMD As New SqlCommand

            CMD = New SqlCommand("ArtGallery.InsertUpdateFunc")
            CMD.Connection = CN
            CMD.CommandType = CommandType.StoredProcedure



            CMD.Parameters.Add("@NIF", SqlDbType.Int).Value = CInt(NIF)
            CMD.Parameters.Add("@Nome", SqlDbType.VarChar).Value = Nome
            CMD.Parameters.Add("@Endereco", SqlDbType.VarChar).Value = Endereco
            CMD.Parameters.Add("@Data_Nascimento", SqlDbType.VarChar).Value = dataNasc
            CMD.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass
            CMD.Parameters.Add("@tipoFunc", SqlDbType.Int).Value = 1
            CMD.Parameters.Add("@edit", SqlDbType.Int).Value = 0
            CN.Open()
            Try
                CMD.ExecuteNonQuery()
            Catch ex As Exception
                Throw New Exception("Failed to add contact. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)
            Finally
                MessageBox.Show("Funcionario Adiconado")
                CN.Close()
            End Try
        End If



    End Sub
End Class