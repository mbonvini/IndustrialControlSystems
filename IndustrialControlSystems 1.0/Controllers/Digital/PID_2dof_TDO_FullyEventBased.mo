within IndustrialControlSystems.Controllers.Digital;
model PID_2dof_TDO_FullyEventBased
  "Digital 2-dof PID controller with event based Time Division Output (TDO)"
  extends Interfaces.Controller;
  parameter Real Kp = 1 "|Parameters| Gain";
  parameter Real Ti = 10 "|Parameters| Integral time";
  parameter Real Td = 0 "|Parameters| Derivative time";
  parameter Real N = 5 "|Parameters| Derivative filter ratio";
  parameter Real b = 1 "|Parameters| SP weight in P action";
  parameter Real c = 0 "|Parameters| SP weight in D action";
  parameter Real TDsteps = 100 "|Parameters| Time Division Output resolution";
  Real counter;
  Real cs;
protected
  Real sp;
  Real dsp;
  Real pv;
  Real dpv;
  Real dp;
  Real di;
  Real d;
  Real dd;
  Real dcs;

  Real spo;
  Real pvo;
  Real dold;
  Real cso;
  Real nextEventTime;

algorithm
  when sample(0,Ts) then

      // read the inputs
      counter :=0;
      sp  := SP;
      pv  := PV;
      dsp := sp - spo;
      dpv := pv - pvo;

      if (not ts) and (not man) then
        // automatic mode
        dp  := Kp*(b*dsp-dpv);
        di  := Kp*Ts/Ti*(sp-pv);
        d   := (Td*pre(d)+Kp*N*Td*(c*dsp-dpv))/(if Td>0 then Td+N*Ts else 1);
        dd  := d - dold;
        dcs := dp + di + dd + bias - pre(bias);
        cs  := pre(cs) + dcs;
      elseif man then
        // manual mode
        // (Manual has an higher priority with respect to tracking)
        cs  := pre(cs) + csInc;
      else
        // tracking mode
        cs := tr;
      end if;

      // Forbid increment
      if F_inc and (not man) and cs > pre(cs) then
        cs := pre(cs);
      end if;
      // Forbid decrement
      if F_dec and (not man) and cs < pre(cs) then
        cs := pre(cs);
      end if;

      // saturation
      if cs > CSmax and AntiWindup then
      cs     := CSmax;
      satHI  := true;
      satLOW := false;
    else
      satHI := false;
    end if;
    if cs < CSmin and AntiWindup then
      cs     := CSmin;
      satLOW := true;
      satHI  := false;
    else
      satLOW := false;
    end if;

      // store the old values
      spo     := sp;
      pvo     := pv;
      cso     := cs;
      dold    := d;

      // define the output and compute the
      // time division output
      if cs<=CSmin then
        CS := CSmin;
        nextEventTime := time+Ts;
      elseif cs>=CSmax then
        CS := CSmax;
        nextEventTime := time+Ts;
      else
        CS := CSmax;
        nextEventTime := time+(cs-CSmin)/(CSmax-CSmin)*Ts;
      end if;

    end when;

    // when the time is elapsed reset the output
    when time>=nextEventTime then
      if cs>CSmin and cs<CSmax then
        CS:=CSmin;
      end if;
    end when;

       annotation (Diagram(graphics),         Icon(graphics={Text(
          extent={{-68,54},{70,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="PID"),                                 Text(
          extent={{-66,-6},{72,-44}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="TDO-e")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Proportional + Integral + Derivative with two degree of freedom controller with Automatic, Tracking, Manual
  mode and bias signal. The controller is implemented in its incremental form algorithm.<br/>
  The control law is defined as
  <pre>
            [                      1                        sTd                      ]
  CS(s) = Kp[ (bSP(s) - PV(s)) + ----- (SP(s) - PV(S)) + -----------(cSP(s) - PV(s)) ]
            [                     sTi                     1 + sTd/N                  ]
  </pre>
  <br/><br/>
  
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>satHI</td><td>CS at HIGH saturation</td><td>NO</td></tr>
  <tr>  <td>satLOW</td><td>CS at LOW saturation</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>MAN</td><td>Manual Switch signal</td><td>YES (useMAN)</td></tr>
  <tr>  <td>CSinc</td><td>Control Signal increment</td><td>YES (useMAN)</td></tr>
  <tr>  <td>Finc</td><td>Forbid increment</td><td>YES (useForbid)</td></tr>
  <tr>  <td>Fdec</td><td>Forbid decrement</td><td>YES (useForbid)</td></tr>
  </table>
  <br/><br/>
  And some of them can be conditionally selected, by specifying a boolean flag.
  <br/>
  
  <h4>Time Division Output (TDO)</h4>
  The Control Signal <FONT FACE=Courier>CS</FONT> computed by the PID controller can have two values: <FONT FACE=Courier>CSmin</FONT> and <FONT FACE=Courier>CSmax</FONT>.<br>
  The result is a rectangular wave, which duty cycle is proportional to the control action computed by the controller.<br>
  The sampling time <FONT FACE=Courier>Ts</FONT> is <b>NOT</b> divided in sub intervals. The sampling time is divided in two parts, depensing on the value of the control action.<br>
  In the first part the Control Signal is at the <FONT FACE=Courier>CSmax</FONT> value, while <FONT FACE=Courier>CSmin</FONT> in the remaining one.<br>
  With such an approach very high frequency sampling is avoided.
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>CS</FONT> ) saturates
  at the values specified by <FONT FACE=Courier>CSmin</FONT> and <FONT FACE=Courier>CSmax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT> is true, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  </p>
  
  <h4>Manual mode</h4>
  If the boolean flag <FONT FACE=Courier>useMAN</FONT> is true, the inputs <FONT FACE=Courier>MAN</FONT> and <FONT FACE=Courier>CSinc</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>MAN</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> can be manually controlled via the signals 
  <FONT FACE=Courier>CSinc</FONT> and <FONT FACE=Courier>CSdec</FONT>, that respectively increment or decrement the control signal.
  
  <h4>Forbid mode</h4>
  If the boolean flag <FONT FACE=Courier>useForbid</FONT> is true, the inputs <FONT FACE=Courier>Finc</FONT> and <FONT FACE=Courier>Fdec</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>Finc</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> cannot grow up, while if 
  <FONT FACE=Courier>Fdec</FONT> is true it cannot decrease.
  </p>
  </p>
  </p>
  <h4>Discretisation</h4>
  The controller is implemented directly through an algorithm, that represents the discretised version of the continuous time controller.
  </p>
  </HTML>",
        revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end PID_2dof_TDO_FullyEventBased;
