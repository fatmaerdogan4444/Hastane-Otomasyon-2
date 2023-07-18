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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace HASTANEeee
{
    public partial class PersonelGirişi : Form
    {
        public PersonelGirişi()
        {
            InitializeComponent();
        }
        SqlConnection connection = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");

        private void button1_Click(object sender, EventArgs e) //Giriş Yap
        {
            SqlCommand command = new SqlCommand("PersonelGirişi", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@personelID", textBox1.Text);
            command.Parameters.AddWithValue("@parola", textBox2.Text);

            SqlParameter loginSuccessParam = new SqlParameter("@girişBaşarılı", SqlDbType.Bit);
            loginSuccessParam.Direction = ParameterDirection.Output;
            command.Parameters.Add(loginSuccessParam);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            bool girişBaşarılı = (bool)command.Parameters["@girişBaşarılı"].Value;

            if (girişBaşarılı)
            {
                //Console.WriteLine("Giriş başarılı.");
                formlar.formPersonelGirişEkranı.Show();
                this.Hide();
            }
            else
            {
                //Console.WriteLine("Giriş başarısız.");
                MessageBox.Show("Şifre veya Personel ID yanlış. Tekrar deneyiniz");
            }
        }

        private void button2_Click(object sender, EventArgs e) //Geri
        {
            formlar.formSayfa.Show();
            this.Hide();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox1.CheckState == CheckState.Checked)
            {
                textBox2.UseSystemPasswordChar = true;
                
            }
            else if (checkBox1.CheckState == CheckState.Unchecked)
            {
                textBox2.UseSystemPasswordChar = false;
                
            }
        }

        private void checkBox1_CheckedChanged_1(object sender, EventArgs e)
        {
            if (checkBox1.CheckState == CheckState.Checked)
            {
                textBox2.UseSystemPasswordChar = true;                
            }
            else if (checkBox1.CheckState == CheckState.Unchecked)
            {
                textBox2.UseSystemPasswordChar = false;              
            }
        }

        private void PersonelGirişi_Load(object sender, EventArgs e)
        {

        }
    }
}
