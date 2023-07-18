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
    public partial class DoktorGirişi : Form
    {
        public DoktorGirişi()
        {
            InitializeComponent();
        }
        SqlConnection connection = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");

        private void button3_Click(object sender, EventArgs e)
        {
            formlar.formSayfa.Show();
            this.Hide();
        }

        private void DoktorGirişi_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("DoktorGirişi2", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@doktorID", textBox1.Text);
            command.Parameters.AddWithValue("@Sifre", textBox9.Text);

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
                
                formlar.formDoktorGirişEkranı.Show();
                this.Hide();

            }
            else
            {
                //Console.WriteLine("Giriş başarısız.");
                MessageBox.Show("Kullanıcı adi veya şifre yanlış. Tekrar deneyiniz.");
            }
        }

        private void textBox9_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

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
    }
}
