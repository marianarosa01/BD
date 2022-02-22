Imports System.Data.SqlClient

Public Class Pinturas_DB
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"

    Public Shared Property listaPinturas As New List(Of PinturasClass)



    Private Sub Artistas_DB_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN
        'por referencia
        CMD.CommandText = "
            
            SELECT Titulo, Nome AS Artista, Data_Producao, Valor, Descricao, FK_Exposicao_Nome, FK_Artista, Num_sala, Tecnica
            FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista) JOIN ArtGallery.Pintura ON ArtGallery.ObrasDeArtes.Referencia = ArtGallery.Pintura.Referencia"

        Dim RDR As SqlDataReader
        CN.Open()
        RDR = CMD.ExecuteReader()
        ' fazer classe pinturas e alterar este while


        While RDR.Read
            Dim Pinturas As New PinturasClass

            Pinturas.DataProducao = RDR.Item("Data_Producao")
            If IsDBNull(RDR.Item("Valor")) Then
                Pinturas.Valor = Nothing
            Else
                Pinturas.Valor = RDR.Item("Valor")
            End If

            If IsDBNull(RDR.Item("Descricao")) Then
                Pinturas.Descricao = Nothing
            Else
                Pinturas.Descricao = RDR.Item("Descricao")
            End If
            Pinturas.Titulo = RDR.Item("Titulo")
            Pinturas.FKExposicaoNome = RDR.Item("FK_Exposicao_Nome")

            If IsDBNull(RDR.Item("Artista")) Then
                Pinturas.NomeArtista = Nothing
            Else
                Pinturas.NomeArtista = RDR.Item("Artista")
            End If

            Pinturas.NumSala = RDR.Item("Num_sala")
            Pinturas.Tecnica = RDR.Item("Tecnica")

            listaPinturas.Add(Pinturas)
            ListBox1.Items.Add(Pinturas)

        End While

        RDR.Close()
        CN.Close()


    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click

    End Sub


    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click

    End Sub

    Private Sub Label5_Click(sender As Object, e As EventArgs) Handles Label5.Click

    End Sub

    Private Sub Label7_Click(sender As Object, e As EventArgs) Handles Label10.Click

    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged

    End Sub

    Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
        Dim index = ListBox1.SelectedIndex
        Dim P = listaPinturas(index)

        TextBox1.Text = P.Titulo
        TextBox2.Text = P.NomeArtista
        TextBox3.Text = P.DataProducao
        TextBox4.Text = P.Descricao
        TextBox5.Text = P.Valor
        TextBox6.Text = P.Tecnica
        TextBox9.Text = P.FKExposicaoNome
        TextBox10.Text = P.NumSala


    End Sub

    Private Sub Label8_Click(sender As Object, e As EventArgs) Handles Label8.Click

    End Sub

    Private Sub TextBox2_TextChanged(sender As Object, e As EventArgs) Handles TextBox2.TextChanged

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Secretaria_back = New Secretaria
        Secretaria_back.Show()
        Me.Hide()
    End Sub

End Class