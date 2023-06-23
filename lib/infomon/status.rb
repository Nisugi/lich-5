# API for char Status
# todo: should include jaws / condemn / others?

require "ostruct"

module Status
  def self.bound?
    Infomon.get_bool("status.bound")
  end

  def self.calmed?
    Infomon.get_bool("status.calmed")
  end

  def self.cutthroat?
    Infomon.get_bool("status.cutthroat")
  end

  def self.silenced?
    Infomon.get_bool("status.silenced")
  end

  def self.sleeping?
    Infomon.get_bool("status.sleeping")
  end

  # deprecate these in global_defs after warning, consider bringing other status maps over
  def self.webbed?
    XMLData.indicator['IconDEAD'] == 'y'
  end

  def self.dead?
    XMLData.indicator['IconDEAD'] == 'y'
  end

  def self.stunned?
    XMLData.indicator['IconSTUNNED'] == 'y'
  end

  def self.muckled?
    muckled = Status.webbed? || Status.dead? || Status.stunned?
    muckled = muckled || Status.silenced? || Status.sleeping?
    muckled = muckled || Status.cutthroat? || Status.calmed?
    muckled = muckled || Status.bound?
    return muckled
  end

  # todo: does this serve a purpose?
  def self.serialize
    [self.bound?, self.calmed?, self.cutthroat?,
     self.silenced?, self.sleeping?]
  end
end
