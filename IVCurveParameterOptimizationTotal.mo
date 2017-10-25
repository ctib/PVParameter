package ModelicaServices
  "ModelicaServices (Default implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation"
extends Modelica.Icons.Package;

package Machine

  final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";
  annotation (Documentation(info="<html>
<p>
Package in which processor specific constants are defined that are needed
by numerical algorithms. Typically these constants are not directly used,
but indirectly via the alias definition in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
</p>
</html>"));
end Machine;
annotation (
  Protection(access=Access.hide),
  preferredView="info",
  version="3.2.2",
  versionBuild=0,
  versionDate="2016-01-15",
  dateModified = "2016-01-15 08:44:41Z",
  revisionId="$Id:: package.mo 9141 2016-03-03 19:26:06Z #$",
  uses(Modelica(version="3.2.2")),
  conversion(
    noneFromVersion="1.0",
    noneFromVersion="1.1",
    noneFromVersion="1.2",
    noneFromVersion="3.2.1"),
  Documentation(info="<html>
<p>
This package contains a set of functions and models to be used in the
Modelica Standard Library that requires a tool specific implementation.
These are:
</p>

<ul>
<li> <a href=\"modelica://ModelicaServices.Animation.Shape\">Shape</a>
     provides a 3-dim. visualization of elementary
     mechanical objects. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Animation.Surface\">Surface</a>
     provides a 3-dim. visualization of
     moveable parameterized surface. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.ExternalReferences.loadResource\">loadResource</a>
     provides a function to return the absolute path name of an URI or a local file name. It is used in
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Files.loadResource</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Machine\">ModelicaServices.Machine</a>
     provides a package of machine constants. It is used in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.</li>

<li> <a href=\"modelica://ModelicaServices.Types.SolverMethod\">Types.SolverMethod</a>
     provides a string defining the integration method to solve differential equations in
     a clocked discretized continuous-time partition (see Modelica 3.3 language specification).
     It is not yet used in the Modelica Standard Library, but in the Modelica_Synchronous library
     that provides convenience blocks for the clock operators of Modelica version &ge; 3.3.</li>
</ul>

<p>
This implementation is targeted for Dymola.
</p>

<p>
<b>Licensed by DLR and Dassault Syst&egrave;mes AB under the Modelica License 2</b><br>
Copyright &copy; 2009-2016, DLR and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
end ModelicaServices;

package Modelica "Modelica Standard Library - Version 3.2.2"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Continuous
    "Library of continuous control blocks with internal states"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Package;

      block Integrator "Output the integral of the input signal"
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit="1")=1 "Integrator gain";

        /* InitialState is the default, because it was the default in Modelica 2.2
     and therefore this setting is backward compatible
  */
        parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
          "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"     annotation(Evaluate=true,
            Dialog(group="Initialization"));
        parameter Real y_start=0 "Initial or guess value of output (= state)"
          annotation (Dialog(group="Initialization"));
        extends Interfaces.SISO(y(start=y_start));

      initial equation
        if initType == Init.SteadyState then
           der(y) = 0;
        elseif initType == Init.InitialState or
               initType == Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = k*u;
        annotation (
          Documentation(info="<html>
<p>
This blocks computes output <b>y</b> (element-wise) as
<i>integral</i> of the input <b>u</b> multiplied with
the gain <i>k</i>:
</p>
<pre>
         k
     y = - u
         s
</pre>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

</html>"),       Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100.0,-100.0},{100.0,100.0}}),
              graphics={
                Line(
                  points={{-80.0,78.0},{-80.0,-90.0}},
                  color={192,192,192}),
                Polygon(
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
                Line(
                  points={{-90.0,-80.0},{82.0,-80.0}},
                  color={192,192,192}),
                Polygon(
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
                Text(
                  lineColor={192,192,192},
                  extent={{0.0,-70.0},{60.0,-10.0}},
                  textString="I"),
                Text(
                  extent={{-150.0,-150.0},{150.0,-110.0}},
                  textString="k=%k"),
                Line(
                  points={{-80.0,-80.0},{80.0,80.0}},
                  color={0,0,127})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
              Line(points={{-100,0},{-60,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{-36,60},{32,2}},
                lineColor={0,0,0},
                textString="k"),
              Text(
                extent={{-32,0},{36,-58}},
                lineColor={0,0,0},
                textString="s"),
              Line(points={{-46,0},{46,0}})}));
      end Integrator;
      annotation (
        Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks
described by differential equations.
</p>

<p>
All blocks of this package can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\"><b>Init.NoInit</b></td>
      <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

  <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
      <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialState</b></td>
      <td valign=\"top\">Initialization with initial states</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
      <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possible)</td></tr>
</table>

<p>
For backward compatibility reasons the default of all blocks is
<b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
where the default is <b>Init.InitialState</b> (this was the initialization
defined in version 2.2 of the Modelica standard library).
</p>

<p>
In many cases, the most useful initial condition is
<b>Init.SteadyState</b> because initial transients are then no longer
present. The drawback is that in combination with a non-linear
plant, non-linear algebraic equations occur that might be
difficult to solve if appropriate guess values for the
iteration variables are not provided (i.e., start values with fixed=false).
However, it is often already useful to just initialize
the linear blocks from the Continuous blocks library in SteadyState.
This is uncritical, because only linear algebraic equations occur.
If Init.NoInit is set, then the start values for the states are
interpreted as <b>guess</b> values and are propagated to the
states with fixed=<b>false</b>.
</p>

<p>
Note, initialization with Init.SteadyState is usually difficult
for a block that contains an integrator
(Integrator, LimIntegrator, PI, PID, LimPID).
This is due to the basic equation of an integrator:
</p>

<pre>
  <b>initial equation</b>
     <b>der</b>(y) = 0;   // Init.SteadyState
  <b>equation</b>
     <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation leads to the condition that the input to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is always defined by
Init.InitialState or Init.SteadyState initialization.
</p>

<p>
In such a case, <b>Init.NoInit</b> has to be selected for the integrator
and an additional initial equation has to be added to the system
to which the integrator is connected. E.g., useful initial conditions
for a 1-dim. rotational inertia controlled by a PI controller are that
<b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
</p>

</html>"),     Icon(graphics={Line(
              origin={0.061,4.184},
              points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
                  113.485},{-65.374,-61.217},{-78.061,-78.184}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Continuous;

    package Interfaces
    "Library of connectors and partial models for input/output blocks"
      import Modelica.SIunits;
      extends Modelica.Icons.InterfacesPackage;

      connector RealInput = input Real "'input Real' as connector" annotation (
        defaultComponentName="u",
        Icon(graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
          coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{-10.0,60.0},{-10.0,85.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));

      connector RealOutput = output Real "'output Real' as connector" annotation (
        defaultComponentName="y",
        Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{30.0,60.0},{30.0,110.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));

      connector RealVectorInput = input Real
        "Real input connector used for vector of connectors" annotation (
        defaultComponentName="u",
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}, coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            initialScale=0.2,
            extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-10,85},{-10,60}},
              lineColor={0,0,127},
              textString="%name"), Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Real input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialRealMISO\">PartialRealMISO</a>,
and has therefore a different icon as RealInput connector.
</p>
</html>"));

      partial block SO "Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}})));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

      end SO;

      partial block SISO "Single Input Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u "Connector of Real input signal" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}})));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}})));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
      end SISO;

      partial block SI2SO
        "2 Single Input / 1 Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u1 "Connector of Real input signal 1" annotation (Placement(
              transformation(extent={{-140,40},{-100,80}})));
        RealInput u2 "Connector of Real input signal 2" annotation (Placement(
              transformation(extent={{-140,-80},{-100,-40}})));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}})));

        annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"));

      end SI2SO;

      partial block PartialRealMISO
        "Partial block with a RealVectorInput and a RealOutput signal"

        parameter Integer significantDigits(min=1) = 3
          "Number of significant digits to be shown in dynamic diagram layer for y"
          annotation (Dialog(tab="Advanced"));
        parameter Integer nu(min=0) = 0 "Number of input connections"
          annotation (Dialog(connectorSizing=true), HideResult=true);
        Modelica.Blocks.Interfaces.RealVectorInput u[nu]
          annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-17},{134,17}})));
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              initialScale=0.06), graphics={
              Text(
                extent={{110,-50},{300,-70}},
                lineColor={0,0,0},
                textString=DynamicSelect(" ", String(y, significantDigits=
                    significantDigits))),
              Text(
                extent={{-250,170},{250,110}},
                textString="%name",
                lineColor={0,0,255}),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={255,137,0},
                lineThickness=5.0,
                fillColor={255,255,255},
                borderPattern=BorderPattern.Raised,
                fillPattern=FillPattern.Solid)}));
      end PartialRealMISO;

      partial block PartialConversionBlock
        "Partial block defining the interface for conversion blocks"

        RealInput u "Connector of Real input signal to be converted" annotation (
            Placement(transformation(extent={{-140,-20},{-100,20}})));
        RealOutput y
          "Connector of Real output signal containing input signal u in another unit"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        annotation (
          Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100.0,-100.0},{100.0,100.0}}),
              graphics={
            Rectangle(
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-100.0},{100.0,100.0}}),
            Line(
              points={{-90.0,0.0},{30.0,0.0}},
              color={191,0,0}),
            Polygon(
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid,
              points={{90.0,0.0},{30.0,20.0},{30.0,-20.0},{90.0,0.0}}),
            Text(
              lineColor={0,0,255},
              extent={{-115.0,105.0},{115.0,155.0}},
              textString="%name")}), Documentation(info="<html>
<p>
This block defines the interface of a conversion block that
converts from one unit into another one.
</p>

</html>"));

      end PartialConversionBlock;
      annotation (Documentation(info="<html>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</html>",     revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Added several new interfaces.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Interfaces;

    package Math
    "Library of Real mathematical functions as input/output blocks"
      import Modelica.SIunits;
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      encapsulated package UnitConversions
      "Conversion blocks to convert between SI and non-SI unit signals"
        import Modelica;
        import SI = Modelica.SIunits;
        import NonSI = Modelica.SIunits.Conversions.NonSIunits;
        extends Modelica.Icons.Package;

        block From_degC "Convert from degCelsius to Kelvin"
          extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit="degC"),
              y(unit="K"));
        equation
          y = SI.Conversions.from_degC(u);
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Text(
                      extent={{-20,100},{-100,20}},
                      lineColor={0,0,0},
                      textString="degC"),Text(
                      extent={{100,-20},{20,-100}},
                      lineColor={0,0,0},
                      textString="K")}), Documentation(info="<html>
<p>
This block converts the input signal from degCelsius to Kelvin and returns
the result as output signal.
</p>
</html>"));
        end From_degC;
        annotation (Documentation(info="<html>
<p>
This package consists of blocks that convert an input signal
with a specific unit to an output signal in another unit
(e.g., conversion of an angle signal from \"deg\" to \"rad\").
</p>

</html>"));
      end UnitConversions;

      block Gain "Output the product of a gain value with the input signal"

        parameter Real k(start=1, unit="1")
          "Gain value multiplied with input signal";
      public
        Interfaces.RealInput u "Input signal connector" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}})));
        Interfaces.RealOutput y "Output signal connector" annotation (Placement(
              transformation(extent={{100,-10},{120,10}})));

      equation
        y = k*u;
        annotation (
          Documentation(info="<html>
<p>
This block computes output <i>y</i> as
<i>product</i> of gain <i>k</i> with the
input <i>u</i>:
</p>
<pre>
    y = k * u;
</pre>

</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Polygon(
                points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,-140},{150,-100}},
                lineColor={0,0,0},
                textString="k=%k"),
              Text(
                extent={{-150,140},{150,100}},
                textString="%name",
                lineColor={0,0,255})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Polygon(
                  points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-76,38},{0,-34}},
                  textString="k",
                  lineColor={0,0,255})}));
      end Gain;

      block MultiSum "Sum of Reals: y = k[1]*u[1] + k[2]*u[2] + ... + k[n]*u[n]"
        extends Modelica.Blocks.Interfaces.PartialRealMISO;
        parameter Real k[nu]=fill(1, nu) "Input gains";
      equation
        if size(u, 1) > 0 then
          y = k*u;
        else
          y = 0;
        end if;

        annotation (Icon(graphics={Text(
                extent={{-200,-110},{200,-140}},
                lineColor={0,0,0},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid,
                textString="%k"), Text(
                extent={{-72,68},{92,-68}},
                lineColor={0,0,0},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid,
                textString="+")}), Documentation(info="<html>
<p>
This blocks computes the scalar Real output \"y\" as sum of the elements of the
Real input signal vector u:
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
The input connector is a vector of Real input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to zero: y=0.
</p>

</html>"));
      end MultiSum;

      block Product "Output product of the two inputs"
        extends Interfaces.SI2SO;

      equation
        y = u1*u2;
        annotation (
          Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> (element-wise)
as <i>product</i> of the corresponding elements of
the two inputs <b>u1</b> and <b>u2</b>:
</p>
<pre>
    y = u1 * u2;
</pre>

</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{-100,60},{-40,60},{-30,40}}, color={0,0,127}),
              Line(points={{-100,-60},{-40,-60},{-30,-40}}, color={0,0,127}),
              Line(points={{50,0},{100,0}}, color={0,0,127}),
              Line(points={{-30,0},{30,0}}),
              Line(points={{-15,25.99},{15,-25.99}}),
              Line(points={{-15,-25.99},{15,25.99}}),
              Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-100,60},{-40,60},{-30,
                40}}, color={0,0,255}),Line(points={{-100,-60},{-40,-60},{-30,-40}},
                color={0,0,255}),Line(points={{50,0},{100,0}}, color={0,0,255}),
                Line(points={{-30,0},{30,0}}),Line(points={{-15,
                25.99},{15,-25.99}}),Line(points={{-15,-25.99},{15,
                25.99}}),Ellipse(extent={{-50,50},{50,-50}},
                lineColor={0,0,255})}));
      end Product;

      block Sqrt "Output the square root of the input (input >= 0 required)"
        extends Interfaces.SISO;

      equation
        y = sqrt(u);
        annotation (
          defaultComponentName="sqrt1",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
              Polygon(
                points={{90,-80},{68,-72},{68,-88},{90,-80}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-80,-80},{-79.2,-68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},
                    {-67.9,-36.1},{-59.1,-22.2},{-46.2,-6.49},{-28.5,10.7},{-4.42,
                    30},{27.7,51.3},{69.5,74.7},{80,80}},
                smooth=Smooth.Bezier),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-88},{-80,68}}, color={192,192,192}),
              Text(
                extent={{-8,-4},{64,-52}},
                lineColor={192,192,192},
                textString="sqrt")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Line(points={{-92,-80},{84,-80}}, color={
                192,192,192}),Polygon(
                  points={{100,-80},{84,-74},{84,-86},{100,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-79.2,-68.7},
                {-78.4,-64},{-76.8,-57.3},{-73.6,-47.9},{-67.9,-36.1},{-59.1,-22.2},
                {-46.2,-6.49},{-28.5,10.7},{-4.42,30},{27.7,51.3},{69.5,74.7},{80,
                80}}),Polygon(
                  points={{-80,98},{-86,82},{-74,82},{-80,98}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-80,-90},{-80,84}},
                color={192,192,192}),Text(
                  extent={{-71,98},{-44,78}},
                  lineColor={160,160,164},
                  textString="y"),Text(
                  extent={{60,-52},{84,-72}},
                  lineColor={160,160,164},
                  textString="u")}),
          Documentation(info="<html>
<p>
This blocks computes the output <b>y</b>
as <i>square root</i> of the input <b>u</b>:
</p>
<pre>
    y = <b>sqrt</b>( u );
</pre>
<p>
All elements of the input vector shall be zero or positive.
Otherwise an error occurs.
</p>

</html>"));
      end Sqrt;
      annotation (Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"),     Icon(graphics={Line(
              points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
                  {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
                  {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
                  {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
                  57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Math;

    package Sources
    "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

      block Constant "Generate constant signal of type Real"
        parameter Real k(start=1) "Constant output value";
        extends Interfaces.SO;

      equation
        y = k;
        annotation (
          defaultComponentName="const",
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,0},{80,0}}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="k=%k")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,0},{80,0}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-83,92},{-30,74}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{70,-80},{94,-100}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-101,8},{-81,-12}},
                lineColor={0,0,0},
                textString="k")}),
          Documentation(info="<html>
<p>
The Real output y is a constant signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</p>
</html>"));
      end Constant;

      block Ramp "Generate ramp signal"
        parameter Real height=1 "Height of ramps";
        parameter Modelica.SIunits.Time duration(min=0.0, start=2)
          "Duration of ramp (= 0.0 gives a Step)";
        parameter Real offset=0 "Offset of output signal";
        parameter Modelica.SIunits.Time startTime=0
          "Output = offset for time < startTime";
        extends Interfaces.SO;

      equation
        y = offset + (if time < startTime then 0 else if time < (startTime +
          duration) then (time - startTime)*height/duration else height);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-40,-70},{31,38}}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="duration=%duration"),
              Line(points={{31,38},{86,38}})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,-20},{-20,-20},{50,50}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-40,-20},{-42,-30},{-38,-30},{-40,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,-20},{-40,-70}},
                color={95,95,95}),
              Polygon(
                points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,-39},{-34,-50}},
                lineColor={0,0,0},
                textString="offset"),
              Text(
                extent={{-38,-72},{6,-83}},
                lineColor={0,0,0},
                textString="startTime"),
              Text(
                extent={{-78,92},{-37,72}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{70,-80},{94,-91}},
                lineColor={0,0,0},
                textString="time"),
              Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
              Line(
                points={{-19,-20},{50,-20}},
                color={95,95,95}),
              Line(
                points={{50,50},{101,50}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{50,50},{50,-20}},
                color={95,95,95}),
              Polygon(
                points={{50,-20},{42,-18},{42,-22},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,50},{48,40},{52,40},{50,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,-20},{48,-10},{52,-10},{50,-20},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{53,23},{82,10}},
                lineColor={0,0,0},
                textString="height"),
              Text(
                extent={{-2,-21},{37,-33}},
                lineColor={0,0,0},
                textString="duration")}),
          Documentation(info="<html>
<p>
The Real output y is a ramp signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\"
     alt=\"Ramp.png\">
</p>

<p>
If parameter duration is set to 0.0, the limiting case of a Step signal is achieved.
</p>
</html>"));
      end Ramp;

      block TimeTable
        "Generate a (possibly discontinuous) signal by linear interpolation in a table"

        parameter Real table[:, 2] = fill(0.0, 0, 2)
          "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0 "Output = offset for time < startTime";
        parameter Modelica.SIunits.Time timeScale(
          min=Modelica.Constants.eps)=1 "Time scale of first table column"
          annotation (Evaluate=true);
        extends Interfaces.SO;
      protected
        Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
        Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
        Integer last(start=1) "Last used lower grid index";
        discrete SIunits.Time nextEvent(start=0, fixed=true) "Next event instant";
        discrete Real nextEventScaled(start=0, fixed=true)
          "Next scaled event instant";
        Real timeScaled "Scaled time";

        function getInterpolationCoefficients
          "Determine interpolation coefficients and next time event"
          extends Modelica.Icons.Function;
          input Real table[:, 2] "Table for interpolation";
          input Real offset "y-offset";
          input Real startTimeScaled "Scaled time-offset";
          input Real timeScaled "Actual scaled time instant";
          input Integer last "Last used lower grid index";
          input Real TimeEps
            "Relative epsilon to check for identical time instants";
          output Real a "Interpolation coefficients a (y=a*x + b)";
          output Real b "Interpolation coefficients b (y=a*x + b)";
          output Real nextEventScaled "Next scaled event instant";
          output Integer next "New lower grid index";
        protected
          Integer columns=2 "Column to be interpolated";
          Integer ncol=2 "Number of columns to be interpolated";
          Integer nrow=size(table, 1) "Number of table rows";
          Integer next0;
          Real tp;
          Real dt;
        algorithm
          next := last;
          nextEventScaled := timeScaled - TimeEps*abs(timeScaled);
          // in case there are no more time events
          tp := timeScaled + TimeEps*abs(timeScaled) - startTimeScaled;

          if tp < 0.0 then
            // First event not yet reached
            nextEventScaled := startTimeScaled;
            a := 0;
            b := offset;
          elseif nrow < 2 then
            // Special action if table has only one row
            a := 0;
            b := offset + table[1, columns];
          else

            // Find next time event instant. Note, that two consecutive time instants
            // in the table may be identical due to a discontinuous point.
            while next < nrow and tp >= table[next, 1] loop
              next := next + 1;
            end while;

            // Define next time event, if last table entry not reached
            if next < nrow then
              nextEventScaled := startTimeScaled + table[next, 1];
            end if;

            // Determine interpolation coefficients
            next0 := next - 1;
            dt := table[next, 1] - table[next0, 1];
            if dt <= TimeEps*abs(table[next, 1]) then
              // Interpolation interval is not big enough, use "next" value
              a := 0;
              b := offset + table[next, columns];
            else
              a := (table[next, columns] - table[next0, columns])/dt;
              b := offset + table[next0, columns] - a*table[next0, 1];
            end if;
          end if;
          // Take into account startTimeScaled "a*(time - startTime) + b"
          b := b - a*startTimeScaled;
        end getInterpolationCoefficients;
      algorithm
        timeScaled := time/timeScale;
        when {time >= pre(nextEvent),initial()} then
          (a,b,nextEventScaled,last) := getInterpolationCoefficients(
              table,
              offset,
              startTime/timeScale,
              timeScaled,
              last,
              100*Modelica.Constants.eps);
          nextEvent := nextEventScaled*timeScale;
        end when;
      equation
        y = a*timeScaled + b;
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-48,70},{2,-50}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},
                    {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="offset=%offset")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-85,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{88,-70},{68,-65},{68,-74},{88,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,90},{30,-30}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-20,-30},{-20,90},{80,90},{80,-30},{-20,-30},{-20,0},{
                    80,0},{80,30},{-20,30},{-20,60},{80,60},{80,90},{30,90},{30,-31}}),
              Text(
                extent={{-70,-42},{-32,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Polygon(
                points={{-31,-30},{-33,-40},{-28,-40},{-31,-30}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-31,-70},{-34,-60},{-29,-60},{-31,-70},{-31,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-31,-32},{-31,-70}}, color={95,95,95}),
              Line(points={{-20,-30},{-20,-70}}, color={95,95,95}),
              Text(
                extent={{-38,-73},{8,-83}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{-20,-30},{-80,-30}}, color={95,95,95}),
              Text(
                extent={{-76,93},{-44,75}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{66,-78},{90,-88}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-15,83},{24,68}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{33,83},{76,67}},
                lineColor={0,0,0},
                textString="y")}),
              Documentation(info="<html>
<p>
This block generates an output signal by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<strong><code>table[i,j]</code></strong>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following properties:
</p>
<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    <b>extrapolation</b> through the last or first two points of the
    table.</li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the function value is just returned independently of the
    actual time instant.</li>
<li>Via parameters <strong><code>startTime</code></strong> and <strong><code>offset</code></strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.</li>
<li>The first point in time <strong>always</strong> has to be set to <strong><code>0</code></strong>, e.g.,
    <strong><code>table=[1,1;2,2]</code></strong> is <strong>illegal</strong>. If you want to
    shift the time table in time use the  <strong><code>startTime</code></strong> parameter instead.</li>
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
<li>Via parameter <b>timeScale</b> the first column of the table array can
    be scaled, e.g. if the table array is given in hours (instead of seconds)
    <b>timeScale</b> shall be set to 3600.</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</p>

</html>",     revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><i>Oct. 21, 2002</i>
       by Christian Schweiger:<br>
       Corrected interface from
<pre>
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre>
       to
<pre>
    parameter Real table[:, <b>2</b>]=[0, 0; 1, 1; 2, 4];
</pre>
       </li>
<li><i>Nov. 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
      end TimeTable;
      annotation (Documentation(info="<html>
<p>
This package contains <b>source</b> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>offset</b></td>
      <td valign=\"top\">Value which is added to the signal</td>
  </tr>
  <tr><td valign=\"top\"><b>startTime</b></td>
      <td valign=\"top\">Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Sources;

    package Types
    "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.TypesPackage;

      type Init = enumeration(
          NoInit
            "No initialization (start values are used as guess values with fixed=false)",
          SteadyState
            "Steady state initialization (derivatives of states are zero)",
          InitialState "Initialization with initial states",
          InitialOutput
            "Initialization with initial outputs (and steady state of the states if possible)")
        "Enumeration defining initialization of a block" annotation (Evaluate=true,
        Documentation(info="<html>
  <p>The following initialization alternatives are available:</p>
  <dl>
    <dt><code><strong>NoInit</strong></code></dt>
      <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
    <dt><code><strong>SteadyState</strong></code></dt>
      <dd>Steady state initialization (derivatives of states are zero)</dd>
    <dt><code><strong>InitialState</strong></code></dt>
      <dd>Initialization with initial states</dd>
    <dt><code><strong>InitialOutput</strong></code></dt>
      <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
  </dl>
</html>"));
      annotation (Documentation(info="<html>
<p>
In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</html>"));
    end Types;

    package Icons "Icons for Blocks"
        extends Modelica.Icons.IconsPackage;

        partial block Block "Basic graphical layout of input/output block"

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-100,-100},{100,100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));

        end Block;
    end Icons;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(
          origin={-51.25,0.0},
          points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(
          origin={51.25,0.0},
          points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
</dl>
<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapted all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       New subpackage Examples, additional components.
       </li>
<li><i>June 20, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
  end Blocks;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  package Icons "Icons for Math"
    extends Modelica.Icons.IconsPackage;

    partial function AxisCenter
      "Basic icon for mathematical function with y-axis in the center"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-80},{0,68}}, color={192,192,192}),
            Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(graphics={Line(points={{0,80},{-8,80}}, color={95,95,95}),Line(
              points={{0,-80},{-8,-80}}, color={95,95,95}),Line(points={{0,-90},{
              0,84}}, color={95,95,95}),Text(
                  extent={{5,104},{25,84}},
                  lineColor={95,95,95},
                  textString="y"),Polygon(
                  points={{0,98},{-6,82},{6,82},{0,98}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
    end AxisCenter;
  end Icons;

  function exp "Exponential, base e"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u;
    output Real y;

  external "builtin" y = exp(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
          Polygon(
            points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
                {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}}),
          Text(
            extent={{-86,50},{-14,2}},
            lineColor={192,192,192},
            textString="exp")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,-80.3976},{84,-80.3976}},
            color={95,95,95}),Polygon(
              points={{98,-80.3976},{82,-74.3976},{82,-86.3976},{98,-80.3976}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{
              34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,
              18.6},{72,38.2},{76,57.6},{80,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-31,72},{-11,88}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-92,-81},{-72,-101}},
              textString="-3",
              lineColor={0,0,255}),Text(
              extent={{66,-81},{86,-101}},
              textString="3",
              lineColor={0,0,255}),Text(
              extent={{2,-69},{22,-89}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{78,-54},{98,-74}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{0,80},{88,80}},
              color={175,175,175}),Line(
              points={{80,84},{80,-84}},
              color={175,175,175})}),
      Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</p>
</html>"));
  end exp;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
              {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
              -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
              -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
              {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
              0,0,0}, smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<dl>
<dt><b>Main Authors:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
    Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
</dl>

<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
  end Math;

  package Utilities
  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)"
    extends Modelica.Icons.Package;

    package Files "Functions to work with files and directories"
      extends Modelica.Icons.Package;

    function removeFile "Remove file (ignore call, if it does not exist)"
      extends Modelica.Icons.Function;
      input String fileName "Name of file that should be removed";
      protected
      Types.FileType fileType = Modelica.Utilities.Internal.FileSystem.stat(
                                              fileName);
    algorithm
      if fileType == Types.FileType.RegularFile then
         Streams.close(fileName);
         Modelica.Utilities.Internal.FileSystem.removeFile(
                             fileName);
      elseif fileType == Types.FileType.Directory then
         Streams.error("File \"" + fileName + "\" should be removed.\n" +
                       "This is not possible, because it is a directory");
      elseif fileType == Types.FileType.SpecialFile then
         Streams.error("File \"" + fileName + "\" should be removed.\n" +
                       "This is not possible, because it is a special file (pipe, device, etc.)");
      end if;

      annotation (__ModelicaAssociation_Impure=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Files.<b>removeFile</b>(fileName);
</pre></blockquote>
<h4>Description</h4>
<p>
Removes the file \"fileName\". If \"fileName\" does not exist,
the function call is ignored. If \"fileName\" exists but is
no regular file (e.g., directory, pipe, device, etc.) an
error is triggered.
</p>
<p>
This function is silent, i.e., it does not print a message.
</p>
</html>"));
    end removeFile;
        annotation (
    Documentation(info="<html>
<p>
This package contains functions to work with files and directories.
As a general convention of this package, '/' is used as directory
separator both for input and output arguments of all functions.
For example:
</p>
<pre>
   exist(\"Modelica/Mechanics/Rotational.mo\");
</pre>
<p>
The functions provide the mapping to the directory separator of the
underlying operating system. Note, that on Windows system the usage
of '\\' as directory separator would be inconvenient, because this
character is also the escape character in Modelica and C Strings.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.list\">list</a>(name)</td>
      <td valign=\"top\"> List content of file or of directory.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.copy\">copy</a>(oldName, newName)<br>
          <a href=\"modelica://Modelica.Utilities.Files.copy\">copy</a>(oldName, newName, replace=false)</td>
      <td valign=\"top\"> Generate a copy of a file or of a directory.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.move\">move</a>(oldName, newName)<br>
          <a href=\"modelica://Modelica.Utilities.Files.move\">move</a>(oldName, newName, replace=false)</td>
      <td valign=\"top\"> Move a file or a directory to another place.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.remove\">remove</a>(name)</td>
      <td valign=\"top\"> Remove file or directory (ignore call, if it does not exist).</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.removeFile\">removeFile</a>(name)</td>
      <td valign=\"top\"> Remove file (ignore call, if it does not exist)</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.createDirectory\">createDirectory</a>(name)</td>
      <td valign=\"top\"> Create directory (if directory already exists, ignore call).</td>
  </tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Files.exist\">exist</a>(name)</td>
      <td valign=\"top\"> Inquire whether file or directory exists.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Files.assertNew\">assertNew</a>(name,message)</td>
      <td valign=\"top\"> Trigger an assert, if a file or directory exists.</td>
  </tr>
  <tr><td valign=\"top\">fullName = <a href=\"modelica://Modelica.Utilities.Files.fullPathName\">fullPathName</a>(name)</td>
      <td valign=\"top\"> Get full path name of file or directory name.</td>
  </tr>
  <tr><td valign=\"top\">(directory, name, extension) = <a href=\"modelica://Modelica.Utilities.Files.splitPathName\">splitPathName</a>(name)</td>
      <td valign=\"top\"> Split path name in directory, file name kernel, file name extension.</td>
  </tr>
  <tr><td valign=\"top\">fileName = <a href=\"modelica://Modelica.Utilities.Files.temporaryFileName\">temporaryFileName</a>()</td>
      <td valign=\"top\"> Return arbitrary name of a file that does not exist<br>
           and is in a directory where access rights allow to <br>
           write to this file (useful for temporary output of files).</td>
  </tr>
</table>
</html>"));
    end Files;

    package Streams "Read from files and write to files"
      extends Modelica.Icons.Package;

      function print "Print string to terminal or file"
        extends Modelica.Icons.Function;
        input String string="" "String to be printed";
        input String fileName=""
          "File where to print (empty string is the terminal)"
                     annotation(Dialog(saveSelector(filter="Text files (*.txt)",
                            caption="Text file to store the output of print(..)")));
      external "C" ModelicaInternal_print(string, fileName) annotation(Library="ModelicaExternalC");

        annotation (__ModelicaAssociation_Impure=true, Documentation(info=
                       "<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>print</b>(string);
Streams.<b>print</b>(string,fileName);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>print</b>(..) opens automatically the given file, if
it is not yet open. If the file does not exist, it is created.
If the file does exist, the given string is appended to the file.
If this is not desired, call \"Files.remove(fileName)\" before calling print
(\"remove(..)\" is silent, if the file does not exist).
The Modelica environment may close the file whenever appropriate.
This can be enforced by calling <b>Streams.close</b>(fileName).
After every call of \"print(..)\" a \"new line\" is printed automatically.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.print(\"x = \" + String(x));
  Streams.print(\"y = \" + String(y));
  Streams.print(\"x = \" + String(y), \"mytestfile.txt\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.error\">Streams.error</a>,
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"));
      end print;

      function error "Print error message and cancel all actions"
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string) annotation(Library="ModelicaExternalC");
        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>error</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Print the string \"string\" as error message and
cancel all actions. Line breaks are characterized
by \"\\n\" in the string.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"));
      end error;

      function close "Close file"
        extends Modelica.Icons.Function;
        input String fileName "Name of the file that shall be closed"
                     annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                            caption="Close text file")));
        external "C" ModelicaStreams_closeFile(fileName) annotation(Library="ModelicaExternalC");
        annotation (__ModelicaAssociation_Impure=true, Documentation(info=
                       "<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>close</b>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Close file if it is open. Ignore call if
file is already closed or does not exist.
</p>
</html>"));
      end close;
      annotation (
        Documentation(info="<html>
<h4>Library content</h4>
<p>
Package <b>Streams</b> contains functions to input and output strings
to a message window or on files, as well as reading matrices from file
and writing matrices to file. Note that a string is interpreted
and displayed as html text (e.g., with print(..) or error(..))
if it is enclosed with the Modelica html quotation, e.g.,
</p>
<blockquote><p>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</p></blockquote>
<p>
It is a quality of implementation, whether (a) all tags of html are supported
or only a subset, (b) how html tags are interpreted if the output device
does not allow to display formatted text.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td valign=\"top\"> Print string \"string\" or vector of strings to message window or on
           file \"fileName\".</td>
  </tr>
  <tr><td valign=\"top\">stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td valign=\"top\"> Read complete text file and return it as a vector of strings.</td>
  </tr>
  <tr><td valign=\"top\">(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td valign=\"top\">Returns from the file the content of line lineNumber.</td>
  </tr>
  <tr><td valign=\"top\">lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td valign=\"top\">Returns the number of lines in a file.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td valign=\"top\"> Print error message \"string\" to message window
           and cancel all actions</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td valign=\"top\"> Close file if it is still open. Ignore call if
           file is already closed or does not exist. </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>(fileName, matrixName)</td>
      <td valign=\"top\"> Read dimensions of a Real matrix from a MATLAB MAT file. </td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>(fileName, matrixName, nrow, ncol)</td>
      <td valign=\"top\"> Read a Real matrix from a MATLAB MAT file. </td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>(fileName, matrixName, matrix, append, format)</td>
      <td valign=\"top\"> Write Real matrix to a MATLAB MAT file. </td></tr>
</table>
<p>
Use functions <b>scanXXX</b> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
to parse a string.
</p>
<p>
If Real, Integer or Boolean values shall be printed
or used in an error message, they have to be first converted
to strings with the builtin operator
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>(...).
Example:
</p>
<pre>
  <b>if</b> x &lt; 0 <b>or</b> x &gt; 1 <b>then</b>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <b>end if</b>;
</pre>
</html>"));
    end Streams;

    package Types "Type definitions used in package Modelica.Utilities"
      extends Modelica.Icons.TypesPackage;

      type FileType = enumeration(
          NoFile "No file exists",
          RegularFile "Regular file",
          Directory "Directory",
          SpecialFile "Special file (pipe, FIFO, device, etc.)")
        "Enumeration defining the type of a file";
      annotation (Documentation(info="<html>
<p>
This package contains type definitions used in Modelica.Utilities.
</p>

</html>"));
    end Types;

    package Internal
    "Internal components that a user should usually not directly utilize"
      extends Modelica.Icons.InternalPackage;

    package FileSystem
      "Internal package with external functions as interface to the file system"
     extends Modelica.Icons.InternalPackage;

      function stat "Inquire file information (POSIX function 'stat')"
        extends Modelica.Icons.Function;
        input String name "Name of file, directory, pipe etc.";
        output Types.FileType fileType "Type of file";
      external "C" fileType = ModelicaInternal_stat(name) annotation(Library="ModelicaExternalC");
      annotation(__ModelicaAssociation_Impure=true);
      end stat;

      function removeFile "Remove existing file (C function 'remove')"
        extends Modelica.Icons.Function;
        input String fileName "File to be removed";
      external "C" ModelicaInternal_removeFile(fileName) annotation(Library="ModelicaExternalC");
      annotation(__ModelicaAssociation_Impure=true);
      end removeFile;
      annotation (
    Documentation(info="<html>
<p>
Package <b>Internal.FileSystem</b> is an internal package that contains
low level functions as interface to the file system.
These functions should not be called directly in a scripting
environment since more convenient functions are provided
in packages Files and Systems.
</p>
<p>
Note, the functions in this package are direct interfaces to
functions of POSIX and of the standard C library. Errors
occurring in these functions are treated by triggering
a Modelica assert. Therefore, the functions in this package
return only for a successful operation. Furthermore, the
representation of a string is hidden by this interface,
especially if the operating system supports Unicode characters.
</p>
</html>"));
    end FileSystem;
    end Internal;
      annotation (
  Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={1.3835,-4.1418},
        rotation=45.0,
        fillColor={64,64,64},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
      Polygon(
        origin={10.1018,5.218},
        rotation=-45.0,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}),
  Documentation(info="<html>
<p>
This package contains Modelica <b>functions</b> that are
especially suited for <b>scripting</b>. The functions might
be used to work with strings, read data from file, write data
to file or copy, move and remove files.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.UsersGuide\">Modelica.Utilities.User's Guide</a>
     discusses the most important aspects of this library.</li>
<li> <a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
The following main sublibraries are available:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.Files\">Files</a>
     provides functions to operate on files and directories, e.g.,
     to copy, move, remove files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>
     provides functions to read from files and write to files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
     provides functions to operate on strings. E.g.
     substring, find, replace, sort, scanToken.</li>
<li> <a href=\"modelica://Modelica.Utilities.System\">System</a>
     provides functions to interact with the environment.
     E.g., get or set the working directory or environment
     variables and to send a command to the default shell.</li>
</ul>

<p>
Copyright &copy; 1998-2016, Modelica Association, DLR, and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
  end Utilities;

  package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    final constant Real eps=ModelicaServices.Machine.eps
      "Biggest number such that 1.0 + eps = 1.0";

    final constant SI.FaradayConstant F = 9.648533289e4
      "Faraday constant, C/mol (previous value: 9.64853399e4)";

    final constant Real R(final unit="J/(mol.K)") = 8.3144598
      "Molar gas constant (previous value: 8.314472)";

    final constant Real N_A(final unit="1/mol") = 6.022140857e23
      "Avogadro constant (previous value: 6.0221415e23)";

    final constant NonSI.Temperature_degC T_zero=-273.15
      "Absolute zero temperature";
    annotation (
      Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr, David B. Newell, and Barry N. Taylor:</dt>
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 2014</b>.
<a href= \"http://dx.doi.org/10.5281/zenodo.22826\">http://dx.doi.org/10.5281/zenodo.22826</a>, 2015. See also <a href=
\"http://physics.nist.gov/cuu/Constants/index.html\">http://physics.nist.gov/cuu/Constants/index.html</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>Nov 4, 2015</i>
       by Thomas Beutlich:<br>
       Constants updated according to 2014 CODATA values.</li>
<li><i>Nov 8, 2004</i>
       by Christian Schweiger:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><i>Dec 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sep 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><i>Nov 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"),
      Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Polygon(
          origin={-9.2597,25.6673},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={-19.9923,-8.3993},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={23.753,-11.5422},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
          smooth=Smooth.Bezier)}));
  end Constants;

  package Icons "Library of icons"
    extends Icons.Package;

    partial package ExamplesPackage
      "Icon for packages containing runnable examples"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              origin={8.0,14.0},
              lineColor={78,138,73},
              fillColor={78,138,73},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}), Documentation(info="<html>
<p>This icon indicates a package that contains executable examples.</p>
</html>"));
    end ExamplesPackage;

    partial model Example "Icon for runnable examples"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent = {{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Documentation(info="<html>
<p>This icon indicates an example. The play button suggests that the example can be executed.</p>
</html>"));
    end Example;

    partial package Package "Icon for standard packages"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0)}),   Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package BasesPackage "Icon for packages containing base classes"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              extent={{-30.0,-30.0},{30.0,30.0}},
              lineColor={128,128,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon shall be used for a package/library that contains base models and classes, respectively.</p>
</html>"));
    end BasesPackage;

    partial package InterfacesPackage "Icon for packages containing interfaces"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={20.0,0.0},
              lineColor={64,64,64},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              points={{-10.0,70.0},{10.0,70.0},{40.0,20.0},{80.0,20.0},{80.0,-20.0},{40.0,-20.0},{10.0,-70.0},{-10.0,-70.0}}),
            Polygon(fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-100.0,20.0},{-60.0,20.0},{-30.0,70.0},{-10.0,70.0},{-10.0,-70.0},{-30.0,-70.0},{-60.0,-20.0},{-100.0,-20.0}})}),
                                Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
    end InterfacesPackage;

    partial package SourcesPackage "Icon for packages containing sources"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={23.3333,0.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
            Rectangle(
              fillColor = {128,128,128},
              pattern = LinePattern.None,
              fillPattern = FillPattern.Solid,
              extent = {{-70,-4.5},{0,4.5}})}),
                                Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
    end SourcesPackage;

    partial package TypesPackage "Icon for packages containing type definitions"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-12.167,-23},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{12.167,65},{14.167,93},{36.167,89},{24.167,20},{4.167,-30},
                  {14.167,-30},{24.167,-30},{24.167,-40},{-5.833,-50},{-15.833,
                  -30},{4.167,20},{12.167,65}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Polygon(
              origin={2.7403,1.6673},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{49.2597,22.3327},{31.2597,24.3327},{7.2597,18.3327},{-26.7403,
                10.3327},{-46.7403,14.3327},{-48.7403,6.3327},{-32.7403,0.3327},{-6.7403,
                4.3327},{33.2597,14.3327},{49.2597,14.3327},{49.2597,22.3327}},
              smooth=Smooth.Bezier)}));
    end TypesPackage;

    partial package IconsPackage "Icon for packages containing icons"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}},
              lineColor={0,0,0})}));
    end IconsPackage;

    partial package InternalPackage
      "Icon for an internal package (indicating that the package should not be directly utilized by user)"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            lineColor={215,215,215},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25),
          Rectangle(
            lineColor={215,215,215},
            extent={{-100,-100},{100,100}},
            radius=25),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={215,215,215},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-55,55},{55,-55}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,14},{60,-14}},
            lineColor={215,215,215},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            rotation=45)}),
      Documentation(info="<html>

<p>
This icon shall be used for a package that contains internal classes not to be
directly utilized by a user.
</p>
</html>"));
    end InternalPackage;

    partial function Function "Icon for functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-150,105},{150,145}},
              textString="%name"),
            Ellipse(
              lineColor = {108,88,49},
              fillColor = {255,215,136},
              fillPattern = FillPattern.Solid,
              extent = {{-100,-100},{100,100}}),
            Text(
              lineColor={108,88,49},
              extent={{-90.0,-90.0},{90.0,90.0}},
              textString="f")}),
    Documentation(info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
    end Function;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}},
              lineColor={0,0,0})}), Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>

