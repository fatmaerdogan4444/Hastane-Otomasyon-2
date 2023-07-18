using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HASTANEeee
{
    public partial class KayıtOl : Form
    {
        public KayıtOl()
        {
            InitializeComponent();
        }
        SqlConnection baglanti = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastaneee;Integrated Security=True");
        string c;
        private void button2_Click(object sender, EventArgs e)
        {
            formlar.formHastaGirişi.Show();
            this.Hide();
        }

        private void KayıtOl_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)//Kayıt Ol
        {
            if (radioButton1.Checked == true)
            {
                c = "Kadın";
            }
            else
            {
                c = "Erkek";
            }


            baglanti.Open();
            string q = "insert hhastalar (TC,adi,soyadi,DogumTarihi,DogumYeri,anneAdi,babaAdi,CepTel,Cinsiyeti,Parola) values (" + textBox1.Text + ",'" + textBox2.Text + "','" + textBox3.Text + "','" + dateTimePicker1.Text + "','" + textBox4.Text + "','" + textBox5.Text + "','" + textBox6.Text + "','" + textBox8.Text + "','" + c + "','" + textBox9.Text + "')";
            SqlCommand komut = new SqlCommand(q, baglanti);
            komut.ExecuteNonQuery();
            MessageBox.Show("Kaydınız Oluşturulmuştur.");
            baglanti.Close();
        }
    }
}
