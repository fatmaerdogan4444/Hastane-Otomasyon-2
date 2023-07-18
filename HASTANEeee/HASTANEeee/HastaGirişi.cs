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
    public partial class HastaGirişi : Form
    {
        public HastaGirişi()
        {
            InitializeComponent();
        }
        SqlConnection connection = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("HastaGiriş", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@TC", textBox1.Text);
            command.Parameters.AddWithValue("@Parola", textBox9.Text);

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
                //MessageBox.Show("Giriş başarılı.");
                formlar.formRandevuAl.Show();
                this.Hide();
            }
            else
            {
                //Console.WriteLine("Giriş başarısız.");
                MessageBox.Show("Kullanıcı adı veya şifre yanlış. Tekrar deneyiniz.");
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            formlar.formKayıtOl.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            formlar.formSayfa.Show();
            this.Hide();    
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

            if (checkBox1.CheckState == CheckState.Checked)
            {
                textBox9.UseSystemPasswordChar = true;
            }
            else if (checkBox1.CheckState == CheckState.Unchecked)
            {
                textBox9.UseSystemPasswordChar = false;
            }
        }

        private void HastaGirişi_Load(object sender, EventArgs e)
        {

        }
    }
}
