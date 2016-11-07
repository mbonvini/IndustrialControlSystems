within IndustrialControlSystems.Controllers;
model I "Integral controller"
  extends Interfaces.Controller;
  parameter Real T = 1 "|Parameters| Integral time" annotation(Evaluate = true);
  Real Iout "output of the Integral block";
  Real satin "input of the saturation block";
initial equation

  if Ts > 0 then
    // Discrete time initialisation
    pre(Iout) = if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start - bias;
  else
    // Continuous time initialisation
    Iout = if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start - bias;
  end if;

equation

  if Ts > 0 then
    // Discrete time controller
    when sample(0,Ts) then
      CS    = if AntiWindup then max(CSmin,min(CSmax,(if ts then tr else satin))) else satin;
      satin = Iout + pre(bias);
      Iout = if ts then tr else
        IndustrialControlSystems.LinearSystems.Discrete.Functions.fIntegrator(
        alfa,
        SP - PV,
        pre(SP) - pre(PV),
        pre(CS) - pre(bias),
        Ts,
        1/T);
    end when;
  else
    // Continuous time controller
    CS    = if AntiWindup then max(CSmin,min(CSmax,(if ts then tr else satin))) else satin;
    satin = Iout + bias;
    if not ts then
      der(Iout)   = 1/T*(SP - PV) + 1/eps*(CS - (satin - bias));
    else
      eps*der(Iout) = -Iout + tr;
    end if;

  end if;

  annotation (Icon(graphics={Text(
          extent={{-38,26},{42,-44}},
          lineColor={0,0,255},
          textString="I")}), Diagram(graphics),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Integral controller with Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
            1
  CS(s) = ----- (SP(s) - PV(S))
           sTi
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Integrator.png\">
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (*)</td></tr>
  </table>
  (*) AutoTuning Not available here, please see the package<br>
  <a href=\"Modelica://IndustrialControlSystems.Controllers.AutoTuning\">AutoTuning</a>
  <br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the integral control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  To note that in the tracking mode the output signal CS is equal to
  <pre>
              1
  CS(s) = -------- TR(S)
           1+s*eps
  </pre> 
  where eps is a small time constant. Thanks to such a scheme, the integrator does not diverge while the tracking mode<br>
  is enabled.
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
end I;
