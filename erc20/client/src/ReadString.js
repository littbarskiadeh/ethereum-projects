import React from "react";

class ReadString extends React.Component {
    state = { dataKey: null };

    componentDidMount() {
        const { drizzle } = this.props;
        const contract = drizzle.contracts.HCoin;

        
        console.log(this.props.drizzle);
        console.log(this.props.drizzleState);

        // let drizzle know we want to watch the `standard` public method
        const dataKey = contract.methods["standard"].cacheCall();

        // save the `dataKey` to local component state for later reference
        this.setState({ dataKey });
    }

    render() {
        // get the contract state from drizzleState
        const { HCoin } = this.props.drizzleState.contracts;

        // using the saved `dataKey`, get the variable we're interested in
        const myString = HCoin.standard[this.state.dataKey];

        // if it exists, then we display its value
        return <p>Coin Standard: {myString && myString.value}</p>;
    }
}

export default ReadString;