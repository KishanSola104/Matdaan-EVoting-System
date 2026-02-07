using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;


public partial class AddCandidates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            // Ensure the admin is logged in
            if (Session["AdminID"] == null)
            {
                Response.Redirect("admin_login.aspx");
            }

            // Get admin name and image URL from session and display them
            string adminName = Session["AdminName"] as string ?? "Admin";
            string adminImage = Session["AdminImage"] as string ?? "default.jpg";

            AdminName.InnerText = adminName;
            ProfilePic.Src = adminImage; // Assuming 'ProfilePic' is the image ID


            PopulateDateOfBirth();
            PopulateStates();


            // Check if session variables are available
            if (Session["PartyId"] != null)
            {
                txtPartyId.Text = Session["PartyId"].ToString(); // Party Id
            }

            if (Session["ElectionId"] != null)
            {
                txtElectionId.Text = Session["ElectionId"].ToString(); // Election Id
            }

            if (Session["PartyName"] != null)
            {
                txtPartyName.Text = Session["PartyName"].ToString(); // Party Name
            }

            if (Session["TotalCandidates"] != null)
            {
                int totalCandidates = Convert.ToInt32(Session["TotalCandidates"]);
            }

        }
    }
   
         private void PopulateDateOfBirth()
    {
        for (int day = 1; day <= 31; day++)
            ddlDay.Items.Add(new ListItem(day.ToString(), day.ToString()));
      

        string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
        for (int i = 0; i < months.Length; i++)
            ddlMonth.Items.Add(new ListItem(months[i], (i + 1).ToString()));
      

        for (int year = 1900; year <= 2024; year++)
            ddlYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
    }

    private void PopulateStates()
    {
        List<string> states = new List<string> { "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu and Kashmir", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal" };
        ddlState.Items.Add(new ListItem("Select State", ""));
        foreach (string state in states)
            ddlState.Items.Add(new ListItem(state, state));

        ddlState.SelectedValue = "Select State"; // Default selection
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedState = ddlState.SelectedValue;
        PopulateDistricts(selectedState);
    }

    private void PopulateDistricts(string state)
    {
        ddlDistrict.Items.Clear();
        var districts = new Dictionary<string, List<string>>
        {
     { "Gujarat", new List<string> { "Ahmedabad", "Amreli", "Anand", "Aravalli", "Banaskantha", "Bharuch", "Bhavnagar", "Botad", "Chhota Udaipur", "Dahod", "Dang", "Devbhoomi Dwarka", "Gandhinagar", "Gir Somnath", "Jamnagar", "Junagadh", "Kheda", "Kutch", "Mahisagar", "Mehsana", "Morbi", "Narmada", "Navsari", "Panchmahal", "Patan", "Porbandar", "Rajkot", "Sabarkantha", "Surat", "Surendranagar", "Tapi", "Vadodara", "Valsad" } },       
    { "Andhra Pradesh", new List<string> { "Anantapur", "Chittoor", "East Godavari", "Guntur", "Krishna", "Kurnool", "Prakasam", "Srikakulam", "Sri Potti Sriramulu Nellore", "Visakhapatnam", "Vizianagaram", "West Godavari", "YSR Kadapa" } },
    { "Arunachal Pradesh", new List<string> { "Anjaw", "Changlang", "Dibang Valley", "East Kameng", "East Siang", "Kamle", "Kra Daadi", "Kurung Kumey", "Lepa Rada", "Lohit", "Longding", "Lower Dibang Valley", "Lower Siang", "Lower Subansiri", "Namsai", "Pakke Kessang", "Papum Pare", "Shi Yomi", "Siang", "Tawang", "Tirap", "Upper Dibang Valley", "Upper Siang", "Upper Subansiri", "West Kameng", "West Siang" } },
    { "Assam", new List<string> { "Baksa", "Barpeta", "Biswanath", "Bongaigaon", "Cachar", "Charaideo", "Chirang", "Darrang", "Dhemaji", "Dhubri", "Dibrugarh", "Goalpara", "Golaghat", "Hailakandi", "Hojai", "Jorhat", "Kamrup", "Kamrup Metropolitan", "Karbi Anglong", "Karimganj", "Kokrajhar", "Lakhimpur", "Majuli", "Morigaon", "Nagaon", "Nalbari", "Sivasagar", "Sonitpur", "South Salmara-Mankachar", "Tinsukia", "Udalguri", "West Karbi Anglong" } },
    { "Bihar", new List<string> { "Araria", "Arwal", "Aurangabad", "Banka", "Begusarai", "Bhagalpur", "Bhojpur", "Buxar", "Darbhanga", "East Champaran", "Gaya", "Gopalganj", "Jamui", "Jehanabad", "Kaimur", "Katihar", "Khagaria", "Kishanganj", "Lakhisarai", "Madhepura", "Madhubani", "Munger", "Muzaffarpur", "Nalanda", "Nawada", "Patna", "Purnia", "Rohtas", "Saharsa", "Samastipur", "Saran", "Sheikhpura", "Sheohar", "Sitamarhi", "Siwan", "Supaul", "Vaishali", "West Champaran" } },
    { "Chhattisgarh", new List<string> { "Balod", "Baloda Bazar", "Balrampur", "Bastar", "Bemetara", "Bijapur", "Bilaspur", "Dantewada", "Dhamtari", "Durg", "Gariaband", "Gaurela-Pendra-Marwahi", "Janjgir-Champa", "Jashpur", "Kabirdham", "Kanker", "Kondagaon", "Korba", "Koriya", "Mahasamund", "Mungeli", "Narayanpur", "Raigarh", "Raipur", "Rajnandgaon", "Sukma", "Surajpur", "Surguja" } },
    { "Goa", new List<string> { "North Goa", "South Goa" } },
    { "Haryana", new List<string> { "Ambala", "Bhiwani", "Charkhi Dadri", "Faridabad", "Fatehabad", "Gurugram", "Hisar", "Jhajjar", "Jind", "Kaithal", "Karnal", "Kurukshetra", "Mahendragarh", "Mewat", "Palwal", "Panchkula", "Panipat", "Rewari", "Rohtak", "Sirsa", "Sonipat", "Yamunanagar" } },
    { "Himachal Pradesh", new List<string> { "Bilaspur", "Chamba", "Hamirpur", "Kangra", "Kinnaur", "Kullu", "Lahaul and Spiti", "Mandi", "Shimla", "Sirmaur", "Solan", "Una" } },
    { "Jharkhand", new List<string> { "Bokaro", "Chatra", "Deoghar", "Dhanbad", "Dumka", "East Singhbhum", "Garhwa", "Giridih", "Godda", "Gumla", "Hazaribagh", "Jamtara", "Khunti", "Koderma", "Latehar", "Lohardaga", "Pakur", "Palamu", "Ramgarh", "Ranchi", "Sahebganj", "Seraikela Kharsawan", "Simdega", "West Singhbhum" } },
    { "Karnataka", new List<string> { "Bagalkot", "Ballari", "Belagavi", "Bengaluru Rural", "Bengaluru Urban", "Bidar", "Chamarajanagar", "Chikballapur", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharwad", "Gadag", "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara", "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgir" } },
    { "Kerala", new List<string> { "Alappuzha", "Ernakulam", "Idukki", "Kannur", "Kasaragod", "Kollam", "Kottayam", "Kozhikode", "Malappuram", "Palakkad", "Pathanamthitta", "Thiruvananthapuram", "Thrissur", "Wayanad" } },
    { "Madhya Pradesh", new List<string> { "Agar Malwa", "Alirajpur", "Anuppur", "Ashoknagar", "Balaghat", "Barwani", "Betul", "Bhind", "Bhopal", "Burhanpur", "Chhatarpur", "Chhindwara", "Damoh", "Datia", "Dewas", "Dhar", "Dindori", "Guna", "Gwalior", "Harda", "Hoshangabad", "Indore", "Jabalpur", "Jhabua", "Katni", "Khandwa", "Khargone", "Mandla", "Mandsaur", "Morena", "Narsinghpur", "Neemuch", "Panna", "Raisen", "Rajgarh", "Ratlam", "Rewa", "Sagar", "Satna", "Sehore", "Seoni", "Shahdol", "Shajapur", "Sheopur", "Shivpuri", "Sidhi", "Singrauli", "Tikamgarh", "Ujjain", "Umaria", "Vidisha" } },
    { "Maharashtra", new List<string> { "Ahmednagar", "Akola", "Amravati", "Aurangabad", "Beed", "Bhandara", "Buldhana", "Chandrapur", "Dhule", "Gadchiroli", "Gondia", "Hingoli", "Jalgaon", "Jalna", "Kolhapur", "Latur", "Mumbai City", "Mumbai Suburban", "Nagpur", "Nanded", "Nandurbar", "Nashik", "Osmanabad", "Palghar", "Parbhani", "Pune", "Raigad", "Ratnagiri", "Sangli", "Satara", "Sindhudurg", "Solapur", "Thane", "Wardha", "Washim", "Yavatmal" } },
    { "Manipur", new List<string> { "Bishnupur", "Chandel", "Churachandpur", "Imphal East", "Imphal West", "Jiribam", "Kakching", "Kamjong", "Kangpokpi", "Noney", "Pherzawl", "Senapati", "Tamenglong", "Tengnoupal", "Thoubal", "Ukhrul" } },
    { "Meghalaya", new List<string> { "East Garo Hills", "East Jaintia Hills", "East Khasi Hills", "North Garo Hills", "Ri Bhoi", "South Garo Hills", "South West Garo Hills", "South West Khasi Hills", "West Garo Hills", "West Jaintia Hills", "West Khasi Hills" } },
    { "Mizoram", new List<string> { "Aizawl", "Champhai", "Kolasib", "Lawngtlai", "Lunglei", "Mamit", "Saiha", "Serchhip" } },
    { "Nagaland", new List<string> { "Dimapur", "Kiphire", "Kohima", "Longleng", "Mokokchung", "Mon", "Noklak", "Peren", "Phek", "Tuensang", "Wokha", "Zunheboto" } },
    { "Odisha", new List<string> { "Angul", "Balangir", "Balasore", "Bargarh", "Bhadrak", "Boudh", "Cuttack", "Deogarh", "Dhenkanal", "Gajapati", "Ganjam", "Jagatsinghpur", "Jajpur", "Jharsuguda", "Kalahandi", "Kandhamal", "Kendrapara", "Kendujhar", "Khordha", "Koraput", "Malkangiri", "Mayurbhanj", "Nabarangpur", "Nayagarh", "Nuapada", "Puri", "Rayagada", "Sambalpur", "Subarnapur", "Sundargarh" } },
    { "Punjab", new List<string> { "Amritsar", "Barnala", "Bathinda", "Faridkot", "Fatehgarh Sahib", "Fazilka", "Ferozepur", "Gurdaspur", "Hoshiarpur", "Jalandhar", "Kapurthala", "Ludhiana", "Mansa", "Moga", "Mohali", "Muktsar", "Pathankot", "Patiala", "Rupnagar", "Sangrur", "Shaheed Bhagat Singh Nagar", "Tarn Taran" } },
    { "Rajasthan", new List<string> { "Ajmer", "Alwar", "Banswara", "Baran", "Barmer", "Bharatpur", "Bhilwara", "Bikaner", "Bundi", "Chittorgarh", "Churu", "Dausa", "Dholpur", "Dungarpur", "Hanumangarh", "Jaipur", "Jaisalmer", "Jalore", "Jhalawar", "Jhunjhunu", "Jodhpur", "Karauli", "Kota", "Nagaur", "Pali", "Pratapgarh", "Rajsamand", "Sawai Madhopur", "Sikar", "Sirohi", "Sri Ganganagar", "Tonk", "Udaipur" } },
    { "Sikkim", new List<string> { "East Sikkim", "North Sikkim", "South Sikkim", "West Sikkim" } },
    { "Tamil Nadu", new List<string> { "Ariyalur", "Chengalpattu", "Chennai", "Coimbatore", "Cuddalore", "Dharmapuri", "Dindigul", "Erode", "Kallakurichi", "Kanchipuram", "Kanyakumari", "Karur", "Krishnagiri", "Madurai", "Mayiladuthurai", "Nagapattinam", "Namakkal", "Nilgiris", "Perambalur", "Pudukkottai", "Ramanathapuram", "Ranipet", "Salem", "Sivaganga", "Tenkasi", "Thanjavur", "Theni", "Thiruvallur", "Thiruvarur", "Thoothukudi", "Tiruchirappalli", "Tirunelveli", "Tirupathur", "Tiruppur", "Tiruvannamalai", "Vellore", "Viluppuram", "Virudhunagar" } },
    { "Telangana", new List<string> { "Adilabad", "Bhadradri Kothagudem", "Hyderabad", "Jagtial", "Jangaon", "Jayashankar Bhupalpally", "Jogulamba Gadwal", "Kamareddy", "Karimnagar", "Khammam", "Komaram Bheem Asifabad", "Mahabubabad", "Mahabubnagar", "Mancherial", "Medak", "Medchal-Malkajgiri", "Mulugu", "Nagarkurnool", "Nalgonda", "Narayanpet", "Nirmal", "Nizamabad", "Peddapalli", "Rajanna Sircilla", "Rangareddy", "Sangareddy", "Siddipet", "Suryapet", "Vikarabad", "Wanaparthy", "Warangal Rural", "Warangal Urban", "Yadadri Bhuvanagiri" } },
    { "Tripura", new List<string> { "Dhalai", "Gomati", "Khowai", "North Tripura", "Sepahijala", "South Tripura", "Unakoti", "West Tripura" } },
    { "Uttar Pradesh", new List<string> { "Agra", "Aligarh", "Ambedkar Nagar", "Amethi", "Amroha", "Auraiya", "Ayodhya", "Azamgarh", "Badaun", "Baghpat", "Bahraich", "Ballia", "Balrampur", "Banda", "Barabanki", "Bareilly", "Basti", "Bhadohi", "Bijnor", "Budaun", "Bulandshahr", "Chandauli", "Chitrakoot", "Deoria", "Etah", "Etawah", "Farrukhabad", "Fatehpur", "Firozabad", "Gautam Buddh Nagar", "Ghaziabad", "Ghazipur", "Gonda", "Gorakhpur", "Hamirpur", "Hapur", "Hardoi", "Hathras", "Jalaun", "Jaunpur", "Jhansi", "Kannauj", "Kanpur Dehat", "Kanpur Nagar", "Kasganj", "Kaushambi", "Kheri", "Kushinagar", "Lalitpur", "Lucknow", "Maharajganj", "Mahoba", "Mainpuri", "Mathura", "Mau", "Meerut", "Mirzapur", "Moradabad", "Muzaffarnagar", "Pilibhit", "Pratapgarh", "Raebareli", "Rampur", "Saharanpur", "Sambhal", "Sant Kabir Nagar", "Shahjahanpur", "Shamli", "Shravasti", "Siddharthnagar", "Sitapur", "Sonbhadra", "Sultanpur", "Unnao", "Varanasi" } },
    { "Uttarakhand", new List<string> { "Almora", "Bageshwar", "Chamoli", "Champawat", "Dehradun", "Haridwar", "Nainital", "Pauri Garhwal", "Pithoragarh", "Rudraprayag", "Tehri Garhwal", "Udham Singh Nagar", "Uttarkashi" } },
    { "West Bengal", new List<string> { "Alipurduar", "Bankura", "Birbhum", "Cooch Behar", "Dakshin Dinajpur", "Darjeeling", "Hooghly", "Howrah", "Jalpaiguri", "Jhargram", "Kalimpong", "Kolkata", "Malda", "Murshidabad", "Nadia", "North 24 Parganas", "Paschim Bardhaman", "Paschim Medinipur", "Purba Bardhaman", "Purba Medinipur", "Purulia", "South 24 Parganas", "Uttar Dinajpur" } },
    { "Andaman and Nicobar Islands", new List<string> { "Nicobar", "North and Middle Andaman", "South Andaman" } },
    { "Chandigarh", new List<string> { "Chandigarh" } },
    { "Dadra and Nagar Haveli and Daman and Diu", new List<string> { "Dadra and Nagar Haveli", "Daman", "Diu" } },
    { "Lakshadweep", new List<string> { "Agatti", "Amini", "Andrott", "Bangaram", "Bitra", "Chetlat", "Kavaratti", "Kadmat", "Kalpeni", "Kilthan", "Minicoy" } },
    { "Delhi", new List<string> { "Central Delhi", "East Delhi", "New Delhi", "North Delhi", "North East Delhi", "North West Delhi", "Shahdara", "South Delhi", "South East Delhi", "South West Delhi", "West Delhi" } },
    { "Puducherry", new List<string> { "Karaikal", "Mahe", "Puducherry", "Yanam" } }


      
        };

        if (districts.ContainsKey(state))
        {
            foreach (var district in districts[state])
                ddlDistrict.Items.Add(new ListItem(district, district));
        }
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            // Validate all fields
            if (!ValidateFields())
            {
                return; // Stop processing if validation fails
            }

            // Extract field values
            string electionId = txtElectionId.Text;
            string partyId = txtPartyId.Text;
            string partyName = txtPartyName.Text;
            string candidateId = txtCandidId.Text;
            string candidateName = TextBox1.Text;
            string state = ddlState.SelectedValue;
            string district = ddlDistrict.SelectedValue;
            string dob = ddlYear.SelectedValue + "-" + ddlMonth.SelectedValue + "-" + ddlDay.SelectedValue;
            string gender = rbMale.Checked ? "Male" : rbFemale.Checked ? "Female" : "Other";
            string email = txtEmail.Text;
            string mobile = txtPhoneNumber.Text;

            string image = ""; // To store the image file path

            // Check if a file is uploaded
            if (fuCandidateImage.HasFile)
            {
                // Get file extension
                string fileExtension = Path.GetExtension(fuCandidateImage.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                // Validate file type
                if (!allowedExtensions.Contains(fileExtension))
                {
                    lblMessage.Text = "Only image files (.jpg, .jpeg, .png, .gif) are allowed.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Generate unique file name
                string fileName = candidateId + "_" + DateTime.Now.Ticks + fileExtension;

                // Define the path where the file will be saved
                string folderPath = Server.MapPath("~/Candidates_Images/");

                // Ensure directory exists
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                // Save the image
                image = "Candidates_Images/" + fileName;
                fuCandidateImage.SaveAs(Path.Combine(folderPath, fileName));
            }
            else
            {
                lblMessage.Text = "Please upload a candidate image.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Insert data into the database
            using (SqlConnection conn = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"))
            {
                conn.Open();
                string query = "INSERT INTO Candidates (ElectionId, PartyId, PartyName, CandidateId, CandidateName, State, District, DOB, Gender, Email, Mobile, Image) " +
                               "VALUES (@ElectionId, @PartyId, @PartyName, @CandidateId, @CandidateName, @State, @District, @DOB, @Gender, @Email, @Mobile, @Image)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ElectionId", electionId);
                    cmd.Parameters.AddWithValue("@PartyId", partyId);
                    cmd.Parameters.AddWithValue("@PartyName", partyName);
                    cmd.Parameters.AddWithValue("@CandidateId", candidateId);
                    cmd.Parameters.AddWithValue("@CandidateName", candidateName);
                    cmd.Parameters.AddWithValue("@State", state);
                    cmd.Parameters.AddWithValue("@District", district);
                    cmd.Parameters.AddWithValue("@DOB", dob);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Image", image); // Store the image path in the database

                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Candidate added successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception ex)
        {
            lblMessage.Text = "An error occurred: " + ex.Message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }


    protected bool ValidateFields()
    {
        // Validate email
        string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
        if (!Regex.IsMatch(txtEmail.Text, emailPattern))
        {
            lblMessage.Text = "Invalid email address.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        // Validate mobile number
        if (!Regex.IsMatch(txtPhoneNumber.Text, @"^\d{10}$"))
        {
            lblMessage.Text = "Mobile number must be a 10-digit number.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        // Validate date of birth (basic check)
        if (string.IsNullOrEmpty(ddlYear.SelectedValue) || string.IsNullOrEmpty(ddlMonth.SelectedValue) || string.IsNullOrEmpty(ddlDay.SelectedValue))
        {
            lblMessage.Text = "Date of Birth is required.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return false;
        }

        // Additional validations can be added here
        return true;
    }

   
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        // Reset all fields to their default values
        txtCandidId.Text = string.Empty;
        TextBox1.Text = string.Empty;
        ddlState.SelectedIndex = 0;
        ddlDistrict.SelectedIndex = 0;
        ddlDay.SelectedIndex = 0;
        ddlMonth.SelectedIndex = 0;
        ddlYear.SelectedIndex = 0;
        rbMale.Checked = rbFemale.Checked = rbOther.Checked = false;
        txtEmail.Text = string.Empty;
        txtPhoneNumber.Text = string.Empty;
        lblMessage.Text = string.Empty;
    }
}
