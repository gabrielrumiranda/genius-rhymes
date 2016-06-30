const React = require('react');
const SignupForm = require('../auth/signup_form');
const LoginForm = require('../auth/login_form');
const Modal = require('react-modal');

const HeaderAuth = React.createClass({
  getInitialState() {
    return {
      modalOpen: false,
      form: "signup"
    };
  },

  openSignup(){
    this.setState({ form: "signup" });
    this.openModal();
  },

  openSignin(){
    this.setState({ form: "signin" });
    this.openModal();
  },

  closeModal(){
    this.setState({ modalOpen: false });
  },

  openModal(){
    this.setState({ modalOpen: true });
  },

  render(){
    let signupOrSignin;
    if (this.state.form === "signup") {
      signupOrSignin = <SignupForm />;
    } else {
      signupOrSignin = <LoginForm />;
    }

    const style = {
      overlay : {
        position        : 'fixed',
        top             : 0,
        left            : 0,
        right           : 0,
        bottom          : 0,
        backgroundColor : 'rgba(255, 255, 255, 0)',
        zIndex          : 10
      },
      content : {
        position        : 'absolute',
        top             : '40px',
        right           : '0px',
        left            : '80%',
        height          : '150px',
        border          : 'none',
        padding         : '20px',
        zIndex          : 11
      }
    };

    return(
      <ul className="auth-nav">
        <li className="auth" onClick={this.openSignup}>
          Sign Up
        </li>

        <li className="auth" onClick={this.openSignin}>
          Sign In
        </li>
        <Modal
          isOpen={this.state.modalOpen}
          onRequestClose={this.closeModal}
          style={style}>
          {signupOrSignin}

        </Modal>

      </ul>
    );
  },
});

module.exports = HeaderAuth;