<h4>Main Authors:</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
    <dd>Oberpfaffenhofen</dd>
    <dd>Postfach 1116</dd>
    <dd>D-82230 Wessling</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
<dt>Christian Kral</dt>

    <dd>  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
</dd>
    <dd>1060 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>Copyright &copy; 1998-2016, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    package Icons "Icons for SIunits"
      extends Modelica.Icons.IconsPackage;

      partial function Conversion "Base icon for conversion functions"

        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={191,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{30,0}}, color={191,0,0}),
              Polygon(
                points={{90,0},{30,20},{30,-20},{90,0}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-115,155},{115,105}},
                textString="%name",
                lineColor={0,0,255})}));
      end Conversion;
    end Icons;

    package Conversions
    "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Package;

        type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
              final unit="degC")
          "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)"
                                                                                                              annotation(absoluteValue=true);

        type Angle_deg = Real (final quantity="Angle", final unit="deg")
          "Angle in degree";
        annotation (Documentation(info="<html>
<p>
This package provides predefined types, such as <b>Angle_deg</b> (angle in
degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <b>Scientific Unit Conversion - A
Practical Guide to Metrication</b> (Springer 1997).</p>
<p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>
</html>"),   Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          origin={15.0,51.8518},
          extent={{-105.0,-86.8518},{75.0,-16.8518}},
          lineColor={0,0,0},
          textString="[km/h]")}));
      end NonSIunits;

      function from_degC "Convert from degCelsius to Kelvin"
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-20,100},{-100,20}},
                lineColor={0,0,0},
                textString="degC"),  Text(
                extent={{100,-20},{20,-100}},
                lineColor={0,0,0},
                textString="K")}));
      end from_degC;
      annotation (                              Documentation(info="<html>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output
argument):</p>
<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>

</html>"));
    end Conversions;

    type Length = Real (final quantity="Length", final unit="m");

    type Area = Real (final quantity="Area", final unit="m2");

    type Time = Real (final quantity="Time", final unit="s");

    type Power = Real (final quantity="Power", final unit="W");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
      "Absolute temperature (use type TemperatureDifference for relative temperatures)"                   annotation(absoluteValue=true);

    type Temp_K = ThermodynamicTemperature;

    type Temperature = ThermodynamicTemperature;

    type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A");

    type Current = ElectricCurrent;

    type ElectricPotential = Real (final quantity="ElectricPotential", final unit=
           "V");

    type Voltage = ElectricPotential;

    type Resistance = Real (
        final quantity="Resistance",
        final unit="Ohm");

    type RadiantEnergyFluenceRate = Real (final quantity=
            "RadiantEnergyFluenceRate", final unit="W/m2");

    type FaradayConstant = Real (final quantity="FaradayConstant", final unit=
            "C/mol");
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-66,78},{-66,-40}},
            color={64,64,64}),
          Ellipse(
            extent={{12,36},{68,-38}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,78},{-66,-40}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,26},{58,-28}},
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
                {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{68,
                2}},
            lineColor={64,64,64},
            smooth=Smooth.Bezier,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package provides predefined types, such as <i>Mass</i>,
