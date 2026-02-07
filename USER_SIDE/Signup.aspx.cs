using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Signup : System.Web.UI.Page
{
    private string connString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUserData();
        }
    }

    private void LoadUserData()
    {
        if (Session["AadharID"] != null)
        {
            string aadharID = Session["AadharID"].ToString();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT VoterID, Name, State, District, Image, DOB, Gender FROM Voters WHERE AadharID = @AadharID";

                try
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@AadharID", aadharID);
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            txtVoterID.Text = reader["VoterID"].ToString();
                            txtName.Text = reader["Name"].ToString();
                            ddlState.Items.Clear();
                            ddlState.Items.Add(reader["State"].ToString());
                            ddlState.SelectedValue = reader["State"].ToString();
                            ddlDistrict.Items.Clear();
                            ddlDistrict.Items.Add(reader["District"].ToString());
                            ddlDistrict.SelectedValue = reader["District"].ToString();
                            userImage.Src = reader["Image"].ToString();

                            // Populate Date of Birth
                            string dob = Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd");
                            string[] dobParts = dob.Split('-');
                            ddlYear.Items.Clear();
                            ddlYear.Items.Add(dobParts[0]);
                            ddlMonth.Items.Clear();
                            ddlMonth.Items.Add(dobParts[1]);
                            ddlDay.Items.Clear();
                            ddlDay.Items.Add(dobParts[2]);

                            // Select Gender
                            string gender = reader["Gender"].ToString().ToLower();
                            rbMale.Checked = gender == "male";
                            rbFemale.Checked = gender == "female";
                            rbOther.Checked = gender == "other";
                        }
                        else
                        {
                            lblMessage.Text = "No voter details found for this Aadhar ID.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        else
        {
            lblMessage.Text = "Session expired. Please log in again.";
            lblMessage.ForeColor = System.Drawing.Color.Red;

            Response.Redirect("UserVerification.aspx");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["AadharID"] == null)
        {
            lblMessage.Text = "Session expired. Please log in again.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
          
            return;
        }

        if (!CheckBox1.Checked)
        {
            lblMessage.Text = "You must agree to the Terms and Conditions.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string aadharID = Session["AadharID"].ToString();
        string password = txtPassword.Text.Trim();
        string confirmPassword = txtConfirmPassword.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtPhoneNumber.Text.Trim();

        if (string.IsNullOrEmpty(txtVoterID.Text) || string.IsNullOrEmpty(txtName.Text) ||
            string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mobile) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "All fields are required.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (password != confirmPassword)
        {
            lblMessage.Text = "Passwords do not match.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string gender = rbMale.Checked ? "Male" : rbFemale.Checked ? "Female" : "Other";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            try
            {
                conn.Open();

                // Check if Voter ID already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE VoterID = @VoterID";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@VoterID", txtVoterID.Text);
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblMessage.Text = "Voter ID already exists.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                }

                // Insert user data
                string insertQuery = "INSERT INTO Users (VoterID, Name, State, District, Email, Mobile, Password, Gender) " +
                                     "VALUES (@VoterID, @Name, @State, @District, @Email, @Mobile, @Password, @Gender)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@VoterID", txtVoterID.Text);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@State", ddlState.SelectedValue);
                    cmd.Parameters.AddWithValue("@District", ddlDistrict.SelectedValue);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Gender", gender);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // ✅ Store Voter ID in session
                        Session["VoterID"] = txtVoterID.Text;

                        // ✅ Display success alert & redirect
                        string script = "<script type='text/javascript'>alert('Registration successful! Redirecting to security page...'); window.location='UserSecurity.aspx';</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessRedirect", script, false);
                    }

                    else
                    {
                        lblMessage.Text = "Error occurred. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "SQL Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
