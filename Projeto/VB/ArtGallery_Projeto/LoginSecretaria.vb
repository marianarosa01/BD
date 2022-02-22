Public Class LoginSecretaria
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim numfunc = TextBox1.Text
        Dim pass = TextBox2.Text

        If numfunc = "" Or pass = "" Then
            MessageBox.Show("Please fill all the fields!")
            Return


        ElseIf pass = "portocampeao" Then
            MessageBox.Show("Tente de Novo")
            Return

        Else
            Dim secretaria = New Secretaria
            secretaria.Show()
            Me.Hide()
        End If
    End Sub
End Class