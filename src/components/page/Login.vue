<template>
    <div class="login-wrap">
        <div class="ms-title">编译器文法分析模拟器</div>
        <div class="ms-login">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="demo-ruleForm">

                <div v-if="errorInfo">
                    <span>{{errInfo}}</span>
                </div>

                <el-form-item prop="studentID">
                    <el-input v-model="ruleForm.studentID" placeholder="学号" ></el-input>
                </el-form-item>

                <el-form-item prop="passWord">
                    <el-input type="password" placeholder="密码" v-model="ruleForm.passWord" @keyup.enter.native="submitForm('ruleForm')"></el-input>
                </el-form-item>


                <el-form-item  prop="validate">
                    <el-input v-model="ruleForm.validate" class="validate-code" placeholder="验证码" ></el-input>
                    <div class="code" @click="refreshCode">
                        <s-identify :identifyCode="identifyCode"></s-identify>
                    </div>
                </el-form-item>


                <div class="login-btn">
                    <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
                </div>

                <p class="register" @click="handleCommand()">注册</p>
            </el-form>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'login',
        data() {
            return {
                identifyCodes: "1234567890",
                identifyCode: "",
                errorInfo : false,
                ruleForm: {
                    studentID: '',
                    passWord: '',
                    validate: ''
                },
                rules: {
                    studentID: [
                        { required: true, message: '请输入学号', trigger: 'blur' }
                    ],
                    passWord: [
                        { required: true, message: '请输入密码', trigger: 'blur' }
                    ],
                    validate: [
                        { required: true, message: '请输入验证码', trigger: 'blur' }
                    ]
                }
            }
        },
        mounted() {
            this.identifyCode = "";
            this.makeCode(this.identifyCodes, 4);
        },
        methods: {
            getStudentName() {
                var student_ID=sessionStorage.getItem('studentID')
                console.log(student_ID);
                this.$http.get('/api/user/getUser',{studentID: student_ID}).then(function(response) {
                    console.log(11111);
                    console.log(response);
                    let result = response.data[0];
                    var name = result.studentName;
                    console.log(name)
                    sessionStorage.setItem('studentName', name);
                }).then(function(error) {
                    console.log(error);
                })
            },
            submitForm(formName) {
                // debounceAjax(formName)
                // 提交表格数据  用户登陆名  密码  以及验证码
                //在提交表单前会先调用SubmitForm()函数，
                // 通常用这种方法实现在提交表单前对表单进行简单验证，
                // 验证方式写在SubmitForm()函数里。

                const self = this;
                self.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.$http.post('/api/user/login',JSON.stringify(self.ruleForm))
                        .then((response) => {
                            console.log(response);

                            if (response.data == -1) {
                                self.errorInfo = true;
                                self.errInfo = '该用户不存在';
                                console.log('该用户不存在')
                            } else if (response.data == 0) {
                                console.log('密码错误')
                                self.errorInfo = true;
                                self.errInfo = '密码错误';
                            } else if (response.status == 200) {

                                sessionStorage.setItem('studentID',self.ruleForm.studentID);
                                this.getStudentName();
                                console.log(JSON.stringify(self.ruleForm));
                                self.$router.push('/readme');
                                // location.reload()
                            }
                        }).then((error) => {
                            console.log(error);
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            handleCommand() {
                console.log(this);
                this.$router.push('/register');
            },
            randomNum(min, max) {
                return Math.floor(Math.random() * (max - min) + min);
            },
            refreshCode() {
                this.identifyCode = "";
                this.makeCode(this.identifyCodes, 4);
            },
            makeCode(o, l) {
                for (let i = 0; i < l; i++) {
                    this.identifyCode += this.identifyCodes[
                    this.randomNum(0, this.identifyCodes.length)
                    ];
                }
                console.log(this.identifyCode);
            },
            // debounce(func, delay) {
            //     return function(args) {
            //         var _this = this
            //         var _args = args
            //         clearTimeout(func.id)
            //         func.id = setTimeout(function() {
            //         func.call(_this, _args)
            //         }, delay)
            //     }
            // },
            // submitDebounce(formName) {
            //     const self = this;
            //     self.$refs[formName].validate((valid) => {
            //         if (valid) {
            //             localStorage.setItem('ms_username',self.ruleForm.studentID);
            //             localStorage.setItem('ms_user',JSON.stringify(self.ruleForm));
            //             console.log(JSON.stringify(self.ruleForm));
            //             self.$http.post('/api/user/login',JSON.stringify(self.ruleForm))
            //             .then((response) => {
            //                 console.log(response);
            //                 if (response.data == -1) {
            //                     self.errorInfo = true;
            //                     self.errInfo = '该用户不存在';
            //                     console.log('该用户不存在')
            //                 } else if (response.data == 0) {
            //                     console.log('密码错误')
            //                     self.errorInfo = true;
            //                     self.errInfo = '密码错误';
            //                 } else if (response.status == 200) {
            //                     self.$router.push('/readme');
            //                 }
            //             }).then((error) => {
            //                 console.log(error);
            //             })
            //         } else {
            //             console.log('error submit!!');
            //             return false;
            //         }
            //     });
            // },
            // debounceAjax () {
            //     debounce(submitDebounce,1000);
            // }
        }
    }
</script>

<style scoped>
    .login-wrap{
        position: relative;
        width:100%;
        height:100%;
    }
    .ms-title{
        position: absolute;
        top:50%;
        width:100%;
        margin-top: -230px;
        text-align: center;
        font-size:30px;
        color: #fff;

    }
    .ms-login{
        position: absolute;
        left:50%;
        top:50%;
        width:300px;
        height:240px;
        margin:-150px 0 0 -190px;
        padding:40px;
        border-radius: 5px;
        background: #fff;
    }
    .ms-login span {
        color: red;
    }
    .login-btn{
        text-align: center;
    }
    .login-btn button{
        width:100%;
        height:36px;
    }
    .code {
        width: 112px;
        height: 35px;
        border: 1px solid #ccc;
        float: right;
        border-radius: 2px;
    }
    .validate-code {
        width: 136px;
        float: left;
    }
    .register {
        font-size:14px;
        line-height:30px;
        color:#999;
        cursor: pointer;
        float:right;
    }
</style>
