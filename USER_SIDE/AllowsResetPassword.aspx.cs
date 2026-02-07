using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;

public partial class AllowsResetPassword : Page
{
    private string voterId;
    private readonly string _connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VoterID"] == null)
        {
            Response.Redirect("forgot_password.aspx");
        }
        else
        {
            voterId = Session["VoterID"].ToString();
            if (!IsPostBack)
            {
                LoadSecurityQuestions();
            }
        }
    }

    private void LoadSecurityQuestions()
    {
        string[] questions =
        {
            "What is your first school name?", 
            "What is your birth place name?", 
            "Who is your favourite teacher?", 
            "What is your favourite TV show?"
        };

        Random rnd = new Random();
        int index1 = rnd.Next(questions.Length);
        int index2;
        do
        {
            index2 = rnd.Next(questions.Length);
        } while (index2 == index1);

        ViewState["Question1"] = index1;
        ViewState["Question2"] = index2;

        lblQuestion1.Text = questions[index1];
        lblQuestion2.Text = questions[index2];
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtAnswer1.Text) || string.IsNullOrWhiteSpace(txtAnswer2.Text))
        {
            ShowMessage("Please answer both security questions.", System.Drawing.Color.Red);
            return;
        }

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            const string query = "SELECT BirthCity, FirstSchool, FavTeacher, FavTVShow FROM UserSecurity WHERE VoterID = @VoterID";

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@VoterID", voterId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string[] storedAnswers =
                        {
                            reader["FirstSchool"].ToString().ToLower(),
                            reader["BirthCity"].ToString().ToLower(),
                            reader["FavTeacher"].ToString().ToLower(),
                            reader["FavTVShow"].ToString().ToLower()
                        };

                        int q1Index = (int)ViewState["Question1"];
                        int q2Index = (int)ViewState["Question2"];

                        if (txtAnswer1.Text.Trim().ToLower() == storedAnswers[q1Index] &&
                            txtAnswer2.Text.Trim().ToLower() == storedAnswers[q2Index])
                        {
                            pnlSecurityQuestions.Visible = false;
                            pnlResetPassword.Visible = true;
                        }
                        else
                        {
                            ShowMessage("Incorrect answers. Please try again.", System.Drawing.Color.Red);
                        }
                    }
                    else
                    {
                        ShowMessage("Security questions not set for this account.", System.Drawing.Color.Red);
                    }
                }
            }
            catch (Exception)
            {
                ShowMessage("An error occurred. Please try again later.", System.Drawing.Color.Red);
            }
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtNewPassword.Text) || string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
        {
            ShowMessage("Please enter both password fields.", System.Drawing.Color.Red);
            return;
        }

        if (txtNewPassword.Text != txtConfirmPassword.Text)
        {
            ShowMessage("Passwords do not match. Please try again.", System.Drawing.Color.Red);
            return;
        }

        // Validate password strength
        if (!IsStrongPassword(txtNewPassword.Text))
        {
            ShowMessage("Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.", System.Drawing.Color.Red);
            return;
        }

        string hashedPassword = HashPassword(txtNewPassword.Text.Trim());

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            const string updateQuery = "UPDATE Users SET Password = @Password WHERE VoterID = @VoterID";

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@VoterID", voterId);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Password reset successfully! <a href='Login.aspx'>Login</a>", System.Drawing.Color.Green);
                    }
                    else
                    {
                        ShowMessage("Error resetting password. Please try again.", System.Drawing.Color.Red);
                    }
                }
            }
            catch (Exception)
            {
                ShowMessage("An error occurred. Please try again later.", System.Drawing.Color.Red);
            }
        }
    }

    // Password Hashing Method
    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
            byte[] hashBytes = sha256.ComputeHash(passwordBytes);
            return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
        }
    }

    // Password Strength Validation Method
    private bool IsStrongPassword(string password)
    {
        return password.Length >= 8 &&
               System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]") && // At least one uppercase letter
               System.Text.RegularExpressions.Regex.IsMatch(password, @"[a-z]") && // At least one lowercase letter
               System.Text.RegularExpressions.Regex.IsMatch(password, @"[0-9]") && // At least one digit
               System.Text.RegularExpressions.Regex.IsMatch(password, @"[\W]");    // At least one special character
    }

    private void ShowMessage(string message, System.Drawing.Color color)
    {
        lblMessage.Visible = true;
        lblMessage.Text = message;
        lblMessage.ForeColor = color;
    }
}
