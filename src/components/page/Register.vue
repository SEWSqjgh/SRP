<template>
	<div>
		<div class="crumbs crumbs-register">
			<el-breadcrumb separator="/" class="register-title">
                <el-breadcrumb-item><i class="el-icon-setting"></i>注册</el-breadcrumb-item>
            </el-breadcrumb>
		</div>
		<div class="userContent">
			<el-form ref="form" :model="form" :rules="rules" label-width="80px">
				<el-form-item prop="studentName" label="学生姓名">
					<el-input v-model="form.studentName" placeholder="请输入学生姓名"></el-input>
				</el-form-item>
				<el-form-item prop="studentID" label="学生学号">
					<el-input v-model="form.studentID" placeholder="请输入学生学号"></el-input>
				</el-form-item>
				<el-form-item prop="passWord" label="密码">
					<el-input v-model="form.passWord" type="password" placeholder="请输入密码"></el-input>
				</el-form-item>
				<el-form-item prop="checkPassWord" label="确认密码">
					<el-input v-model="form.checkPassWord" type="password" placeholder="请再次输入密码"></el-input>
				</el-form-item>
				<!--<el-form-item prop="email" label="邮箱">-->
					<!--<el-input v-model="form.email" placeholder="请输入邮箱"></el-input>-->
				<!--</el-form-item>-->
				<!--<el-form-item prop="phone" label="手机">-->
					<!--<el-input v-model="form.phone" placeholder="请输入手机号"></el-input>-->
				<!--</el-form-item>-->
				<!--<el-form-item prop="card" label="身份证">-->
					<!--<el-input v-model="form.card" placeholder="请输入身份证号"></el-input>-->
				<!--</el-form-item>-->
				<!--<el-form-item prop="birth" label="出生日期">-->
					<!--<el-col :span="24">-->
						<!--<el-date-picker type="date" placeholder="选择日期" v-model="form.birth" value-format="yyyy-MM-dd" style="width: 100%;"></el-date-picker>-->
					<!--</el-col>-->
				<!--</el-form-item>-->
				<!--<el-form-item prop="sex" label="性别">-->
					<!--<el-select class="select-sex" v-model="form.sex" placeholder="请选择性别">-->
						<!--<el-option label="男" value="man"></el-option>-->
						<!--<el-option label="女" value="woman"></el-option>-->
					<!--</el-select>-->
				<!--</el-form-item>-->
				<el-form-item>
					<el-button type="primary" @click="onSubmit('form')">确定</el-button>
					<el-button @click="onCancle()">取消</el-button>
				</el-form-item>
			</el-form>
		</div>
	</div>
</template>

<script>
	import Util from '../../utils/utils';
	export default {
		data() {
            var validateStudentName = (rule, value, callback) => {
                    if(value.toString().length === 0) {
                        callback(new Error('请输入正确的学生姓名'));
                    }else{
                        this.$refs.form.validateField('studentID');
                    }
                callback();
            };
            var validateStudentID = (rule, value, callback) => {
                if(value.toString().length !== 12) {
                    callback(new Error('请输入正确的学号1'));
                } else {
                    for(var i=0;i<value.toString().length;i=i+1){
                        if(value.toString()[i]!=='0'&& value.toString()[i]!=='1'&&
                            value.toString()[i]!=='2'&&value.toString()[i]!=='3'&&
                            value.toString()[i]!=='4'&&value.toString()[i]!=='9'&&
                            value.toString()[i]!=='8'&&value.toString()[i]!=='7'&&
                            value.toString()[i]!=='6'&&value.toString()[i]!=='5')
                        {callback(new Error('请输入正确的学号2'));}else{
                            // console.lo`g(value.toString()[i])
                            continue;
                        }
                    }
                    this.$refs.form.validateField('passWord');
                }
                callback();
            };
			var validatePassWord = (rule, value, callback) => {
				if(value === '') {
					callback(new Error('请输入密码'));
				} else {
					if(this.form.checkPass !== '') {
						this.$refs.form.validateField('checkPassWord');
					}
					callback();
				}
			};
			var validatePassWord2 = (rule, value, callback) => {
				if(value === '') {
					callback(new Error('请再次输入密码'));
				} else if (value !== this.form.passWord) {
					callback(new Error('两次输入的密码不一致'));
				} else {
					callback();
				}
			};


			// var validateEmail = (rule, value, callback) => {
			// 	if (value === '') {
			// 		callback(new Error('请输入邮箱'));
			// 	} else if (!Util.emailReg.test(this.form.email)){
			// 		callback(new Error('请输入正确的邮箱'));
			// 	} else {
			// 		callback();
			// 	}
			// };
			// var validatePhone = (rule, value, callback) => {
			// 	if (value === '') {
			// 		callback(new Error('请输入手机号'));
			// 	} else if (!Util.phoneReg.test(this.form.phone)){
			// 		callback(new Error('请输入正确的手机号'));
			// 	} else {
			// 		callback();
			// 	}
			// };
			// var validateCard = (rule, value, callback) => {
			// 	if (value === '') {
			// 		callback(new Error('请输入身份证号'));
			// 	} else if (!Util.idCardReg.test(this.form.card)){
			// 		callback(new Error('请输入正确的身份证号'));
			// 	} else {
			// 		callback();
			// 	}
			// };
            return {
				form: {
					studentName: '',
                    studentID: '',
					passWord: '',
					checkPassWord: '',
					// email: '',
					// phone: '',
					// card: '',
					// birth: '',
					// sex: ''
                },
                rules: {
                    studentName: [
                        { validator: validateStudentName, trigger: 'blur' }
                    ],
                    studentID: [
                        { validator: validateStudentID, trigger: 'blur' }
                    ],
                    passWord: [
                        { validator: validatePassWord, trigger: 'blur' }
                    ],
                    checkPassWord: [
                        { validator: validatePassWord2, trigger: 'blur' }
                    ]
                    // email: [
                    //     { validator: validateEmail, trigger: 'blur' }
                    // ],
                    // phone: [
                    //     { validator: validatePhone, trigger: 'blur' }
                    // ],
                    // card: [
                    //     { validator: validateCard, trigger: 'blur' }
                    // ],
                    // birth: [
                    //     { required: true, message: '请输入出生日期',type: 'date', trigger: 'blur' }
                    // ],
                    // sex: [
                    //     { required: true, message: '请输入性别', trigger: 'blur' }
                    // ]
                }
			}
        },
        methods:{
        	onSubmit(formName) {
				const self = this;
				self.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.$http.post('/api/user/addUser',self.form).then(function(response) {
							console.log(response);
							self.$router.push('/register-success');
						}).then(function(error) {
							console.log(error);
						})
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });

        	},
        	onCancle() {
        		this.$router.push('/index');
			},
			getDateTimes(str) {
				var str = new Date(str);
        		return str;
			}
        }
	}
</script>

<style>
	.crumbs-register {
		background-color: #324157;
		height: 50px;
		line-height: 50px;
	}
	.register-title {
		line-height: 50px;
		margin: 0 auto;
    	width: 50px;
    	font-size: 16px;
	}
	.userContent {
		width: 400px;
		margin: 0 auto;
	}
	.select-sex {
		width: 320px;
	}
</style>
