within IndustrialControlSystems.Controllers.Digital;
model PID_2dof "Digital 2-dof PID controller"
  extends Interfaces.Controller;
  parameter Real Kp = 1 "|Parameters| Gain";
  parameter Real Ti = 10 "|Parameters| Integral time";
  parameter Real Td = 0 "|Parameters| Derivative time";
  parameter Real N = 5 "|Parameters| Derivative filter ratio";
  parameter Real b = 1 "|Parameters| SP weight in P action";
  parameter Real c = 0 "|Parameters| SP weight in D action";
protected
  discrete Real sp;
  discrete Real dsp;
  discrete Real pv;
  discrete Real dpv;
  discrete Real dp;
  discrete Real di;
  discrete Real d;
  discrete Real dd;
  discrete Real cs;
  discrete Real dcs;
algorithm
  when sample(0,Ts) then

    // read the inputs
    sp  := SP;
    pv  := PV;
    dsp := sp - pre(sp);
    dpv := pv - pre(pv);

    if (not ts) and (not man) then
      // automatic mode
      dp  := Kp*(b*dsp-dpv);
      di  := Kp*Ts/Ti*(sp-pv);
      d   := (Td*pre(d)+Kp*N*Td*(c*dsp-dpv))/(if Td>0 then Td+N*Ts else 1);
      dd  := d - pre(d);
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

    // Output assignment
    CS := cs;

  end when;
       annotation (Diagram(graphics),         Icon(graphics={Text(
          extent={{-68,26},{70,-22}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="PID")}),Documentation(info="
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
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end PID_2dof;