<i>Angle</i>, <i>Time</i>, based on the international standard
on units, e.g.,
</p>

<pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                     <b>final</b> unit     = \"rad\",
                     displayUnit    = \"deg\");
</pre>

<p>
Some of the types are derived SI units that are utilized in package Modelica
(such as ComplexCurrent, which is a complex number where both the real and imaginary
part have the SI unit Ampere).
</p>

<p>
Furthermore, conversion functions from non SI-units to SI-units and vice versa
are provided in subpackage
<a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
<li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
<li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br/>Some chapters realized.</li>
</ul>
</html>"));
  end SIunits;
annotation (
preferredView="info",
version="3.2.2",
versionBuild=3,
versionDate="2016-04-03",
dateModified = "2016-04-03 08:44:41Z",
revisionId="$Id:: package.mo 9263 2016-04-03 18:10:55Z #$",
uses(Complex(version="3.2.2"), ModelicaServices(version="3.2.2")),
conversion(
 noneFromVersion="3.2.1",
 noneFromVersion="3.2",
 noneFromVersion="3.1",
 noneFromVersion="3.0.1",
 noneFromVersion="3.0",
 from(version="2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")),
Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
  Polygon(
    origin={-6.9888,20.048},
    fillColor={0,0,0},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    points={{-93.0112,10.3188},{-93.0112,10.3188},{-73.011,24.6},{-63.011,31.221},{-51.219,36.777},{-39.842,38.629},{-31.376,36.248},{-25.819,29.369},{-24.232,22.49},{-23.703,17.463},{-15.501,25.135},{-6.24,32.015},{3.02,36.777},{15.191,39.423},{27.097,37.306},{32.653,29.633},{35.035,20.108},{43.501,28.046},{54.085,35.19},{65.991,39.952},{77.897,39.688},{87.422,33.338},{91.126,21.696},{90.068,9.525},{86.099,-1.058},{79.749,-10.054},{71.283,-21.431},{62.816,-33.337},{60.964,-32.808},{70.489,-16.14},{77.368,-2.381},{81.072,10.054},{79.749,19.05},{72.605,24.342},{61.758,23.019},{49.587,14.817},{39.003,4.763},{29.214,-6.085},{21.012,-16.669},{13.339,-26.458},{5.401,-36.777},{-1.213,-46.037},{-6.24,-53.446},{-8.092,-52.387},{-0.684,-40.746},{5.401,-30.692},{12.81,-17.198},{19.424,-3.969},{23.658,7.938},{22.335,18.785},{16.514,23.283},{8.047,23.019},{-1.478,19.05},{-11.267,11.113},{-19.734,2.381},{-29.259,-8.202},{-38.519,-19.579},{-48.044,-31.221},{-56.511,-43.392},{-64.449,-55.298},{-72.386,-66.939},{-77.678,-74.612},{-79.53,-74.083},{-71.857,-61.383},{-62.861,-46.037},{-52.278,-28.046},{-44.869,-15.346},{-38.784,-2.117},{-35.344,8.731},{-36.403,19.844},{-42.488,23.813},{-52.013,22.49},{-60.744,16.933},{-68.947,10.054},{-76.884,2.646},{-93.0112,-12.1707},{-93.0112,-12.1707}},
    smooth=Smooth.Bezier),
  Ellipse(
    origin={40.8208,-37.7602},
    fillColor={161,0,4},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    extent={{-17.8562,-17.8563},{17.8563,17.8562}})}),
