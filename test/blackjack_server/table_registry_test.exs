defmodule BlackjackServer.TableRegistryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, registry} = BlackjackServer.TableRegistry.start_link(context.test)
    {:ok, registry: registry}
  end

  test "spawns tables", %{registry: registry} do
    assert BlackjackServer.TableRegistry.lookup(registry, "test table") == :error

    BlackjackServer.TableRegistry.create(registry, "test table")
    assert {:ok, table} = BlackjackServer.TableRegistry.lookup(registry, "test table")

    # TODO: remove these
    BlackjackServer.Table.put(table, "milk", 1)
    assert BlackjackServer.Table.get(table, "milk") == 1
  end

  test "removes tables on exit", %{registry: registry} do
    BlackjackServer.TableRegistry.create(registry, "test table")
    {:ok, table} = BlackjackServer.TableRegistry.lookup(registry, "test table")
    Agent.stop(table)
    assert BlackjackServer.TableRegistry.lookup(registry, "test table") == :error
  end

  test "removes table on crash", %{registry: registry} do
    BlackjackServer.TableRegistry.create(registry, "test table")
    {:ok, table} = BlackjackServer.TableRegistry.lookup(registry, "test table")

    # Stop the table with non-normal reason
    Process.exit(table, :shutdown)

    # Wait until the table is dead
    ref = Process.monitor(table)
    assert_receive {:DOWN, ^ref, _, _, _}

    assert BlackjackServer.TableRegistry.lookup(registry, "test table") == :error
  end
end
