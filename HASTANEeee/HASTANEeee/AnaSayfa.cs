using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HASTANEeee
{
    public partial class AnaSayfa : Form
    {
        public AnaSayfa()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e) //Personel Girişi
        {
            formlar.formPersonelGirişi.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e) //Doktor Girişi
        {
            formlar.formDoktorGirişi.Show();
            this.Hide(); 
        }

        private void button3_Click(object sender, EventArgs e) //Randevu Al
        {
            formlar.formHastaGirişi.Show();
            this.Hide();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Application.ExitThread();
        }

        private void AnaSayfa_Load(object sender, EventArgs e)
        {

        }
    }
}
