<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <title>Code w/Me - Small App</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
          <h1>Code w/Me <small>Small App</small></h1>
        </div>
        <div class="row" id="app">
            <div class="col-md-3">        
                <div class="list-group">
                    <router-link class="list-group-item" to="/">Home</router-link>
                    <router-link class="list-group-item" to="/form">Form</router-link>
                </div>
            </div>
            <div class="col-md-9">
                <router-view></router-view>
            </div>
        </div>
    </div>
    <script src="https://unpkg.com/vue"></script>
    <script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
    <script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>
    <script type="text/x-template" id="home-template">
        <div>
            <h1>Home</h1>
            <p>Welcome to the app! Here are the totals and latest activity. Interact on the 
                <router-link to="/form">Form</router-link> page.
            </p>
            <div v-if="loaded">
                <h2>Totals</h2>
                <p>Dog Power: {{dogTotal}}</p>
                <p>Cat Power: {{catTotal}}</p>
                <h2>Feed</h2>
                <ul class="list-unstyled" id="example-1">
                <li v-for="item in list">
                    {{ item.username }} picked {{ item.choice }} at {{ item.prettyDate }}
                </li>
                </ul>
            </div>
            <p v-if="!loaded">Loading...</p>
        </div>
    </script>
    <script type="text/x-template" id="form-template">
        <div>
            <h1>Form Submission</h1>
            <form @submit.prevent="submitForm()">
                <p class="text-danger" v-if="errorMessage">{{errorMessage}}</p>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input class="form-control" id="username" type="text" v-model="formData.username"/>
                </div>
                <div class="form-group">
                    <label for="choice">Dog or Cat?</label>
                    <select class="form-control" id="choice" v-model="formData.choice">
                        <option value="">Please select one</option>
                        <option>Dog</option>
                        <option>Cat</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </script>
    <script>
        // Initialize Firebase
        var config = {
            apiKey: "AIzaSyCNO3zNa9715yNTiktFuPyxoPeqKwTCHJc",
            authDomain: "java-build.firebaseapp.com",
            databaseURL: "https://java-build.firebaseio.com",
            projectId: "java-build",
            storageBucket: "java-build.appspot.com",
            messagingSenderId: "596519369255"
        };
        firebase.initializeApp(config);
        function writeSubmissionData(name, choice) {
            var newPostKey = firebase.database().ref().child('submission').push().key;
            var date = new Date();
            var time = date.toLocaleString('en-US', { hour: 'numeric',minute:'numeric', hour12: true });
            var dateTimeStr = time + " "+date.getMonth() + "-" + date.getDay() + "-" + date.getFullYear();
            firebase.database().ref('/submission/' + newPostKey).set({
                username: name,
                choice: choice,
                prettyDate: dateTimeStr,
                timestamp: date.getTime()
            });
        }

        var feedlimit = 10;
        var listData = {
            list:[],
            loaded: false,
            dogTotal:0,
            catTotal:0
        };
        var dbWatcher = firebase.database().ref('/submission/');
        dbWatcher.on('value', function(snapshot) {
            var res = snapshot.val();
            if(res){
                listData.dogTotal = 0;
                listData.catTotal = 0;
                var keys = Object.keys(res);
                var list = [];
                for(var key of keys){
                    if(res[key].choice=="Dog"){
                        listData.dogTotal++;
                    } else if(res[key].choice=="Cat"){
                        listData.catTotal++;
                    }
                    list.push(res[key]);
                }
                if(list.length>feedlimit){
                    list = list.slice(list.length-feedlimit);
                }
                listData.list = list.reverse();
                listData.loaded = true;
            }
        });
        //Vue
        var data = {
            formData:{
                choice:"",
                username:""
            },
            errorMessage:""
        };
        var Home = {
            template: '#home-template',
            data: function(){
                return listData;
            }
        };
        var Form = {
            template: '#form-template',
            data: function () {
                return data
            },
            methods: {
                submitForm: function () {
                    //console.log(this.formData);
                    if(!this.formData.username || !this.formData.choice){
                        this.errorMessage = "Please enter a username and choice";
                    } else {
                        this.errorMessage = "";
                        writeSubmissionData(this.formData.username,this.formData.choice);
                        router.push('/');
                    }
                },
                resetForm: function () {
                    this.formData = {
                        dog:"",
                        rank:null
                    }
                },
            }
        };
        var routes = [
            { path: '/', component: Home },
            { path: '/form', component: Form },
        ];
        var router = new VueRouter({
            routes // short for `routes: routes`
        })
        var app = new Vue({
            router
        }).$mount('#app');
    </script>
</body>
</html>