import React from "react"
import PropTypes from "prop-types"
import axios from 'axios'

class HelloWorld extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      user_names: ['アイウエオ']
    }
  }

  componentDidMount() {
    axios.get('api/v1/admin').then((res) => {
      this.setState({
        user_names: res.data
      });
    })
  }

  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
        <ul>
          {this.state.user_names.map((name, k) => {
            return <li key={k}>{ name }</li>;
          })}
        </ul>
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};
export default HelloWorld
