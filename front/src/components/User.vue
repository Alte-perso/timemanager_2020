<template>
  <div class="text-center">
    <v-btn v-if="isConnected" icon @click="logout()">
      <v-icon>mdi-logout </v-icon>
    </v-btn>
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn icon>
          <v-icon v-if="!isConnected" v-bind="attrs" v-on="on"
            >mdi-login
          </v-icon>
          <v-icon v-if="isConnected" v-bind="attrs" v-on="on"
            >mdi-account
          </v-icon>
        </v-btn>
      </template>

      <v-card>
        <!-- ######## CONNEXION AND CREATE ACCOUNT ######## -->
        <!-- ################### TITLE #################### -->
        <v-card-title class="headline grey lighten-2" v-if="!isConnected">
          <v-row class="d-flex justify-space-between">
            <p v-if="!signUp">Welcome back !</p>
            <p v-else>Create an account</p>
            <v-btn icon>
              <v-icon @click="dialog = false">mdi-close </v-icon>
            </v-btn>
          </v-row>
        </v-card-title>

        <!-- ######## ACCOUNT SETTINGS ######## -->
        <!-- ############# TITLE ############## -->
        <v-card-title class="headline grey lighten-2" v-else>
          <v-row class="d-flex justify-space-between">
            <p>Account settings</p>
            <v-btn icon>
              <v-icon @click="dialog = false">mdi-close </v-icon>
            </v-btn>
          </v-row>
        </v-card-title>

        <!-- ######## CONNEXION AND CREATE ACCOUNT ######## -->
        <!-- ################### FORM ##################### -->
        <v-card-text class="mt-5" v-if="!isConnected">
          <form>
            <v-text-field
              label="Username"
              outlined
              autocomplete
              :rules="usernameRules"
              v-model="user.username"
            ></v-text-field>
            <v-text-field
              v-if="signUp"
              label="Email"
              outlined
              :rules="emailRules"
              autocomplete
              v-model="user.email"
            ></v-text-field>
            <v-text-field
              label="Password"
              outlined
              :rules="[rules.required, rules.password]"
              type="password"
              autocomplete
              v-model="user.password"
            ></v-text-field>
          </form>
          <span v-if="!signUp"
            >If you don't have an account,
            <span :class="$style.signUpLink" @click="signUp = true"
              >sign up</span
            ></span
          >
          <span v-else
            >You already have an account,
            <span :class="$style.signUpLink" @click="signUp = false"
              >sign in</span
            ></span
          >
        </v-card-text>

        <!-- ######## ACCOUNT SETTINGS ######## -->
        <!-- ############# CONTENT ############## -->
        <v-card-text class="mt-5" v-else>
          <div v-if="edit">
            <h2 class="mb-5">Edit user :</h2>
            <form>
              <v-text-field
                label="Firstname"
                outlined
                autocomplete
                :rules="userRules"
                v-model="user.firstname"
              ></v-text-field>
              <v-text-field
                label="Lastname"
                outlined
                autocomplete
                :rules="userRules"
                v-model="user.lastname"
              ></v-text-field>
              <v-text-field
                label="Username"
                outlined
                autocomplete
                :rules="usernameRules"
                v-model="user.username"
              ></v-text-field>
              <v-text-field
                label="Email"
                outlined
                :rules="emailRules"
                autocomplete
                v-model="user.email"
              ></v-text-field>
              <v-text-field
                type="password"
                label="Password"
                outlined
                :rules="[rules.required, rules.password]"
                autocomplete
                v-model="user.password"
              ></v-text-field>
            </form>
          </div>

          <div v-else>
            <p>Firstname : {{ userState.firstname }}</p>
            <p>Lastname : {{ userState.lastname }}</p>
            <p>Username : {{ userState.username }}</p>
            <p>Email : {{ userState.email }}</p>
          </div>
        </v-card-text>

        <v-divider></v-divider>

        <!-- ######## CONNEXION AND CREATE ACCOUNT ######## -->
        <!-- ################### ACTIONS ##################### -->
        <v-card-actions v-if="!isConnected">
          <p class="mb-0 ml-4" :class="$style.errorMessage">
            {{ errorMessage }}
          </p>
          <v-spacer></v-spacer>
          <v-btn
            v-if="!signUp"
            color="primary"
            text
            @click="login()"
          >
            Connect
          </v-btn>
          <v-btn
            v-else
            color="primary"
            text
            @click="createUser()"
            :loading="loading"
          >
            Save and connect
          </v-btn>
        </v-card-actions>

        <!-- ######## ACCOUNT SETTINGS ######## -->
        <!-- ############# ACTIONS ############## -->
        <v-card-actions v-else>
          <v-spacer></v-spacer>
          <v-btn v-if="edit" color="secondary" text @click="edit = false">
            Cancel
          </v-btn>
          <v-btn v-if="edit" color="primary" text @click="editUser()">
            Save
          </v-btn>
          <v-btn v-if="!edit" text color="red lighten-1" @click="deletePopup()">
            delete
          </v-btn>
          <v-btn v-if="!edit" text color="primary" @click="edit = true">
            Edit
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import {EventBus} from "@/main.js"

