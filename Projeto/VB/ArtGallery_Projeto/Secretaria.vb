Public Class Secretaria
    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Dim FilmesDB = New Filmes
        FilmesDB.Show()
        Me.Hide()
    End Sub

    Private Sub Secretaria_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub Label2_Click(sender As Object, e As EventArgs) Handles Label2.Click

    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Artistas = New Artistas_DB

        Artistas.Show()
        Me.Hide()
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Dim Pinturas = New Pinturas_DB
        Pinturas.Show()
        Me.Hide()

    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim Esculturas = New Esculturas_DB
        Esculturas.Show()
        Me.Hide()
    End Sub

    Private Sub Button6_Click(sender As Object, e As EventArgs) Handles Button6.Click
        Dim back = New Form1
        back.Show()
        Me.Hide()


    End Sub

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        Dim back = New TicketsStatistic
        back.Show()
        Me.Hide()
    End Sub
End Class