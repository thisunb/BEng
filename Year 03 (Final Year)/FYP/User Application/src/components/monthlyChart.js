import React from 'react';
import '../css/weeklyChart.css';
import {LineChart, CartesianGrid, XAxis, YAxis, Tooltip, Line} from 'recharts';

class MonthlyChart extends React.Component {

    constructor(props){
        super(props);
    }

    render() {  
        return(
            <div className='chart-container'>
                <div className="chart-item-name">{this.props.month} <br/> ({this.props.item_name}) </div>
                    <LineChart className='chart-inner-container' key={1} width={450} height={350} data={this.props.data} margin={{top: 10, right: 60, left: 10, bottom: 60}}>
                        <CartesianGrid stroke="grey" strokeDasharray="1 10" fill='#131414'/>
                        <XAxis tick={{fill: "white", dy: 30}} dataKey="date" angle={-45} label={{value: "Date", position: "center", dx: 0, dy: 90, fill:"white"}}/>
                        <YAxis domain={['dataMin', 'dataMax']} tick={{fill: "white"}} dataKey="Price" label={{value: "Price", position: "center", angle: -90, dy: 0, dx: -20, fill:"white"}} />
                        <Tooltip itemStyle={{color:"red"}}/>
                        <Line type="monotone" dataKey="Price" strokeWidth={3} stroke="green" dot={false} />
                    </LineChart>    
            </div>
        );
    }
}

export default MonthlyChart;