export default {
  data() {
    return {
      dialog: false,
      signUp: false,
      edit: false,
      loading: false,
      errorMessage: "",
      user: {
        username: null,
        email: null,
        password: null,
        id: null
      },
      userRules: [
        v => (v && v.length <= 15) || "Must be less than 15 characters"
      ],
      usernameRules: [
        v => !!v || "Username is required",
        v => (v && v.length <= 15) || "Username must be less than 15 characters"
      ],
      emailRules: [
        v => !!v || "E-mail is required",
        v => /.+@.+\..+/.test(v) || "E-mail must be valid"
      ],
      rules: {
        required: value => !!value || "Password is required.",
        password: value => {
          const pattern = /(?=.*[A-Z])(?=.*[a-z].*[a-z])(?=.*[0-9]).{8,}/;
          return (
            pattern.test(value) ||
            "Invalid password : It must contain at least one capital letter and one number. 8 characters minimum."
          );
        }
      }
    };
  },
  computed: {
    ...mapGetters(["userState", "isConnected"])
  },
  methods: {
    ...mapActions(["setUser", "setIsConnected"]),
    deletePopup() {
      if (confirm("Are you sure you want to delete this user ?")) {
        this.deleteUser();
        console.log("User was deleted to the database.");
      } else {
        console.log("No delete action");
      }
    },
    initUser() {
      this.user.username = null;
      this.user.id = null;
      this.user.email = null;
      this.user.password = null;
      this.user.firstname = null;
      this.user.lastname = null;
    },
    logout() {
      if (confirm("Are you sure you want to log out ?")) {
        //TODO: log out user (delete JWT cookie or localstorage)
        this.initUser();
        this.setUser(this.user);
        this.setIsConnected(false);
        this.$router.push({ name: 'Login'});
        console.log("User unlogged");
      } else {
        console.log("User steel logged");
      }
    },
    getUser(userId) {
      this.axios.get(process.env.VUE_APP_URL_API + "users/" + userId)
      .then( data => {
        this.user.username = data.data.data.username;
        this.user.email = data.data.data.email;
        this.user.id = data.data.data.id;
        this.user.firstname = data.data.data.firstname;
        this.user.lastname = data.data.data.lastname;
        this.setUser(this.user);
      })
      .catch(errors => {
          this.errorMessage = "Oops !!  an error occured ...";
          setTimeout(() => (this.errorMessage = ""), 2000);
          console.log("ERROR : ", errors.response);
      })
    },
    login() {
      this.loading = true;
      this.axios
        .post(process.env.VUE_APP_URL_API_AUTH, {
          auth: {
            username: this.user.username,
            password: this.user.password
          }
        })
        .then(data => {
          if(data.data.status) {
            this.edit = true;
            this.loading = false;
            localStorage.setItem('JWT_TOKEN', data.data.token);
            if(this.userState.email == null) {
               this.getUser(data.data.user);
            }
            this.setIsConnected(true);
            this.dialog = false;
            this.$router.push({ name: 'Home'});
          } else {
            this.loading = false;
            this.errorMessage = "Oops... Password or Username incorrect";
            setTimeout(() => (this.errorMessage = ""), 2000);
          }
        })
        .catch(errors => {
          this.loading = false;
          this.errorMessage = "Oops !!  an error occured ...";
          setTimeout(() => (this.errorMessage = ""), 2000);
          console.log("ERROR : ", errors.response);
        });
    },
    createUser() {
      this.loading = true;
      this.errorMessage = "";
      this.axios
        .post(process.env.VUE_APP_URL_API + "users", {
          user: {
            username: this.user.username,
            password: this.user.password,
            email: this.user.email
          }
        })
        .then(data => {
          this.loading = false;
          this.user.username = data.data.data.username;
          this.user.email = data.data.data.email;
          this.user.id = data.data.data.id;
          this.setUser(this.user);
          this.login();
        })
        .catch(errors => {
          this.loading = false;
          this.errorMessage = "Oops !!  an error occured ...";
          setTimeout(() => (this.errorMessage = "").bind(this), 2000);
          console.log(errors.response);
        });
    },
    deleteUser() {
      this.loading = true;
      this.axios
        .delete(process.env.VUE_APP_URL_API + "users/" + this.userState.id)
        .then(() => {
          this.initUser();
          this.setUser(this.user);
          this.setIsConnected(false);
          this.dialog = false;
          this.$router.push({name: "Login"});
        })
        .catch(errors => {
          this.loading = false;
          this.errorMessage = "Oops !!  an error occured ...";
          setTimeout(() => (this.errorMessage = ""), 2000);
          console.log("ERROR : ", errors.response);
        });
    },
    editUser() {
      this.loading = true;
      this.axios
        .put(process.env.VUE_APP_URL_API + "users/" + this.userState.id, {
          user: {
            username: this.user.username,
            email: this.user.email,
            password: this.user.password
          }
        })
        .then(() => {
          this.edit = false;
          this.loading = false;
          this.setUser(this.user);
        })
        .catch(errors => {
          this.loading = false;
          this.errorMessage = "Oops !!  an error occured ...";
          setTimeout(() => (this.errorMessage = ""), 2000);
          console.log("ERROR : ", errors.response);
        });
    },
    openPopup() {
      this.dialog = true
    }
  },
  created() {
    EventBus.$on('openlogin', () => {
      this.openPopup();
    })
  },  
  mounted() {
    this.user = this.userState;

  }
};
</script>

<style lang="scss" module>
.signUpLink {
  color: #2076d2;
  cursor: pointer;
}
.snackbar {
  z-index: 10000;
}
.errorMessage {
  color: #e53935;
}
</style>