Documentation(info="<html>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  provides an overview of the Modelica Standard Library
  inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  lists the contributors of the Modelica Standard Library.</li>
<li> The <b>Examples</b> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li><b>1600</b> models and blocks, and</li>
<li><b>1350</b> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2016, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.&nbsp;Haumer, ITI, C.&nbsp;Kral, Modelon,
TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>
<b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
</p>
</html>"));
end Modelica;

package BuildingSystems "Library for building energy and plant simulation"
  extends Modelica.Icons.Package;

  package Climate "Package with climate data and radiation calculation models"
    extends Modelica.Icons.Package;

    package Sources
      extends Modelica.Icons.SourcesPackage;

      model RadiationFixed
        "Boundary condition for constant direct and diffuse solar irradiation"
        BuildingSystems.Interfaces.RadiationPort radiationPort(
          IrrDir = IrrDir_constant,
          IrrDif = IrrDif_constant,
          angleDegInc = angleDegInc_constant)
          annotation (Placement(transformation(extent={{50,-10},{70,10}}), iconTransformation(extent={{50,-10},{70,10}})));
        parameter Modelica.SIunits.RadiantEnergyFluenceRate IrrDir_constant = 0.0
          "Constant area specific direct solar radiation";
        parameter Modelica.SIunits.RadiantEnergyFluenceRate IrrDif_constant = 0.0
          "Conatant area specific diffuse solar radiation";
        parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg angleDegInc_constant = 0.0
          "Constant incident angle of the direct solar radiation";
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-60,60},{60,-60}},lineColor={230,230,230},fillColor={230,230,230},
                fillPattern =                                                                                FillPattern.Solid),
          Text(extent={{-44,-56},{48,-84}},lineColor={0,0,255},fillColor={230,230,230},
                fillPattern =                                                                        FillPattern.Solid,textString
                  =                                                                                                                "%name"),
          Text(extent={{-58,40},{48,-38}},lineColor={255,128,0},textString="IrrDir,Idif,angleDegInc = const")}),
      Documentation(info="<html>
<p>
This model calculates a boundary condition for constant direct and diffuse solar irradiation.
</p>
</html>",       revisions="<html>
<ul>
<li>
May 23, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
      end RadiationFixed;
    end Sources;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
      Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0}),
      Line(points={{0,40},{0,70},{0,72}}, color={0,0,0}),
      Line(points={{0,-72},{0,-42},{0,-40}}, color={0,0,0}),
      Line(
        points={{0,-16},{0,14},{0,16}},
        color={0,0,0},
        origin={56,0},
        rotation=90),
      Line(
        points={{0,-16},{0,14},{0,16}},
        color={0,0,0},
        origin={-56,0},
        rotation=90),
      Line(
        points={{-28,28},{-54,52}},
        color={0,0,0},
        smooth=Smooth.Bezier),
      Line(
        points={{28,28},{52,50}},
        color={0,0,0},
        smooth=Smooth.Bezier),
      Line(
        points={{29,-28},{51,-50}},
        color={0,0,0},
        smooth=Smooth.Bezier),
      Line(points={{-30,-26},{-54,-50}}, color={0,0,0})}));
  end Climate;

  package Technologies "Package with models of building technologies"
    extends Modelica.Icons.Package;

    package Photovoltaics "Package with models of photovoltaic generators"
      extends Modelica.Icons.Package;

      package PVModules "Package with models of photovoltaic generators"
        extends Modelica.Icons.Package;

        model PVModuleComplex
          "Two diodes photovoltaic module model"
          extends
          BuildingSystems.Technologies.Photovoltaics.BaseClasses.PVModuleGeneral(
            angleDegTil_constant = 30,
            angleDegAzi_constant = 0.0);
          BuildingSystems.Technologies.Photovoltaics.BaseClasses.OpticalModels.OpticalModelSimple opticalModel
            "Optical model of the photovoltaic generator"
            annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
          BuildingSystems.Technologies.Photovoltaics.BaseClasses.ElectricalModels.ElectricalModelTwoDiodes electricalModel(
            nCelPar = pvModuleData.nCelPar,
            nCelSer = pvModuleData.nCelSer,
            Eg = pvModuleData.Eg,
            c1 = pvModuleData.c1,
            c2 = pvModuleData.c2,
            cs1 = pvModuleData.cs1,
            cs2= pvModuleData.cs2,
            RPar= pvModuleData.RPar,
            RSer= pvModuleData.RSer)
            "Electrical model of the photovoltaic generator"
            annotation (Placement(transformation(extent={{42,-6},{62,14}})));
          BuildingSystems.Technologies.Photovoltaics.BaseClasses.ThermalModels.ThermalModelSimple thermalModel(
            f = 0.043)
            "Thermal model of the photovoltaic generator"
            annotation (Placement(transformation(extent={{20,10},{40,30}})));
          Modelica.Blocks.Math.Gain gainP(k=nModSer*nModPar)
            annotation (Placement(transformation(extent={{60,6},{64,10}})));
          Modelica.Blocks.Math.Gain gainI(k=nModPar)
            annotation (Placement(transformation(extent={{72,-2},{76,2}})));
          input Modelica.Blocks.Interfaces.RealInput UField(unit="V")
            "Module voltage"
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,origin={60,60}), iconTransformation(extent={{-10,10},{10,-10}},rotation=180,origin={60,60})));
          Modelica.Blocks.Math.Gain gainU(k=1/nModSer)
            annotation (Placement(transformation(extent={{36,2},{40,6}})));
        equation
          if use_GSC_in then
             connect(opticalModel.GSC,GSC_in);
           else
             connect(opticalModel.GSC,GSC_constant);
          end if;
          connect(opticalModel.ITotRed, electricalModel.ITot)
            annotation (Line(points={{-1,0},{45,0}}, color={0,0,127}));
          connect(radiationPort, opticalModel.radiationPort) annotation (Line(points={{-18,80},{-18,80},{-18,0},{-14,0}}, color={0,0,0}));
          connect(electricalModel.P, gainP.u)
            annotation (Line(points={{57,8},{57,8},{59.6,8}}, color={0,0,127}));
          connect(electricalModel.I, gainI.u)
            annotation (Line(points={{57,0},{71.6,0}}, color={0,0,127}));
          connect(gainP.y, PField)
            annotation (Line(points={{64.2,8},{66,8},{66,30},{32,30},{32,80},{60,80}}, color={0,0,127}));
          connect(gainI.y, IField)
            annotation (Line(points={{76.2,0},{80,0},{80,34},{40,34},{40,40},{60,40}}, color={0,0,127}));
          connect(gainU.y, electricalModel.U)
            annotation (Line(points={{40.2,4},{45,4},{45,4}}, color={0,0,127}));
          connect(UField, gainU.u)
            annotation (Line(points={{60,60},{14,60},{14,4},{35.6,4}}, color={0,0,127}));
          connect(thermalModel.TCel, electricalModel.T)
            annotation (Line(points={{37,20},{40,20},{40,8},{45,8}}, color={0,0,127}));
          connect(TAmb, thermalModel.TAmb)
            annotation (Line(points={{20,84},{20,22.4},{23,22.4}}, color={0,0,127}));
          connect(opticalModel.ITotRed, thermalModel.ITot)
            annotation (Line(points={{-1,0},{10,0},{20,0},{20,18},{23,18}}, color={0,0,127}));

          annotation (defaultComponentName="pvmodule",
            Icon(graphics={Text(extent={{-48,60},{-16,30}},lineColor={255,255,255},
            fillColor={0,0,255},fillPattern=FillPattern.Solid,textString="C")}),
        Documentation(info="<html>
<p>
This is a two diodes model of a PV module.
</p>
</html>",         revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
        end PVModuleComplex;
      end PVModules;

      package Data "Data base with parameter sets of photovoltaic components"
        extends Modelica.Icons.Package;

        package PhotovoltaicModules "Data base with photovoltaic module types"

          record DataSetPhotovoltaicModule
            parameter Real c1(unit = "m2/V")
              "1st coefficient IPho";
            parameter Real c2(unit = "m2/(kV.K)")
              "2nd coefficient IPho";
            parameter Real cs1(unit = "A/K3")
              "1st coefficient ISat1";
            parameter Real cs2(unit = "A/(K5)")
              "2nd coefficient ISat2";
            parameter Real Eg(unit = "eV")
              "Band gap";
            parameter Modelica.SIunits.Length height
              "PV module height";
            parameter Modelica.SIunits.ElectricCurrent Ik0
              "Short circuit current under standard conditions";
            parameter Integer nCelSer
              "Number of serial connected cells within the PV module";
            parameter Integer nCelPar
              "Number of parallel connected cells within the PV module";
            parameter Modelica.SIunits.Power PEl_nominal
              "Module power under standard conditions";
            parameter Modelica.SIunits.Resistance RSer
              "Serial resistance";
            parameter Modelica.SIunits.Resistance RPar
              "Parallel resistance";
            parameter Real tIk0
              "Temperature coefficient for the short circuit current in mA/K";
            parameter Real tUl0
              "Temperature coefficient for the open circuit voltage in V/K";
            parameter Modelica.SIunits.Voltage Ul0
              "Open circuit voltage under standard conditions";
            parameter Modelica.SIunits.Length width
              "Module width";
          end DataSetPhotovoltaicModule;

          record SpectraVolt100M36S =   DataSetPhotovoltaicModule (
            PEl_nominal =  100.0,
            RPar = 7.85288688794,
            RSer = 0.0137310098788,
            c1 = 0.00504648450033,
            c2 = 0.000152415667759,
            cs1 = 34.4880957621,
            cs2 = 0.00463314157705,
            nCelSer = 36,
            nCelPar = 1,
            height = 1.195,
            width = 0.545,
            Ik0 = 5.53,
            Ul0 = 22.61,
            tIk0 = 1.659,
            tUl0 = -0.060,
            Eg = 1.107);
        end PhotovoltaicModules;

        package PhotovoltaicIVCurves

          record DataSetIVCurves
            parameter Modelica.SIunits.Temp_K TCel
              "Cell temperature during measurement";
            parameter Real ITot( unit = "W/m2")
              "Effective total solar irradiation on solar cell";
            parameter Modelica.SIunits.Current UI[:,:]
              "Discrete voltage values of the characteristic curve, from 0 to U10 and corresponding current";
          end DataSetIVCurves;

          record SpectraVolt100M36S =    DataSetIVCurves (
            TCel = 25.0,
            ITot = 1000.0,
            UI = [0,5.62;
                  0.1,5.62;
                  5,5.61;
                  10,5.6;
                  15,5.58;
                  15.4,5.57;
                  15.8,5.56;
                  16.2,5.55;
                  16.6,5.52;
                  17,5.49;
                  17.4,5.45;
                  17.8,5.38;
                  18.2,5.3;
                  18.6,5.18;
                  19,5.02;
                  19.4,4.81;
                  19.8,4.54;
                  20.2,4.18;
                  20.6,3.76;
                  21,3.24;
                  21.4,2.63;
                  21.8,1.94;
                  22.2,1.16;
                  22.6,0.3;
                  22.73,0]);
        end PhotovoltaicIVCurves;
      end Data;

      package Examples "Examples for photovoltaic component models"
        extends Modelica.Icons.ExamplesPackage;

        model IVCurveParameterOptimization
          "Example to optimize PV Module paramters (Rser, Rpar, c1, c2, cs1, cs2) with GenOpt"
          extends Modelica.Icons.Example;
          BuildingSystems.Technologies.Photovoltaics.PVModules.PVModuleComplex pvField(
            angleDegAzi_constant=0.0,
            nModPar=1,
            nModSer=1,
            angleDegTil_constant=0,
          redeclare Data.PhotovoltaicModules.SpectraVolt100M36S pvModuleData)
            annotation (Placement(transformation(extent={{-56,34},{-36,54}})));
          BuildingSystems.Technologies.Photovoltaics.Data.PhotovoltaicIVCurves.SpectraVolt100M36S IVcurve_ref
             "measured IV curve from data";
          Modelica.Blocks.Math.UnitConversions.From_degC from_degC
            annotation (Placement(transformation(extent={{-60,68},{-52,76}})));
          Climate.Sources.RadiationFixed constRadiation(IrrDir_constant=IVcurve_ref.ITot)
            "direct horizontal radiation on module surface"
            annotation (Placement(transformation(extent={{-80,52},{-64,68}})));
          Modelica.Blocks.Sources.Constant constTemp(k=IVcurve_ref.TCel)
            "Module temperature at test conditions"
            annotation (Placement(transformation(extent={{-76,68},{-68,76}})));
          Modelica.Blocks.Sources.TimeTable IVcurve_reference(table=IVcurve_ref.UI)
            annotation (Placement(transformation(extent={{-24,18},{-32,26}})));
          Modelica.Blocks.Sources.Constant constV(k=12)
            "Module temperature at test conditions";
          Modelica.Blocks.Sources.Ramp increasVoltage(height=pvField.pvModuleData.Ul0,
              duration=pvField.pvModuleData.Ul0)
            "Increasing voltage until open circuit voltage"
            annotation (Placement(transformation(extent={{-24,46},{-32,54}})));
        Modelica.Blocks.Math.MultiSum ISum(k={1,-1}, nu=2)
          annotation (Placement(transformation(extent={{-38,26},{-42,30}})));
        Modelica.Blocks.Math.Product Idiff_sq
          annotation (Placement(transformation(extent={{-46,26},{-50,30}})));
        Modelica.Blocks.Math.Sqrt sqrt1
          annotation (Placement(transformation(extent={{-58,26},{-62,30}})));
        Modelica.Blocks.Continuous.Integrator Idiff_sum
          annotation (Placement(transformation(extent={{-52,26},{-56,30}})));
        Interfaces.GenOptInterface genOptInterface
          annotation (Placement(transformation(extent={{-76,14},{-66,24}})));
        equation
          connect(pvField.TAmb, from_degC.y) annotation (Line(
              points={{-44,52},{-44,72},{-51.6,72}},
              color={0,0,0},
              smooth=Smooth.None));

          connect(constTemp.y, from_degC.u) annotation (Line(points={{-67.6,72},{-60.8,
                  72}},            color={0,0,127}));
          connect(pvField.radiationPort, constRadiation.radiationPort) annotation (Line(
                points={{-46,52},{-46,52},{-46,60},{-67.2,60}}, color={244,125,35}));
        connect(increasVoltage.y, pvField.UField) annotation (Line(points={{
                -32.4,50},{-32.4,50},{-40,50}}, color={0,0,127}));
        connect(Idiff_sq.u1, ISum.y) annotation (Line(points={{-45.6,29.2},{-44,
                29.2},{-44,28},{-42.34,28}}, color={0,0,127}));
        connect(Idiff_sq.u2, ISum.y) annotation (Line(points={{-45.6,26.8},{-44,
                26.8},{-44,28},{-42.34,28}}, color={0,0,127}));
        connect(pvField.IField, ISum.u[1]) annotation (Line(points={{-40,48},{
                -36,48},{-36,28.7},{-38,28.7}}, color={0,0,127}));
        connect(IVcurve_reference.y, ISum.u[2]) annotation (Line(points={{-32.4,
                22},{-36,22},{-36,27.3},{-38,27.3}}, color={0,0,127}));
        connect(Idiff_sq.y, Idiff_sum.u)
          annotation (Line(points={{-50.2,28},{-51.6,28}}, color={0,0,127}));
        connect(Idiff_sum.y, sqrt1.u)
          annotation (Line(points={{-56.2,28},{-57.6,28}}, color={0,0,127}));
        connect(sqrt1.y, genOptInterface.costFunction) annotation (Line(points=
                {{-62.2,28},{-68,28},{-71,28},{-71,23}}, color={0,0,127}));
            annotation (Placement(transformation(extent={{-20,68},{-28,76}})),
                     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,0},{-20,100}}), graphics={
            Text(extent={{-60,8},{-60,4}},  lineColor={0,0,255},fontSize=22,
                  textString="Model to run with GenOpt to calculate 
optimized PV module parameters.")}),
            experiment(StopTime=22.73),
            __Dymola_Commands(file=
                "Resources/Scripts/Dymola/Technologies/Photovoltaics/Examples/PVModuleParameterOpt.mos"
              "Simulate and plot"),
        Documentation(info="<html>
<p> This example tests the implementation of
<a href=\"modelica://BuildingSystems.Technologies.Photovoltaics.PVModuleComplex\">
BuildingSystems.Technologies.Photovoltaics.PVModuleComplex</a>.
</p>
</html>",         revisions="<html>
<ul>
<li>
March 7, 2015, by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
        end IVCurveParameterOptimization;
      end Examples;

      package BaseClasses
      "Package with base classes of photovoltaic components"
        extends Modelica.Icons.BasesPackage;

        partial model PVModuleGeneral
          "Basic photovoltaic module model"
          replaceable parameter BuildingSystems.Technologies.Photovoltaics.Data.PhotovoltaicModules.DataSetPhotovoltaicModule pvModuleData
            "Characteristic data of the PV module"
            annotation(Dialog(tab = "General", group = "Module characteristic"),Evaluate=true, choicesAllMatching=true);
          parameter Integer nModPar = 1
            "Number of parallel connected modules within one common orientation"
            annotation(Dialog(tab = "General"));
          parameter Integer nModSer = 1
            "Number of serial connected modules within one common orientation"
            annotation(Dialog(tab = "General"));
          parameter Boolean use_AngleDegTil_in = false
            "= true, use input for controlling the tilt angle of the PV module"
            annotation(Dialog(tab = "General", group = "Orientation"));
          BuildingSystems.Interfaces.Angle_degOutput angleDegTil_constant
            "Tilt angle of the PV module"
            annotation (Dialog(tab = "General", group = "Orientation"));
          BuildingSystems.Interfaces.Angle_degOutput angleDegTil
            "Tilt angle of the PV module"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,origin={-60,80}),
              iconTransformation(extent={{-10,-10},{10,10}},rotation=180,origin={-60,80})));
          parameter Boolean use_AngleDegAzi_in = false
            "= true, use input for controlling the azimuth angle of the PV module"
            annotation(Dialog(tab = "General", group = "Orientation"));
          BuildingSystems.Interfaces.Angle_degOutput angleDegAzi_constant
            "Azimuth angle of the PV module: South=0 deg West=90 deg East=-90 deg"
            annotation (Dialog(tab = "General", group = "Orientation"));
          BuildingSystems.Interfaces.Angle_degOutput angleDegAzi
            "Azimuth angle of the PV module: South=0 deg West=90 deg East=-90 deg"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,origin={-60,60}),  iconTransformation(extent={{-10,-10},{10,10}},rotation=180,origin={-60,60})));
          parameter Boolean use_GSC_in = false
            "= true, use input for geometric shading coefficient GSC"
            annotation(Dialog(tab = "General", group = "Shadowing"));
          Modelica.Blocks.Interfaces.RealOutput GSC_constant(min = 0.0, max = 1.0) = 0.0
            "Constant shading coefficient (if use_GSC_in = true)"
            annotation(Dialog(tab = "General", group = "Shadowing"));
          BuildingSystems.Interfaces.RadiationPort radiationPort "Radiation port"
            annotation (Placement(transformation(extent={{-10,70},{10,90}}), iconTransformation(extent={{-10,70},{10,90}})));
          input BuildingSystems.Interfaces.Temp_KInput TAmb
            "Environment air temperature"
            annotation(Placement(transformation(extent={{-10,10},{10,-10}},rotation=-90, origin={12,84}),
              iconTransformation(extent={{-10,10},{10,-10}},rotation=270,origin={20,80})));
          input Modelica.Blocks.Interfaces.RealInput GSC_in if use_GSC_in
            "Shading coefficient"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={30,84}),
              iconTransformation(extent={{-10,-10},{10,10}},rotation=270,origin={40,80})));
          Real etaMod
            "Efficiency of the PV Module";
          output BuildingSystems.Interfaces.PowerOutput PField
            "Power of the PV field"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={60,80}),iconTransformation(extent={{-10,-10},{10,10}},origin={60,80})));
          output Modelica.Blocks.Interfaces.RealOutput IField(unit="A")
            "Current of the PV field"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,40}), iconTransformation(extent={{-10,-10},{10,10}}, origin={60,40})));
          final Modelica.SIunits.Area AField = pvModuleData.height * pvModuleData.width * nModSer * nModPar
            "Area of the PV field";
          input Interfaces.Angle_degInput angleDegTil_in if use_AngleDegTil_in
            "Controlled tilt angle of the PV module"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-12,84}),
              iconTransformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-20,80})));
          input Interfaces.Angle_degInput angleDegAzi_in if use_AngleDegAzi_in
            "Controlled azimuth angle of the PV module"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-30,84}),
              iconTransformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-40,80})));
        protected
            Modelica.Blocks.Interfaces.RealInput GSC_internal
              "Shading coefficient";
            Modelica.Blocks.Interfaces.RealInput angleDegAzi_internal
              "Azimuth angle of the PV module: South=0 deg West=90 deg East=-90 deg";
            Modelica.Blocks.Interfaces.RealInput angleDegTil_internal
              "Tilt angle of the PV module";
        equation
          if use_GSC_in then
            connect(GSC_internal,GSC_in);
          else
            connect(GSC_internal,GSC_constant);
          end if;

          if use_AngleDegTil_in then
            connect(angleDegTil_internal,angleDegTil_in);
          else
            connect(angleDegTil_internal,angleDegTil_constant);
          end if;

          connect(angleDegTil_internal,angleDegTil);

          if use_AngleDegAzi_in then
            connect(angleDegAzi_internal,angleDegAzi_in);
          else
            connect(angleDegAzi_internal,angleDegAzi_constant);
          end if;

          connect(angleDegAzi_internal,angleDegAzi);

          etaMod = PField / ((radiationPort.IrrDif + radiationPort.IrrDir) * AField + 1.0e-6);

          annotation (Icon(graphics={Text(extent={{-38,-64},{46,-98}},lineColor={0,0,255},textString
                    =                                                                                 "%name"),
            Rectangle(extent={{-50,90},{50,-68}},lineColor={215,215,215},fillColor={215,215,215},
                  fillPattern =                                                                                FillPattern.Solid),
            Rectangle(extent={{-46,28},{-18,0}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                       FillPattern.Solid),
            Rectangle(extent={{-14,28},{14,0}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                      FillPattern.Solid),
            Rectangle(extent={{18,28},{46,0}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                     FillPattern.Solid),
            Rectangle(extent={{-46,-4},{-18,-32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                         FillPattern.Solid),
            Rectangle(extent={{-14,-4},{14,-32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                        FillPattern.Solid),
            Rectangle(extent={{18,-4},{46,-32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                       FillPattern.Solid),
            Rectangle(extent={{-46,-36},{-18,-64}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                          FillPattern.Solid),
            Rectangle(extent={{-14,60},{14,32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                       FillPattern.Solid),
            Rectangle(extent={{18,60},{46,32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                      FillPattern.Solid),
            Rectangle(extent={{-46,60},{-18,32}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                        FillPattern.Solid),
            Rectangle(extent={{-14,-36},{14,-64}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                         FillPattern.Solid),
            Rectangle(extent={{18,-36},{46,-64}},lineColor={0,0,255},fillColor={0,0,255},
                  fillPattern =                                                                        FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Basic photovoltaic module model which defines the common variables and equations.
</p>
</html>",         revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
        end PVModuleGeneral;

        package ElectricalModels
        "Package with electrical models of photovoltaic modules"
          extends Modelica.Icons.Package;

          partial model ElectricalModelGeneral
            "Basic electrical model of a PV module"
            parameter Integer nCelPar
              "Number of parallel connected cells within the PV module";
            parameter Integer nCelSer
              "Number of serial connected cells within the PV module";
            parameter Real Eg(unit = "eV")
              "Band gap";
            input BuildingSystems.Interfaces.Temp_KInput T
              "Cell temperature"
              annotation (Placement(transformation(extent={{-100,10},{-60,50}}), iconTransformation(extent={{-80,30},{-60,50}})));
            input BuildingSystems.Interfaces.RadiantEnergyFluenceRateInput ITot
              "Effective total solar irradiation on solar cell"
              annotation (Placement(transformation(extent={{-100,-70},{-60,-30}}),iconTransformation(extent={{-80,-50},{-60,-30}})));
            output BuildingSystems.Interfaces.PowerOutput P
              "Module power"
              annotation (Placement(transformation(extent={{60,30},{80,50}}), iconTransformation(extent={{60,30},{80,50}})));
            output Modelica.Blocks.Interfaces.RealOutput I(unit="A", start = 0.0)
              "Module current"
              annotation (Placement(transformation(extent={{60,-50},{80,-30}}), iconTransformation(extent={{60,-50},{80,-30}})));
            Modelica.SIunits.Voltage Ut
              "Temperature voltage";
          protected
            final constant Real e(unit = "A.s") = Modelica.Constants.F/Modelica.Constants.N_A
              "Elementary charge";
            final constant Real k(unit = "J/K") = Modelica.Constants.R/Modelica.Constants.N_A
              "Boltzmann constant";
          equation
            Ut = k * T / e;

            annotation (    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,100}}), graphics={
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={28,108,200}),
              Line(points={{0,40},{-20,0},{20,12},{0,-40}},color={28,108,200},thickness=0.5),
              Polygon(points={{0,-40},{0,-20},{14,-26},{0,-40}},lineColor={28,108,200},
              lineThickness=0.5,fillColor={0,0,255},fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>
This is a basic electrical model of a PV module.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end ElectricalModelGeneral;

          model ElectricalModelTwoDiodes
            "Electrical two diodes model of a PV module"
            extends
            BuildingSystems.Technologies.Photovoltaics.BaseClasses.ElectricalModels.ElectricalModelTwoDiodesGeneral;
            input Modelica.Blocks.Interfaces.RealInput U(unit="V")
              "Module voltage"
              annotation (Placement(transformation(extent={{-98,-28},{-60,10}}),iconTransformation(extent={{-10,-10},{10,10}},origin={-70,0})));
          equation
            0 = IPho - ISat1 * (Modelica.Math.exp((U / nCelSer + (I / nCelPar) * RSer)/(1.0 * Ut)) - 1.0)
              - ISat2 * (Modelica.Math.exp((U / nCelSer + (I / nCelPar) * RSer)/(2.0 * Ut)) - 1.0)
              - (U / nCelSer + (I / nCelPar) * RSer) / RPar - I / nCelPar;
            P = I * U;

            annotation (
          Documentation(info="<html>
<p>
This is an electrical two diodes model of a PV module.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end ElectricalModelTwoDiodes;

          partial model ElectricalModelTwoDiodesGeneral
            "Basic electrical two diodes model of a PV module"
            extends
            BuildingSystems.Technologies.Photovoltaics.BaseClasses.ElectricalModels.ElectricalModelGeneral;
            parameter Real c1(unit = "m2/V")
              "1st coefficient IPho";
            parameter Real c2(unit = "m2/(kV.K)")
              "2nd coefficient IPho";
            parameter Real cs1(unit = "A/K3")
              "1st coefficient ISat1";
            parameter Real cs2(unit = "A/K5")
              "2nd coefficient ISat2";
            parameter Real RPar(unit = "V/A")
              "Parallel resistance";
            parameter Real RSer(unit = "V/A")
              "Serial resistance";
            Modelica.SIunits.ElectricCurrent IPho
              "Photo current";
            Modelica.SIunits.ElectricCurrent ISat1
              "Saturation current diode 1";
            Modelica.SIunits.ElectricCurrent ISat2
              "Saturation current diode 2";

          equation
            IPho = (c1 + c2 * 0.001 * T) * ITot;

            ISat1 = cs1 * T * T * T * Modelica.Math.exp(-(Eg * e)/(k * T));

            ISat2 = cs2 * sqrt(T * T * T * T * T) * Modelica.Math.exp(-(Eg * e)/(2.0 * k * T));

            annotation (
          Documentation(info="<html>
<p>
This is a basic electrical two diodes model of a PV module.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end ElectricalModelTwoDiodesGeneral;
        end ElectricalModels;

        package OpticalModels
        "Package with optical models of photovoltaic modules"
          extends Modelica.Icons.Package;

          partial model OpticalModelGeneral
            "Optical model calculates the reduction of the solar irradiation between the surface of the PV module and the PV cell"
            input Modelica.Blocks.Interfaces.RealInput GSC(min=0.0,max=1.0)
              "Geometrical shading coefficient"
              annotation (Placement(transformation(extent={{-88,0},{-48,40}}), iconTransformation(extent={{-68,20},{-48,40}})));
            output BuildingSystems.Interfaces.RadiantEnergyFluenceRateOutput ITotRed
              "Reduced total solar radiation on module plane inclusive shading effects."
              annotation (Placement(transformation(extent={{60,-10},{80,10}}),iconTransformation(extent={{60,-10},{80,10}})));
            BuildingSystems.Interfaces.RadiationPort radiationPort
              "Solar radiation on module plane"
              annotation (Placement(transformation(extent={{-70,-10},{-50,10}}), iconTransformation(extent={{-70,-10},{-50,10}})));

            annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={28,108,200}),
              Rectangle(extent={{-2,40},{2,-40}},lineColor={28,108,200},fillColor={0,0,255},fillPattern=FillPattern.Solid),
              Line(points={{-40,0},{-2,0}},color={255,255,0},arrow={Arrow.None,Arrow.Filled},thickness=0.5)}),
          Documentation(info="<html>
<p>
Basic optical model that calculates the reduction of the solar irradiation between the surface
of the PV module and the PV cell.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end OpticalModelGeneral;

          model OpticalModelSimple
            "Simplified calculation of the overall solar radiation for the PV cell"
            extends
            BuildingSystems.Technologies.Photovoltaics.BaseClasses.OpticalModels.OpticalModelGeneral;
          equation
            ITotRed = radiationPort.IrrDir * (1.0 - GSC) + radiationPort.IrrDif;

            annotation (
          Documentation(info="<html>
<p>
Optical model that calculates the reduction of the solar irradiation between the surface
of the PV module and the PV cell.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end OpticalModelSimple;
        end OpticalModels;

        package ThermalModels "Thermal models for PV modules"
          extends Modelica.Icons.Package;

          model ThermalModelSimple
            "Simplified thermal model based on a empirical equation for the cell temperature"
            parameter Real f(unit="K.m2/W")
              "Empirical temperature factor";
            BuildingSystems.Interfaces.Temp_KInput TAmb
              "Ambient temperature"
              annotation (Placement(transformation(extent={{-20,-20},{20,20}},origin={-68,20}), iconTransformation(extent={{-80,14},{-60,34}})));
            BuildingSystems.Interfaces.RadiantEnergyFluenceRateInput ITot
              "Total irradiation in module plane"
              annotation (Placement(transformation(extent={{-20,-20},{20,20}},origin={-68,-40}), iconTransformation(extent={{-80,-30},{-60,-10}})));
            BuildingSystems.Interfaces.Temp_KOutput TCel
              "Cell temperature"
               annotation (Placement(transformation(extent={{-20,-20},{20,20}},origin={80,0}), iconTransformation(extent={{60,-10},{80,10}})));
          equation
            TCel = TAmb + f * ITot;
            annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Simplified thermal model that calculates the cell temperature based on a empirical equation.
</p>
</html>",           revisions="<html>
<ul>
<li>
March 1, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end ThermalModelSimple;
        end ThermalModels;
      end BaseClasses;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),                                                                        graphics={
        Polygon(points={{-26,-78},{76,40},{86,32},{-16,-86},{-26,-78}},lineColor={0,0,0}),
        Ellipse(extent={{-90,90},{-38,38}}, lineColor={0,0,0}),
        Line(points={{-26,30},{22,-12}}, color={0,0,0}),
        Line(points={{-6,52},{42,10}}, color={0,0,0}),
        Line(points={{-70,-20},{-22,-62}}, color={0,0,0}),
        Line(points={{14,74},{62,32}}, color={0,0,0}),
        Line(points={{-48,4},{0,-38}}, color={0,0,0}),
        Line(points={{70,-18},{44,-48},{74,-58},{52,-86}}, color={0,0,0}),
        Polygon(points={{50,-90},{52,-72},{66,-84},{50,-90}},
        lineColor={0,0,0},fillColor={0,0,0},fillPattern=FillPattern.Solid)}));
    end Photovoltaics;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-80,66},{-10,-56}},
        lineColor={0,0,0},
        lineThickness=0.5),
      Line(
        points={{-58,66},{-58,-56}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-34,66},{-34,-56}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-80,36},{-10,36}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-80,6},{-10,6}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-80,-24},{-10,-24}},
        color={0,0,0},
        smooth=Smooth.None),
      Rectangle(
        extent={{20,64},{70,-56}},
        lineColor={0,0,0},
        lineThickness=0.5),
      Line(
        points={{20,64},{70,-56}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{20,-56},{70,64}},
        color={0,0,0},
        smooth=Smooth.None)}));
  end Technologies;

  package Interfaces
  "Package with base and complex connector types of the library"
    extends Modelica.Icons.InterfacesPackage;

    connector Angle_degInput = Modelica.Blocks.Interfaces.RealInput(final quantity="Angle_deg",final unit="deg",displayUnit="deg");

    connector Angle_degOutput = Modelica.Blocks.Interfaces.RealOutput(final quantity="Angle_deg",final unit="deg",displayUnit="deg");

    connector PowerOutput = Modelica.Blocks.Interfaces.RealOutput(final quantity="Power", final unit="W", displayUnit="W");

    connector RadiantEnergyFluenceRateInput =
      Modelica.Blocks.Interfaces.RealInput (                                       final quantity="RadiantEnergyFluenceRate",final unit="W/m2", displayUnit="W/m2");

    connector RadiantEnergyFluenceRateOutput =
        Modelica.Blocks.Interfaces.RealOutput (final quantity="RadiantEnergyFluenceRate",final unit="W/m2", displayUnit="W/m2");

    connector RadiationPort
      "Port for solar radiation transport, small icon to be used for single RadiationPort (base connector type)"
      extends BuildingSystems.Interfaces.RadiationPortGeneral;
      annotation(defaultComponentName = "radiationPort",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Ellipse(extent={{-100,100},{100,-100}}, fillColor={255,128,0},fillPattern
                =                                                               FillPattern.Solid,pattern=LinePattern.None)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Text(extent={{-110,110},{110,50}},lineColor={0,0,255},textString="%name",
                fillPattern =                                                                FillPattern.Solid,fillColor={255,185,0}),
      Ellipse(extent={{-40,40},{40,-40}},fillColor={255,128,0},fillPattern=FillPattern.Solid,pattern=LinePattern.None)}));
    end RadiationPort;

    connector RadiationPortGeneral
      "Port for solar radiation transport (base connector type)"
      Modelica.SIunits.RadiantEnergyFluenceRate IrrDir
        "Area specific direct solar radiation";
      Modelica.SIunits.RadiantEnergyFluenceRate IrrDif
        "Area specific diffuse solar radiation";
      Modelica.SIunits.Conversions.NonSIunits.Angle_deg angleDegInc
        "Incident angle of the direct solar radiation";
        annotation(Documentation(info="<HTML>
      <p>This connector is used for the solar radiation transport between components.
      The variables in the connector are:</p>
      <pre>
        IrrDir direct solar radiation energy fluent rate in [W/m2],
        IrrDif diffuse solar radiation energy fluent rate in [W/m2],
      </pre>
      <p>According to the Modelica sign convention, a <b>positive</b> mass flow
      rate <b>m_flow</b> is considered to flow <b>into</b> a component. This
      convention has to be used whenever this connector is used in a model
      class.</p></HTML>"));
    end RadiationPortGeneral;

    connector Temp_KInput = Modelica.Blocks.Interfaces.RealInput(final quantity="ThermodynamicTemperature",final unit="K",min = 0.0, displayUnit="degC");

    connector Temp_KOutput = Modelica.Blocks.Interfaces.RealOutput(final quantity="ThermodynamicTemperature",final unit="K",min = 0.0, displayUnit="degC");

    model GenOptInterface "Text file output for use with GenOpt"
      parameter String resultFileName = "result.txt"
        "File on which data is present";
      parameter String header = "Objective function value" "Header for result file";
      parameter String File = "00_InfoFile_after_GenOpt.txt"
        "File on which data is present";
      Modelica.Blocks.Interfaces.RealInput costFunction
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,80})));
    initial algorithm
     if (resultFileName <> "") then
      Modelica.Utilities.Files.removeFile(resultFileName);
     end if;
     Modelica.Utilities.Streams.print(fileName=resultFileName,string=header);
     if (File <> "") then
      Modelica.Utilities.Files.removeFile(File);
     end if;
    equation
     when terminal() then Modelica.Utilities.Streams.print("f(x) = " +    realString(number=costFunction, minimumWidth=10, precision=20), resultFileName);
        // INFORMATION FILE
        Modelica.Utilities.Streams.print("-------------------------------------------------", File);
        Modelica.Utilities.Streams.print("f(x):                       " +  realString(number=costFunction, minimumWidth=10, precision=20), File);
      end when;
    end GenOptInterface;
  end Interfaces;
  annotation (
    version="2.0.0-beta",
    versionBuild=0,
    versionDate="2017-04-10",
    dateModified = "2017-04-10",
    uses(Modelica(version="3.2.2"),NcDataReader2(version="2.4.0")),
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),graphics={
    Polygon(points={{-34,62},{0,88},{30,62},{-34,62}},lineColor={0,0,0},fillColor={135,135,135},
          fillPattern =                                                                                     FillPattern.Solid),
    Rectangle(extent={{-34,62},{30,12}},lineColor={0,0,0},fillColor={135,135,135},
          fillPattern =                                                                       FillPattern.Solid),
    Ellipse(extent={{-40,-40},{-12,-68}}, lineColor={0,0,0}),
    Rectangle(extent={{-2,-50},{42,-58}}, lineColor={0,0,0}),
    Rectangle(extent={{48,2},{76,-32}}, lineColor={0,0,0}),
    Line(points={{-64,-54},{-64,32},{-34,32}},color={0,0,0},smooth=Smooth.None),
    Line(points={{30,32},{62,32},{62,2}},color={0,0,0},smooth=Smooth.None),
    Line(points={{42,-54},{62,-54},{62,-32}},color={0,0,0},smooth=Smooth.None),
    Line(points={{-12,-54},{-2,-54}},color={0,0,0},smooth=Smooth.None),
    Line(points={{-64,-54},{-40,-54}},color={0,0,0},smooth=Smooth.None),
    Line(points={{-40,-54},{-24,-40}},color={0,0,0},smooth=Smooth.None),
    Line(points={{-40,-54},{-26,-68}},color={0,0,0},smooth=Smooth.None)}),
Documentation(info="<html>
<p>
The <code>BuildingSystems</code> library is a free library
for building energy and plant simulation.
</p>
<p>
The web page for this library is
<a href=\"http://www.modelica-buildingsystems.de\">http://www.modelica-buildingsystems.de</a>.
</p>
</html>"));
end BuildingSystems;

model BuildingSystems_Technologies_Photovoltaics_Examples_IVCurveParameterOptimization
 extends BuildingSystems.Technologies.Photovoltaics.Examples.IVCurveParameterOptimization;
  annotation(experiment(StopTime=22.73),uses(BuildingSystems(version="2.0.0-beta")));
end
  BuildingSystems_Technologies_Photovoltaics_Examples_IVCurveParameterOptimization;
